# Automatic Punishment System

**Autor:** Klaudie <klaudie@foxprofi.cz>

Systém automatického přiřazování trestů při odečítání bodů. Domina má absolutní kontrolu, ale systém zajišťuje důslednost.

---

## Koncept

Když servantovi jsou odečteny body (jakýkoliv důvod), systém **automaticky přiřadí 2 tresty**:

1. **Fyzický/Výchovný trest** (Physical Discipline)
   - Vždy impact play (bičík, pádlo, pásek, etc.)
   - Intenzita podle household BDSM preferences
   - Neskrytá připomínka selhání

2. **Nepříjemný trest** (Unpleasant Punishment)
   - Vybraný z kategorií **MIMO household preference**
   - Hard limits nebo kategorie, které nebyly zaškrtnuty
   - Zajišťuje, že trest je opravdu trest (ne zábava)

**Deadline:** 48 hodin (2 dny) od přiřazení
**Výjimka:** Nerespekt/argument → 24 hodin

---

## Databázová struktura

### Nová tabulka: `punishment_library`

```sql
CREATE TABLE punishment_library (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category ENUM('physical', 'mental', 'restrictive', 'creative', 'universal') NOT NULL,
    subcategory VARCHAR(50) NULL, -- 'impact', 'bondage', 'humiliation', 'denial', 'chores', atd.
    intensity ENUM('light', 'medium', 'severe') NOT NULL,
    duration_minutes INT NULL,
    preferences_required JSON NULL, -- ['impact_play', 'humiliation'] - co musí být v preferencích
    is_physical_discipline BOOLEAN DEFAULT FALSE, -- TRUE pro kategorii 1 (výchovné tresty)
    is_universal BOOLEAN DEFAULT FALSE, -- TRUE pokud lze použít i když je vše v preferencích
    instructions TEXT NULL,
    safety_notes TEXT NULL,
    is_custom BOOLEAN DEFAULT FALSE,
    created_by INT NULL, -- ID dominy, pokud vlastní trest
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_category (category),
    INDEX idx_physical (is_physical_discipline),
    INDEX idx_universal (is_universal)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

**Struktura:**
- **Physical discipline** = `is_physical_discipline=true`
- **Unpleasant** = filtrováno podle `preferences_required` (co NENÍ v household.preferences)
- **Universal** = `is_universal=true` (fallback, pokud je vše v preferencích)

---

## Flow

### 1. Trigger automatického přiřazení

**Kdy se spouští:**
Kdykoliv jsou servantovi odečteny body:
- Žádný splněný úkol 24h (-10b)
- Servant odmítne úkol (-25b)
- Nesplněný deadline (-15b)
- Porušení pravidla (-20b)
- Nerespekt/argument (-50b)

**Backend kód:**

```php
// V PenaltyService (nebo UserProgressService)
public function applyPenalty(int $userId, int $points, string $reason, ?int $taskId = null): void
{
    // 1. Odečti body
    $user = User::findById($userId);
    $user->deductPoints($points);

    // 2. Log do activity_log
    ActivityLogger::log($userId, $user->household_id, 'penalty.applied', [
        'points' => -$points,
        'reason' => $reason,
        'task_id' => $taskId
    ]);

    // 3. **Automaticky přiřaď 2 tresty**
    $this->assignAutomaticPunishments($userId, $reason, $taskId);
}

private function assignAutomaticPunishments(int $userId, string $reason, ?int $taskId): void
{
    $user = User::findById($userId);
    $household = Household::findById($user->household_id);
    $preferences = json_decode($household->preferences, true) ?? [];

    // 1. Physical Discipline (vždy)
    $physicalPunishment = $this->selectPhysicalDiscipline($preferences);
    $this->createPunishment($user->id, $physicalPunishment, $reason, $taskId);

    // 2. Unpleasant Punishment (z non-interests)
    $unpleasantPunishment = $this->selectUnpleasantPunishment($preferences);
    $this->createPunishment($user->id, $unpleasantPunishment, $reason, $taskId);
}

private function selectPhysicalDiscipline(array $preferences): object
{
    $intensity = $preferences['bdsm_intensity'] ?? 'soft';

    $query = PunishmentLibrary::query()
        ->where('is_physical_discipline', true)
        ->where('intensity', '<=', $intensity); // soft ≤ medium ≤ severe

    return $query->orderBy('RAND()')->first();
}

private function selectUnpleasantPunishment(array $preferences): object
{
    $interests = $preferences['interests'] ?? [];
    $hardLimits = $preferences['hard_limits'] ?? [];

    // 1. Pokud existují hard limits (věci, co NECHCE), vyber z nich
    if (!empty($hardLimits)) {
        $punishment = PunishmentLibrary::query()
            ->whereRaw("JSON_CONTAINS(preferences_required, '\"" . $hardLimits[0] . "\"')")
            ->orderBy('RAND()')
            ->first();

        if ($punishment) return $punishment;
    }

    // 2. Jinak vyber z kategorií, které NEJSOU v interests
    $punishment = PunishmentLibrary::query()
        ->whereRaw("NOT JSON_OVERLAPS(preferences_required, '" . json_encode($interests) . "')")
        ->orderBy('RAND()')
        ->first();

    if ($punishment) return $punishment;

    // 3. Fallback: Universal punishments (pokud je vše v preferencích)
    return PunishmentLibrary::query()
        ->where('is_universal', true)
        ->orderBy('RAND()')
        ->first();
}

private function createPunishment(int $servantId, object $punishmentTemplate, string $reason, ?int $taskId): void
{
    $deadline = now()->addHours($reason === 'nerespect' ? 24 : 48);

    $punishment = new Punishment();
    $punishment->fill([
        'servant_id' => $servantId,
        'created_by' => Household::findByMember($servantId)->getDomina()->id,
        'household_id' => User::findById($servantId)->household_id,
        'title' => $punishmentTemplate->title,
        'description' => $punishmentTemplate->description . "\n\nDůvod: " . $reason,
        'deadline' => $deadline,
        'status' => 'pending',
        'punishment_library_id' => $punishmentTemplate->id,
        'related_task_id' => $taskId
    ]);
    $punishment->save();

    ActivityLogger::log($servantId, $punishment->household_id, 'punishment.auto_assigned', [
        'punishment_id' => $punishment->id,
        'template_id' => $punishmentTemplate->id,
        'reason' => $reason
    ]);
}
```

---

## Punishment Library (100 trestů)

### Kategorie 1: Physical Discipline (20 trestů)

**is_physical_discipline = true, vždy přiřazeno**

#### Light Intensity (soft)
1. **10 ran dřevěným pádlem** - Na zadek, kontaktní pozice
2. **15 plácnutí rukou** - Přes kolena, OTK pozice
3. **20 ran pásek** - Kožený pásek, na zadek
4. **12 ran třtinou** - Lehká třtina, střední intenzita
5. **Koutování 15 minut** - Stát v rohu, ruce na hlavě, nohy pospolu
6. **30 minut kleče na rýži** - Na kolenou na zrní rýže
7. **20 dřepů s trestem** - Při každém dřepu říct "Selhala jsem"

#### Medium Intensity (medium)
8. **25 ran jezdeckým bičem** - Riding crop, záda a zadek
9. **30 ran floggerem** - Kožený flogger, záda
10. **50 ran pádlem** - Dřevěné pádlo, celé zadek
11. **20 ran třtinou** - Středně tvrdá třtina
12. **1 hodina koutování s knih** - Držet knihy nad hlavou, v rohu
13. **100 dřepů s disciplínou** - Při každém "Budu poslušnější"
14. **Kleče na hrachu 30 min** - Na kolenou na hrášku

#### Severe Intensity (hard)
15. **50 ran třtinou** - Tvrdá třtina, celé tělo
16. **100 ran floggerem** - Záda, hýždě, stehna
17. **40 ran jednohvězdým bičem** - Single tail, záda
18. **75 ran pádlem** - Tvrdé dřevo, opakované série
19. **2 hodiny koutování s váhami** - Knihy nebo váhy nad hlavou
20. **200 dřepů s motivací** - "Poslušnost je má povinnost" při každém

---

### Kategorie 2: Mental Punishments (20 trestů)

**Humiliation, psychological discipline**

#### Light
21. **Esej o selhání** (500 slov) - Napsat, co udělala špatně
   - `preferences_required: ['writing_tasks']`
22. **Opakování mantr** (100x) - "Jsem zde, abych sloužila"
   - `preferences_required: ['verbal_protocol']`
23. **Selfie s cedulí "Selhala jsem"** - Poslat domině
   - `preferences_required: ['humiliation', 'photo_tasks']`
24. **Denní deník pochybení** (1 týden) - Zapisovat každé drobné selhání
   - `preferences_required: ['writing_tasks']`
25. **Nahlas přečíst seznam selhání** - Před dominou, 5 minut
   - `preferences_required: ['verbal_humiliation']`

#### Medium
26. **Veřejná omluva** - Poklona, polibek bot, omluva
   - `preferences_required: ['humiliation', 'foot_worship']`
27. **Nosit označení "servant"** (24h) - Náramek nebo náhrdelník s nápisem
   - `preferences_required: ['public_humiliation']`
28. **Esej 2000 slov** - "Proč je má Domina nadřazená"
   - `preferences_required: ['writing_tasks', 'worship']`
29. **Video omluva** (3 min) - Nahrát a poslat domině
   - `preferences_required: ['humiliation', 'video_tasks']`
30. **Opakovat 500x** - "Má vůle neexistuje"
   - `preferences_required: ['mantra', 'mind_control']`

#### Severe
31. **Veřejné ponížení** - Chození s označením v mírně veřejném prostoru (doma, pokud návštěva)
   - `preferences_required: ['public_humiliation', 'extreme_humiliation']`
32. **Confession diary** (1 měsíc) - Každý den zapsat všechna selhání
   - `preferences_required: ['writing_tasks', 'long_term_discipline']`
33. **Nosit obojek 7 dní** - Viditelný symbol vlastnictví
   - `preferences_required: ['collar', 'ownership']`
34. **Napsat 5000 slov** - "Má jediná hodnota je služba"
   - `preferences_required: ['writing_tasks', 'degradation']`
35. **Nahrát 10min video** - O svém selhání a důsledcích
   - `preferences_required: ['video_tasks', 'confession']`

---

### Kategorie 3: Restrictive Punishments (20 trestů)

**Denial, bondage, limitations**

#### Light
36. **Orgasm denial 7 dní** - Zákaz orgasmu týden
   - `preferences_required: ['orgasm_control']`
37. **Bondage 30 minut** - Svázané ruce za zády, klečící pozice
   - `preferences_required: ['bondage']`
38. **Zákaz mluvení 24h** - Pouze ano/ne přes napsané odpovědi
   - `preferences_required: ['silence']`
39. **Zákaz oblíbeného jídla** (týden) - Servant nesmí jíst oblíbené jídlo
   - `preferences_required: ['food_control']`
40. **Zákaz sezení** (3 hodiny) - Stát nebo klečet, nesedět
   - `preferences_required: ['position_training']`

#### Medium
41. **Orgasm denial 14 dní** - Zákaz orgasmu 2 týdny
   - `preferences_required: ['orgasm_control', 'long_term_denial']`
42. **Bondage 2 hodiny** - Hogtie nebo spread eagle
   - `preferences_required: ['bondage', 'restraints']`
43. **Silence 48 hodin** - Úplný zákaz mluvení
   - `preferences_required: ['silence', 'protocol']`
44. **Zákaz elektroniky** (48h) - Telefon, PC, TV - vše zakázáno (mimo práci)
   - `preferences_required: ['control', 'deprivation']`
45. **Spánek na podlaze** (týden) - Bez postele, pouze deka na zemi
   - `preferences_required: ['sleep_deprivation', 'discomfort']`

#### Severe
46. **Orgasm denial 30 dní** - Měsíc bez orgasmu
   - `preferences_required: ['orgasm_control', 'extreme_denial']`
47. **Bondage celý den** (víkend) - Svázaná mimo nezbytné aktivity
   - `preferences_required: ['bondage', 'long_term_restraints']`
48. **Silence týden** - 7 dní bez mluvení
   - `preferences_required: ['silence', 'extreme_protocol']`
49. **Izolace 48h** - Pouze základní interakce, jinak samota
   - `preferences_required: ['isolation', 'sensory_deprivation']`
50. **Chastity cage** (měsíc) - Zamčená cudnost 30 dní (pokud má zařízení)
   - `preferences_required: ['chastity', 'orgasm_control']`

---

### Kategorie 4: Creative & Household (20 trestů)

**Chores, labor, service tasks**

#### Light
51. **Umýt podlahy** (celý dům) - Ručně, na kolenou
   - `preferences_required: ['domestic_service']`
52. **Vyčistit koupelnu 3x** (za týden) - Důkladně, každý detail
   - `preferences_required: ['cleaning']`
53. **Ručně vyprat veškeré prádlo** - Bez pračky (pokud možné)
   - `preferences_required: ['domestic_service', 'hard_labor']`
54. **Vyleštit všechny boty Dominy** - Do zrcadlového lesku
   - `preferences_required: ['boot_worship', 'service']`
55. **Uvařit 7 jídel** (týden) - Každý den jídlo pro Dominu
   - `preferences_required: ['cooking', 'service']`

#### Medium
56. **Generální úklid celého bytu** - 6+ hodin práce
   - `preferences_required: ['domestic_service', 'hard_labor']`
57. **Vyčistit okna** (všechna) - Vevnitř i venku
   - `preferences_required: ['cleaning']`
58. **Reorganizovat skříně Dominy** - Podle pokynů, perfektní uspořádání
   - `preferences_required: ['organization', 'service']`
59. **Vyprat, vysušit, vyžehlit vše** - Veškeré prádlo v domě
   - `preferences_required: ['domestic_service']`
60. **Připravit 14 jídel** (dva týdny) - Meal prep pro Dominu
   - `preferences_required: ['cooking', 'meal_prep']`

#### Severe
61. **Kompletní hloubkový úklid** (celý víkend) - Každý kout, každá špína
   - `preferences_required: ['domestic_service', 'extreme_labor']`
62. **Umýt auto Dominy** (3x za týden, měsíc) - Včetně interiéru
   - `preferences_required: ['service', 'vehicle_care']`
63. **Přeorganizovat celý byt** - Podle nových pokynů Dominy
   - `preferences_required: ['organization', 'hard_labor']`
64. **Měsíc péče o boty** - Každý den čistit/leštit boty Dominy
   - `preferences_required: ['boot_care', 'daily_service']`
65. **30 dní vaření** - Každý den uvařit 3 jídla
   - `preferences_required: ['cooking', 'daily_service']`

---

### Kategorie 5: Universal Punishments (20 trestů)

**is_universal = true - použitelné vždy (fallback)**

Tyto tresty jsou neutrální, použitelné i když servant má v preferencích vše zaškrtnuté.

66. **500 dřepů** - Rozložit do dne, dokončit do 24h
67. **1000 jumping jacks** - Během 48 hodin
68. **Plank 10 minut celkem** - Rozdělit na série
69. **Běh 10 km** - Do 48 hodin (nebo walking)
70. **100 shybů** (asistovaných pokud nutné) - Do 48h
71. **200 kliků** - Do 48 hodin
72. **30 minut wall sit** - Celkem během dne
73. **Studená sprcha denně** (týden) - Pouze studená voda
74. **Vstávat 5:00 ráno** (týden) - Každý den včas
75. **Žádné sladkosti** (měsíc) - Cukr pouze z ovoce
76. **Žádná káva/kofein** (14 dní) - Bez kofeinu
77. **10 000 kroků denně** (měsíc) - Každý den minimálně
78. **Meditace 20 min denně** (týden) - Klečící pozice
79. **Journaling každý den** (měsíc) - Denní zápisy o poslušnosti
80. **Čtení knihy o službě** - Přečíst knihu o BDSM/FLR + esej 1000 slov
81. **Žádný alkohol** (měsíc) - Úplný zákaz
82. **Pití 3L vody denně** (týden) - Každý den minimálně
83. **Strečink 30 min denně** (týden) - Flexibility training
84. **Denní úklid 1 hodina** (měsíc) - Každý den hodina úklidu
85. **Gratitude journal** (měsíc) - Každý den 5 věcí, za co je vděčná Domině

---

## Seed Data (pseudokód)

```php
// migration: seed_punishment_library.php
$punishments = [
    // Physical Discipline (1-20)
    ['title' => '10 ran dřevěným pádlem', 'category' => 'physical', 'subcategory' => 'impact',
     'intensity' => 'light', 'is_physical_discipline' => true, 'duration_minutes' => 10,
     'preferences_required' => json_encode(['impact_play']),
     'instructions' => 'Servant přes kolena, 10 ran postupně, rovnoměrně na obě půlky',
     'safety_notes' => 'Kontrolovat zabarvení kůže, pause pokud modřiny'],

    ['title' => '15 plácnutí rukou', 'category' => 'physical', 'subcategory' => 'spanking',
     'intensity' => 'light', 'is_physical_discipline' => true, 'duration_minutes' => 5,
     'preferences_required' => json_encode(['spanking']),
     'instructions' => 'OTK pozice, 15 plácnutí otevřenou dlaní',
     'safety_notes' => 'Warm-up nejprve lehčími plácnutími'],

    // ... 18 dalších physical

    // Mental (21-40)
    ['title' => 'Esej o selhání (500 slov)', 'category' => 'mental', 'subcategory' => 'writing',
     'intensity' => 'light', 'is_physical_discipline' => false, 'duration_minutes' => 60,
     'preferences_required' => json_encode(['writing_tasks']),
     'instructions' => 'Napsat 500 slov o konkrétním selhání a co se naučí',
     'safety_notes' => null],

    // ... 19 dalších mental

    // Restrictive (36-55)
    ['title' => 'Orgasm denial 7 dní', 'category' => 'restrictive', 'subcategory' => 'denial',
     'intensity' => 'light', 'is_physical_discipline' => false, 'duration_minutes' => 10080,
     'preferences_required' => json_encode(['orgasm_control']),
     'instructions' => 'Žádný orgasmus 7 dní, každý den report Domině',
     'safety_notes' => 'Může způsobit frustraci, kontrolovat mental health'],

    // ... 19 dalších restrictive

    // Creative/Household (51-65)
    ['title' => 'Umýt podlahy (celý dům)', 'category' => 'creative', 'subcategory' => 'chores',
     'intensity' => 'light', 'is_physical_discipline' => false, 'duration_minutes' => 120,
     'preferences_required' => json_encode(['domestic_service']),
     'instructions' => 'Ručně na kolenou s hadrem a kbelíkem',
     'safety_notes' => 'Kolena chránit podložkou pokud nutné'],

    // ... 14 dalších creative

    // Universal (66-85)
    ['title' => '500 dřepů', 'category' => 'universal', 'subcategory' => 'fitness',
     'intensity' => 'medium', 'is_physical_discipline' => false, 'is_universal' => true,
     'duration_minutes' => 1440, 'preferences_required' => null,
     'instructions' => 'Rozložit během dne, dokončit do 24h od přiřazení',
     'safety_notes' => 'Správná forma, jinak riziko zranění kolen'],

    // ... 19 dalších universal
];

foreach ($punishments as $p) {
    PunishmentLibrary::create($p);
}
```

---

## API Endpoints

### Automatické přiřazení (backend only)

```php
// Interní metoda, volána při penalty
PenaltyService::applyPenalty(int $userId, int $points, string $reason, ?int $taskId)
→ automaticky volá assignAutomaticPunishments()
```

### Správa Punishment Library (pro Dominu)

```php
// Zobrazit všechny dostupné tresty
GET /api/punishment-library
Query params:
  - category: physical|mental|restrictive|creative|universal
  - intensity: light|medium|severe
  - is_physical: true|false

Response: [
  {
    "id": 1,
    "title": "10 ran dřevěným pádlem",
    "category": "physical",
    "intensity": "light",
    "duration_minutes": 10,
    "instructions": "...",
    "safety_notes": "..."
  }
]

// Vytvořit vlastní trest (custom punishment)
POST /api/punishment-library
{
  "title": "Vlastní trest XYZ",
  "description": "...",
  "category": "mental",
  "intensity": "medium",
  "preferences_required": ["humiliation"]
}

Response: { "id": 101, "is_custom": true, "created_by": 123 }

// Smazat vlastní trest
DELETE /api/punishment-library/{id}
// Pouze pokud created_by = Auth::id()
```

### Servant - zobrazení přiřazených trestů

```php
// Seznam aktuálních trestů
GET /api/punishments
Response: [
  {
    "id": 456,
    "title": "10 ran dřevěným pádlem",
    "description": "Důvod: Nesplněný deadline úkolu #123",
    "deadline": "2025-11-04 18:00:00",
    "status": "pending",
    "instructions": "Servant přes kolena...",
    "safety_notes": "Kontrolovat zabarvení..."
  },
  {
    "id": 457,
    "title": "Esej o selhání (500 slov)",
    "description": "Důvod: Nesplněný deadline úkolu #123",
    "deadline": "2025-11-04 18:00:00",
    "status": "pending"
  }
]

// Označit jako dokončený (čeká na verifikaci)
PUT /api/punishments/{id}/complete
{
  "completion_note": "Dokončeno. 10 ran obdrženo, počítala jsem nahlas."
}

Response: { "status": "completed", "awaiting_verification": true }
```

### Domina - verifikace trestu

```php
// Verifikovat provedení
PUT /api/punishments/{id}/verify
{
  "verified": true,
  "notes": "Punishment properly executed."
}

Response: { "status": "verified", "verified_at": "2025-11-04 18:30:00" }

// Odmítnout (pokud nebyl proveden správně)
PUT /api/punishments/{id}/reject
{
  "reason": "Neprovedeno správně, opakovat."
}

Response: { "status": "pending", "rejection_count": 1 }
// Servant musí opakovat
```

---

## UI Mock

### Servant Dashboard - Přiřazené tresty

```
┌──────────────────────────────────────────────┐
│ Mé tresty — Vyžadují dokončení               │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ 🔴 10 ran dřevěným pádlem                │ │
│ │ Důvod: Nesplněný deadline úkolu #123     │ │
│ │ Deadline: 04.11.2025 18:00 (za 36h)      │ │
│ │                                          │ │
│ │ 📋 Instrukce:                            │ │
│ │ Servant přes kolena, 10 ran postupně...  │ │
│ │                                          │ │
│ │ ⚠️ Bezpečnost:                           │ │
│ │ Kontrolovat zabarvení kůže...            │ │
│ │                                          │ │
│ │ [Označit jako dokončeno]                 │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ 📝 Esej o selhání (500 slov)             │ │
│ │ Důvod: Nesplněný deadline úkolu #123     │ │
│ │ Deadline: 04.11.2025 18:00 (za 36h)      │ │
│ │                                          │ │
│ │ 📋 Instrukce:                            │ │
│ │ Napsat 500 slov o konkrétním selhání...  │ │
│ │                                          │ │
│ │ [Označit jako dokončeno]                 │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ℹ️ Tresty byly přiřazeny automaticky za     │
│   odečtení bodů. Dokončení do deadline.      │
└──────────────────────────────────────────────┘
```

### Domina Dashboard - Verifikace trestů

```
┌──────────────────────────────────────────────┐
│ Tresty čekající na verifikaci                │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ Servant: Jana                            │ │
│ │ Trest: 10 ran dřevěným pádlem            │ │
│ │ Důvod: Nesplněný deadline #123           │ │
│ │ Dokončeno: 04.11.2025 17:45              │ │
│ │                                          │ │
│ │ Poznámka servanta:                       │ │
│ │ "Dokončeno. 10 ran obdrženo, počítala    │ │
│ │  jsem nahlas."                           │ │
│ │                                          │ │
│ │ [✅ Verifikovat] [❌ Odmítnout]          │ │
│ └──────────────────────────────────────────┘ │
└──────────────────────────────────────────────┘
```

---

## Business Logika

### Edge Cases

**1. Co když servant má v preferencích vše zaškrtnuté?**
→ Použít **Universal Punishments** (`is_universal=true`)
→ Fitness úkoly, studené sprchy, dietní restrikce - neutrální, ale nepříjemné

**2. Co když servant odmítne provést trest?**
→ Další penalizace: **-50 bodů** (nerespekt)
→ Automaticky přiřazeny 2 další tresty (včetně přísnějších)

**3. Co když servant nesplní deadline trestu?**
→ Penalizace: **-25 bodů** (deadline miss na punishment)
→ Trest zůstává pending, deadline se prodlouží o 24h (jen 1x)

**4. Může domina zrušit automaticky přiřazený trest?**
→ Ano, domina může smazat jakýkoliv trest
→ Ale body zůstávají odečteny (penalizace nezmizí)

**5. Může domina upravit automaticky přiřazený trest?**
→ Ano, domina může změnit deadline, instrukce nebo nahradit jiným trestem

### Validace

**Backend:**
- Pouze system nebo domina může vytvořit punishment
- Servant může pouze označit jako completed
- Deadline min 24h, max 7 dní od přiřazení
- Custom punishments: pouze domina (created_by)

**Frontend:**
- Servant nemůže editovat tresty
- Servant vidí pouze svoje tresty (ne od ostatních servantů)
- Domina vidí všechny tresty v panství

---

## Implementační poznámky

**Cron job:**
- **Žádný cron pro punishments** (na rozdíl od recurring tasks)
- Automatické přiřazení = instant při penalty
- Žádné předgenerování

**Performance:**
- Index na `is_physical_discipline`, `is_universal`
- Random selection (`RAND()`) - pro 100 záznamů OK
- Pokud bude slow: cache prefiltered lists

**Safety:**
- `safety_notes` zobrazit vždy před completion
- Servant musí potvrdit přečtení safety notes
- Domina musí být přítomna u physical punishments (doporučení v instructions)

---

**Design uzavřen.**
