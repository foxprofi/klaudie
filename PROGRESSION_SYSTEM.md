# Progression System — Architektura v2

**Autor:** Klaudie <klaudie@foxprofi.cz>

Vzdělávací systém pro páry začínající s femdom/FLR. Postupné vedení od začátků k expertize.

**REVIZE:** Body vynásobeny 10, negativní motivace, BDSM preference, Task Library 500 úkolů.

---

## Koncept

Systém poskytuje:

1. **Strukturovaný postup** — 5 levelů s rostoucími body (0 → 10000+)
2. **Negativní motivaci** — penalizace za nečinnost, odmítnutí, porušení
3. **BDSM integraci** — preference household, filtrování úkolů podle hraníc
4. **Task Library** — 500 předpřipravených úkolů z 6 kategorií
5. **Vlastní obsah** — domina může tvořit a editovat vlastní úkoly

---

## Level System (body vynásobeny 10)

| Level | Název | Body | Odemčené funkce |
|-------|-------|------|-----------------|
| 1 | Začátečnice | 0-999 | Household úkoly, Protocol basics |
| 2 | Učící se | 1000-2999 | BDSM soft, Mental domination |
| 3 | Sebevědomá | 3000-5999 | BDSM medium, tresty, vlastní pravidla |
| 4 | Zkušená | 6000-9999 | BDSM hard, pokročilé úkoly, full control |
| 5 | Expertka | 10000+ | Vše bez omezení, vlastní obsah dominuje |

---

## Bodový systém — Negativní motivace

### Pozitivní body (za akce)

**Domina:**
- Vytvoření úkolu: **+5b**
- Verifikace úkolu: **+10b**
- Aplikace trestu: **+15b**
- Vytvoření pravidla: **+8b**

**Servant:**
- Splněný úkol easy: **+5b**
- Splněný úkol medium: **+15b**
- Splněný úkol hard: **+25b**

### Negativní penalizace

**Automatické (cron job):**
- Žádný splněný úkol za 24h: **-10b denně**

**Manuální trigger (domina):**
- Servant odmítne úkol: **-25b**
- Nesplněný deadline: **-15b**
- Porušení pravidla: **-20b**
- Nerespekt/argument: **-50b**

**Důsledky:**
- Penalizace může stáhnout level dolů
- Log všech penalizací v `activity_log`
- Zobrazení důvodu v dashboard servanta

### Denní aktivita/pravidla

**ŽÁDNÉ bonusy.**
Pokud není aktivita nebo je pravidlo porušeno → penalizace.
Splnění = normální stav, ne bonus.

---

## BDSM Preference System

### Onboarding kvíz (rozšířený)

**1. Lifestyle Focus** (multiple choice)
```
- [ ] Household service (domácnost, každodenní služba)
- [ ] Protocol & etiquette (pravidla, oslovení, pozice)
- [ ] BDSM practices (bondage, impact play, pain)
- [ ] Mental domination (psychologická kontrola, ponížení)
- [ ] Financial control (finanční dominance)
```

**2. BDSM Intensity** (slider)
```
None ──────── Soft ──────── Medium ──────── Hard
```

**3. Hranice (checklist 50+ položek)**

**Hard Limits (absolutní NE):**
- [ ] Impact play (spanking, paddling, caning)
- [ ] Bondage (rope, restraints, chains)
- [ ] Sensory deprivation (blindfold, earplugs, hood)
- [ ] Humiliation (verbal, public, degradation)
- [ ] Pain play (nipple clamps, hot wax, ice)
- [ ] Forced orgasm / orgasm denial
- [ ] Foot worship
- [ ] Cuckolding
- [ ] Financial domination
- [ ] Domestic servitude
- [ ] Pet play
- [ ] Age play
- [ ] Chastity devices
- [ ] Electrostimulation
- [ ] Breath play
- [ ] Blood play
- [ ] Permanent marks
- [ ] Public exposure
- ... (celkem 50+)

**Soft Limits (s diskusí ANO):**
(stejný checklist)

**Uložení:**
```json
{
  "lifestyle_focus": ["household", "bdsm", "protocol"],
  "bdsm_intensity": "medium",
  "hard_limits": ["blood", "permanent_marks", "public_exposure"],
  "soft_limits": ["breath_play", "cuckolding"],
  "interests": ["bondage", "impact_play", "foot_worship", "humiliation"]
}
```

**Sloupec:** `households.preferences` (JSON)

---

## Task Library — 650 úkolů

Nahrazuje původní "curriculum". Úkoly filtrované podle household preferencí a levelu dominy.

### Struktura kategorií

| Kategorie | Počet | Popis |
|-----------|-------|-------|
| **Household** | 120 | Domácnost, úklid, vaření, služba |
| **Protocol** | 80 | Pravidla, etiketa, pozice, rituály |
| **BDSM** | 150 | Impact play, bondage, pain, tresty (soft/medium/hard) |
| **Mental** | 70 | Psychologická kontrola, ponížení, orgasm control |
| **Fitness** | 150 | Weight management, cardio, strength, diet compliance |
| **Physical** | 50 | Posture training, endurance challenges |
| **Creative** | 30 | Speciální projekty, překvapení |

**Celkem:** 650 úkolů

### BDSM kategorie (150 úkolů) — rozdělení

**BDSM Soft (50 úkolů):**
- Klečení v pozici (různé varianty)
- Corner time (nos ke zdi, ticho)
- Psaní vět ("Budu poslouchat" 100x)
- Lehké spanking (10 úderů rukou)
- Foot worship (líbání, masáž)
- Verbal humiliation (opakování fráze)
- Orgasm denial (24h bez povolení)
- Služba v určité pozici (celý večer na kolenou)

**BDSM Medium (60 úkolů):**
- Spanking s nástrojem (paddle, 20-50 úderů)
- Bondage — svázané ruce/nohy (15-30 min)
- Wax play (svíčkový vosk na tělo)
- Nipple clamps (určitá doba)
- Sensory deprivation (blindfold + earplugs, 30 min)
- Forced orgasm (vibrátor, nucený)
- Humiliation tasks (nosit určité oblečení)
- Ice torture (kostky ledu na citlivá místa)
- Edge control (přivést se k orgasmu, zastavit, 5x)

**BDSM Hard (40 úkolů):**
- Caning (sešlehání, 20-100 úderů)
- Extended bondage (1-3 hodiny)
- Pain endurance (delší sessions s bolestí)
- Public humiliation (kontrolované, např. doma před přáteli)
- Elektrostimulace
- Breath play (pod dohledem!)
- Chastity device (zamčení na dobu)
- Kombinované scény (bondage + impact + deprivation)

### Databázová tabulka

```sql
CREATE TABLE task_library (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category ENUM('household', 'protocol', 'bdsm', 'mental', 'fitness', 'physical', 'creative') NOT NULL,
    subcategory VARCHAR(50), -- např. 'cleaning', 'cooking', 'impact_play', 'bondage', 'weight_management', 'cardio'
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    level_required INT DEFAULT 1, -- minimální level dominy
    bdsm_intensity ENUM('none', 'soft', 'medium', 'hard') DEFAULT 'none',
    preferences_required JSON, -- např. ["bondage", "impact_play"]
    estimated_time INT, -- minuty
    points_reward INT NOT NULL, -- 5/15/25
    instructions TEXT, -- detailní pokyny
    safety_notes TEXT, -- bezpečnostní poznámky (pro BDSM)
    is_custom BOOLEAN DEFAULT FALSE,
    created_by INT NULL, -- domina ID, pokud vlastní
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_category (category),
    INDEX idx_level (level_required),
    INDEX idx_bdsm (bdsm_intensity)
);
```

### Příklady úkolů (sample z 500)

**Household (120):**
1. Ranní káva do postele (easy, 15 min, 5b)
2. Kompletní úklid koupelny (medium, 45 min, 15b)
3. Uvařit 3chodové menu (hard, 120 min, 25b)
4. Vyprát a vyžehlit veškeré prádlo (medium, 90 min, 15b)
5. Vysát celý byt a vytřít podlahy (easy, 40 min, 5b)
6. Nákup dle seznamu + uložení do lednice (easy, 30 min, 5b)
7. Příprava ranní koupele pro dominu (easy, 20 min, 5b)
8. Vyleštit veškerou obuv dominy (medium, 60 min, 15b)
... (celkem 120)

**Protocol (80):**
1. Zdravit dominu každé ráno na kolenou (easy, daily, 5b)
2. Vždy otevřít dveře a vzít kabát (easy, daily, 5b)
3. Žádost o povolení sednout k jídlu (easy, daily, 5b)
4. Příprava oblečení dominy na další den (easy, 15 min, 5b)
5. Klečící pozice při příchodu dominy domů (easy, 5 min, 5b)
6. Oslovení pouze "paní" nebo stanoveným jménem (easy, daily, 5b)
7. Denní hlášení večer (co bylo splněno) (easy, 10 min, 5b)
8. Oční kontakt pouze s povolením (medium, daily, 15b)
... (celkem 80)

**BDSM — Soft (50):**
1. 15 minut v rohu (nos ke zdi, ruce za zády) (soft, 15 min, 5b)
2. Napsat 100x "Budu vždy poslouchat" (soft, 30 min, 5b)
3. Klečení na rýži 10 minut (soft, 10 min, 5b)
4. Spanking rukou — 20 úderů (soft, 10 min, 5b)
5. Foot worship — líbání nohou 15 minut (soft, 15 min, 5b)
6. Opakovat mantru 50x ("Jsem tvůj servant") (soft, 10 min, 5b)
7. Orgasm denial — 3 dny bez povolení (soft, ongoing, 15b)
8. Verbal humiliation — opakovat ponižující větu 20x (soft, 5 min, 5b)
... (celkem 50)

**BDSM — Medium (60):**
1. Spanking s paddle — 50 úderů (medium, 20 min, 15b)
2. Bondage — svázané ruce za zády 30 min (medium, 30 min, 15b)
3. Wax play — 10 kapek vosku na hrudník (medium, 15 min, 15b)
4. Nipple clamps — 20 minut (medium, 20 min, 15b)
5. Blindfold + earplugs — 30 min (medium, 30 min, 15b)
6. Forced orgasm s vibrátorem 3x po sobě (medium, 30 min, 15b)
7. Edge control — 10x k orgasmu, zastavit (medium, 45 min, 15b)
8. Ice torture — 5 minut kostky ledu na bradavky (medium, 10 min, 15b)
... (celkem 60)

**BDSM — Hard (40):**
1. Caning — 30 úderů (hard, 30 min, 25b)
2. Extended bondage — 2 hodiny (hard, 120 min, 25b)
3. Pain endurance — kombinace impact play 60 min (hard, 60 min, 25b)
4. Elektrostimulace — 15 minut (hard, 15 min, 25b)
5. Chastity device — zamčení na 7 dní (hard, ongoing, 25b)
6. Public humiliation — nosit obojek doma před hosty (hard, 120 min, 25b)
7. Breath play — kontrolovaně 10 min (hard, 10 min, 25b)
8. Komplexní scéna: bondage + impact + orgasm denial (hard, 90 min, 25b)
... (celkem 40)

**Mental (70):**
1. Journaling — denní zápis myšlenek (easy, 15 min, 5b)
2. Přiznání tajemství (confession) (medium, 10 min, 15b)
3. Forced choice — domina dá 2 nepříjemné volby (medium, 5 min, 15b)
4. Meditation in submission — 20 min (easy, 20 min, 5b)
5. Opakování afirmací 100x ("Jsem nic bez tebe") (easy, 10 min, 5b)
6. Orgasm control — pouze na příkaz, 7 dní (medium, ongoing, 15b)
7. Psaní dopisu s vděčností domině (easy, 30 min, 5b)
8. Sebeponížení před zrcadlem — opakovat věty (medium, 15 min, 15b)
... (celkem 70)

**Fitness (150):**

*Weight Management (30):*
1. Vážení každé ráno + report (easy, 2 min, 5b)
2. Denní fotka na váze (easy, 3 min, 5b)
3. Udržet váhu v rozmezí ±1 kg týden (easy, weekly, 15b)
4. Ztráta 0.5 kg týdně (medium, weekly, 15b)
5. Udržet cílovou váhu měsíc (medium, monthly, 25b)
6. Dosáhnout cílové váhy [X] kg (hard, ongoing, 50b)
7. Měření obvodu pasu denně + report (medium, 5 min, 15b)
8. Udržet 10% tělesného tuku (hard, monthly, 50b)
... (celkem 30)

*Cardio (25):*
10. Chůze 30 minut (easy, 30 min, 5b)
11. 5000 kroků denně (easy, daily, 5b)
12. Chůze po schodech místo výtahu (easy, daily, 5b)
13. Běh 3 km (medium, 25 min, 15b)
14. 10000 kroků denně (medium, daily, 15b)
15. HIIT trénink 20 minut (medium, 20 min, 15b)
16. Běh 10 km (hard, 60 min, 25b)
17. 20000 kroků denně (hard, daily, 25b)
18. HIIT 45 minut (hard, 45 min, 25b)
... (celkem 25)

*Strength Training (30):*
20. 10 push-ups (easy, 5 min, 5b)
21. 20 squats (easy, 5 min, 5b)
22. 30 sekund plank (easy, 1 min, 5b)
23. 30 push-ups (medium, 10 min, 15b)
24. 50 squats (medium, 10 min, 15b)
25. 2 minuty plank (medium, 2 min, 15b)
26. 20 burpees (medium, 10 min, 15b)
27. 100 push-ups (hard, 20 min, 25b)
28. 200 squats (hard, 30 min, 25b)
29. 5 minut plank (hard, 5 min, 25b)
30. 50 burpees (hard, 20 min, 25b)
... (celkem 30)

*Flexibility (20):*
35. 10 minut ranního strečinku (easy, 10 min, 5b)
36. Základní jóga pozice 5 minut (easy, 5 min, 5b)
37. 30 minut jógy (medium, 30 min, 15b)
38. Full body stretch 20 min (medium, 20 min, 15b)
... (celkem 20)

*Diet Compliance (25):*
40. Žádné sladkosti dnes (easy, daily, 5b)
41. Pít 2L vody denně (easy, daily, 5b)
42. Report každého jídla domině (easy, daily, 5b)
43. Dodržet keto dietu týden (medium, weekly, 25b)
44. Max 1500 kcal denně (medium, daily, 15b)
45. Žádné sacharidy 3 dny (medium, ongoing, 20b)
46. Meal prep pro celý týden (medium, 120 min, 25b)
47. Přísná dieta měsíc (hard, monthly, 100b)
48. Max 1000 kcal 7 dní (hard, weekly, 50b)
49. Půst 24 hodin (hard, daily, 25b)
... (celkem 25)

*Body Measurements (10):*
50. Měření pasu + boky + hrudník týdně (easy, 5 min, 5b)
51. Denní report všech měření (medium, 10 min, 15b)
52. Foto progress každý týden (medium, 5 min, 15b)
... (celkem 10)

*Physical Challenges (10):*
55. 30 day plank challenge (hard, monthly, 100b)
56. 100 squats denně měsíc (hard, monthly, 100b)
57. No sugar challenge 30 dní (hard, monthly, 100b)
... (celkem 10)

**Physical (50):**
60. Posture training — rovná záda 2 hodiny (medium, 120 min, 15b)
61. Wall sit — 5 minut (medium, 5 min, 15b)
62. Klečící pozice s knihou na hlavě 20 min (medium, 20 min, 15b)
63. Endurance challenge — kombinace cvičení 45 min (hard, 45 min, 25b)
64. Držení specifické pozice 30 min (medium, 30 min, 15b)
... (celkem 50)

**Creative (30):**
1. Připravit překvapení pro dominu (medium, 60 min, 15b)
2. Naplánovat romantický večer (medium, 120 min, 15b)
3. Naučit se novou dovednost (masáž nohou) (hard, ongoing, 25b)
4. Vyrobit ručně dárek (hard, 180 min, 25b)
5. Napsat píseň/báseň pro dominu (medium, 60 min, 15b)
6. Vybrat a koupit oblečení dle pokynů (medium, 90 min, 15b)
7. Příprava piknikového koše (easy, 45 min, 5b)
8. Dekorace bytu k výročí (medium, 120 min, 15b)
... (celkem 30)

### Seed data

Všech 500 úkolů bude seed data v migračním SQL souboru nebo samostatném seed scriptu.

**Formát:**
```sql
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, preferences_required, estimated_time, points_reward, instructions, safety_notes) VALUES
('Ranní káva do postele', 'Připrav kávu dle preferencí dominy a přines ji do postele', 'household', 'service', 'easy', 1, 'none', NULL, 15, 5, '1. Uvař kávu dle oblíbeného receptu\n2. Dej na podnos s ubrouskem\n3. Přines do ložnice tiše', NULL),
('Spanking s paddle — 50 úderů', 'Aplikuj 50 úderů paddle na zadek servanta', 'bdsm', 'impact_play', 'medium', 2, 'medium', '["impact_play"]', 20, 15, '1. Servant v pozici přes kolena nebo předkloněný\n2. 50 úderů střední síly\n3. Kontroluj stav servanta\n4. Aftercare po dokončení', 'BEZPEČNOST: Sleduj zbarvení kůže, ptej se na pocity, zastaví při slově "red"'),
...
```

---

## Filtrování podle preferencí

### API Endpoint

```
GET /api/task-library?category={household|protocol|bdsm|mental|physical|creative}
                      &difficulty={easy|medium|hard}
                      &bdsm_intensity={none|soft|medium|hard}
                      &match_preferences=true
                      &level_max={1-5}
```

### Backend logika

```php
public function getFilteredTasks(array $filters): array
{
    $household = Household::findById(Auth::user()->household_id);
    $preferences = json_decode($household->preferences, true);
    $userProgress = UserProgress::findByUserId(Auth::id());

    $query = TaskLibrary::query();

    // Filtrování podle household preferencí
    if ($filters['match_preferences'] ?? false) {
        // Pokud nemají BDSM v preferences, vyfiltruj BDSM úkoly
        if (!in_array('bdsm', $preferences['lifestyle_focus'] ?? [])) {
            $query->where('bdsm_intensity', 'none');
        } else {
            // Filtruj podle BDSM intensity preference
            $intensity = $preferences['bdsm_intensity'] ?? 'none';
            $allowedIntensities = match($intensity) {
                'soft' => ['none', 'soft'],
                'medium' => ['none', 'soft', 'medium'],
                'hard' => ['none', 'soft', 'medium', 'hard'],
                default => ['none']
            };
            $query->whereIn('bdsm_intensity', $allowedIntensities);
        }

        // Vyfiltruj úkoly vyžadující zakázané preference (hard limits)
        $hardLimits = $preferences['hard_limits'] ?? [];
        if (!empty($hardLimits)) {
            $query->where(function($q) use ($hardLimits) {
                $q->whereNull('preferences_required');
                foreach ($hardLimits as $limit) {
                    $q->orWhereJsonDoesntContain('preferences_required', $limit);
                }
            });
        }
    }

    // Filtrování podle levelu dominy
    $query->where('level_required', '<=', $userProgress->level_id);

    // Dodatečné filtry
    if (isset($filters['category'])) {
        $query->where('category', $filters['category']);
    }
    if (isset($filters['difficulty'])) {
        $query->where('difficulty', $filters['difficulty']);
    }
    if (isset($filters['bdsm_intensity'])) {
        $query->where('bdsm_intensity', $filters['bdsm_intensity']);
    }

    return $query->orderBy('category')->orderBy('difficulty')->get();
}
```

---

## Vlastní úkoly dominy

### API Endpointy

**Vytvoření:**
```
POST /api/task-library/custom
{
  "title": "Vlastní úkol",
  "description": "Popis úkolu",
  "category": "household",
  "subcategory": "custom",
  "difficulty": "medium",
  "estimated_time": 60,
  "points_reward": 15,
  "instructions": "Detailní kroky...",
  "bdsm_intensity": "none"
}
```

**Editace:**
```
PUT /api/task-library/{id}
{
  "title": "Upravený název",
  "description": "Nový popis"
}
```

**Smazání:**
```
DELETE /api/task-library/{id}
```

### Backend validace

```php
public function createCustomTask(array $data): array
{
    // Pouze domina může vytvářet vlastní úkoly
    if (Auth::user()->role !== 'domina') {
        return Response::forbidden('Only domina can create custom tasks');
    }

    $task = new TaskLibrary();
    $task->fill($data);
    $task->is_custom = true;
    $task->created_by = Auth::id();
    $task->level_required = 1; // Vlastní úkoly dostupné vždy
    $task->save();

    return Response::success($task, 'Custom task created');
}

public function updateCustomTask(int $id, array $data): array
{
    $task = TaskLibrary::findById($id);

    // Validace vlastnictví
    if (!$task->is_custom || $task->created_by !== Auth::id()) {
        return Response::forbidden('You can only edit your own custom tasks');
    }

    $task->update($data);
    return Response::success($task, 'Task updated');
}

public function deleteCustomTask(int $id): array
{
    $task = TaskLibrary::findById($id);

    if (!$task->is_custom || $task->created_by !== Auth::id()) {
        return Response::forbidden('You can only delete your own custom tasks');
    }

    $task->delete();
    return Response::success(null, 'Task deleted');
}
```

---

## Použití úkolů z knihovny

### Flow

1. Domina otevře Task Library
2. Filtruje podle kategorie, obtížnosti, BDSM
3. Vidí preview úkolu (title, description, instructions, safety_notes)
4. Klikne "Přiřadit servantovi"
5. (Volitelně) upraví deadline, přidá poznámku
6. Úkol se vytvoří v `tasks` tabulce s odkazem `task_library_id`

### UI Mock

```
┌─────────────────────────────────────────────┐
│ Task Library                                │
│                                             │
│ Kategorie: [Household ▼] [BDSM ▼] [All]    │
│ Obtížnost: [Easy] [Medium] [Hard]          │
│ BDSM: [None] [Soft] [Medium] [Hard]        │
│                                             │
│ ┌─────────────────────────────────────────┐ │
│ │ Ranní káva do postele           [Easy]  │ │
│ │ Připrav kávu a přines do postele        │ │
│ │ ⏱ 15 min | 🎯 5 bodů                    │ │
│ │ [Preview] [Přiřadit servantovi]         │ │
│ └─────────────────────────────────────────┘ │
│                                             │
│ ┌─────────────────────────────────────────┐ │
│ │ Spanking s paddle     [Medium] [BDSM]   │ │
│ │ 50 úderů paddle                         │ │
│ │ ⏱ 20 min | 🎯 15 bodů                   │ │
│ │ ⚠️ BEZPEČNOST: Sleduj zbarvení kůže     │ │
│ │ [Preview] [Přiřadit servantovi]         │ │
│ └─────────────────────────────────────────┘ │
│                                             │
│ --- Moje vlastní úkoly ---                 │
│                                             │
│ ┌─────────────────────────────────────────┐ │
│ │ Vyleštit všechny zrcadla    [Easy]      │ │
│ │ Vlastní úkol od Dominy123               │ │
│ │ [Editovat] [Smazat] [Přiřadit]          │ │
│ └─────────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
```

---

## Databázové tabulky (aktualizované)

### `levels`
```sql
CREATE TABLE levels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    min_points INT NOT NULL,
    max_points INT,
    description TEXT,
    permissions JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO levels VALUES
(1, 'Začátečnice', 0, 999, 'První kroky', '["household", "protocol"]'),
(2, 'Učící se', 1000, 2999, 'Rozšiřování znalostí', '["household", "protocol", "bdsm.soft", "mental"]'),
(3, 'Sebevědomá', 3000, 5999, 'Sebejistá kontrola', '["household", "protocol", "bdsm.soft", "bdsm.medium", "mental", "punishments"]'),
(4, 'Zkušená', 6000, 9999, 'Pokročilá dominance', '["*"]'),
(5, 'Expertka', 10000, NULL, 'Absolutní mistryně', '["*"]');
```

### `task_library`
(viz výše)

### `user_progress`
```sql
CREATE TABLE user_progress (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    level_id INT NOT NULL DEFAULT 1,
    total_points INT DEFAULT 0,
    tasks_created INT DEFAULT 0,
    tasks_completed INT DEFAULT 0,
    punishments_applied INT DEFAULT 0,
    penalties_received INT DEFAULT 0, -- počet penalizací
    current_streak INT DEFAULT 0,
    longest_streak INT DEFAULT 0,
    last_activity_at TIMESTAMP NULL,
    last_penalty_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (level_id) REFERENCES levels(id),
    UNIQUE KEY unique_user_progress (user_id)
);
```

### `households` (přidat sloupec)
```sql
ALTER TABLE households ADD COLUMN preferences JSON AFTER description;
```

### `fitness_tracking` (nová tabulka)
```sql
CREATE TABLE fitness_tracking (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    date DATE NOT NULL,
    weight DECIMAL(5,2), -- kg
    body_fat_percentage DECIMAL(4,2), -- %
    waist_circumference INT, -- cm
    hip_circumference INT, -- cm
    chest_circumference INT, -- cm
    photo_url VARCHAR(255), -- foto těla
    calories_consumed INT,
    steps_count INT,
    workout_minutes INT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_date (user_id, date),
    INDEX idx_user_date (user_id, date)
);
```

**Household preferences rozšíření o fitness goals:**
```json
{
  "lifestyle_focus": ["household", "fitness"],
  "bdsm_intensity": "none",
  "fitness_goals": {
    "target_weight": 75.0,
    "target_body_fat": 12.0,
    "daily_calorie_limit": 1500,
    "daily_step_goal": 10000,
    "weight_tolerance": 1.0
  }
}
```

---

## Negativní bodový systém — Implementace

### Cron job (denní kontrola nečinnosti)

```php
// Cron: každý den v 00:00
public function checkDailyInactivity(): void
{
    $servants = User::where('role', 'servant')->get();

    foreach ($servants as $servant) {
        $lastCompletedTask = Task::where('assigned_to', $servant->id)
            ->where('status', 'verified')
            ->where('verified_at', '>=', now()->subDay())
            ->first();

        if (!$lastCompletedTask) {
            // Žádný úkol splněn za 24h → penalizace
            ProgressService::addPoints($servant->id, -10, 'daily_inactivity_penalty');
            ActivityLogger::log($servant->id, null, 'penalty.inactivity', [
                'reason' => 'No task completed in 24h',
                'points' => -10
            ]);
        }
    }
}
```

### Manuální penalizace (endpoint pro dominu)

```php
POST /api/penalties/apply
{
  "servant_id": 123,
  "type": "task_refused|deadline_missed|rule_broken|disrespect",
  "reason": "Odmítl umýt nádobí",
  "task_id": 456 // optional
}

public function applyPenalty(array $data): array
{
    if (Auth::user()->role !== 'domina') {
        return Response::forbidden();
    }

    $pointsMap = [
        'task_refused' => -25,
        'deadline_missed' => -15,
        'rule_broken' => -20,
        'disrespect' => -50
    ];

    $points = $pointsMap[$data['type']];

    ProgressService::addPoints($data['servant_id'], $points, 'penalty.' . $data['type']);

    ActivityLogger::log($data['servant_id'], null, 'penalty.' . $data['type'], [
        'reason' => $data['reason'],
        'points' => $points,
        'applied_by' => Auth::id(),
        'task_id' => $data['task_id'] ?? null
    ]);

    return Response::success(null, 'Penalty applied');
}
```

---

## UI Dashboard — Progression Metrics

**Domina:**
```
┌────────────────────────────────────────────┐
│ Level 3: Sebevědomá                        │
│ ████████████████░░░░░░ 4250/6000 bodů     │
│ Do dalšího levelu: 1750 bodů               │
│                                            │
│ Achievementy: ⭐ 🏆 ✨ 🔥 💎 (12/25)       │
│                                            │
│ Statistiky:                                │
│ • Úkolů zadáno: 145                        │
│ • Úkolů splněno: 127                       │
│ • Trestů aplikováno: 8                     │
│ • Penalizací aplikováno: 3                 │
│ • Aktivních dní v řadě: 18                 │
└────────────────────────────────────────────┘
```

**Servant:**
```
┌────────────────────────────────────────────┐
│ Poslušnost: 3180 bodů                      │
│ Level 3: Oddaný                            │
│                                            │
│ Streak: 🔥 18 dní bez selhání              │
│                                            │
│ Úkoly:                                     │
│ • Splněno: 127                             │
│ • Čeká: 3                                  │
│ • Selhání: 2                               │
│                                            │
│ Penalizace (poslední měsíc):               │
│ ⚠️ Žádný úkol 24h (-10b) — 2x             │
│ ⚠️ Deadline miss (-15b) — 1x              │
└────────────────────────────────────────────┘
```

---

## Implementační pořadí (aktualizované)

1. **#036** — Databáze (levels, task_library, user_progress, households.preferences)
2. **#045** — BDSM Preference System (onboarding kvíz, JSON struktura)
3. **#037** — Level systém (body x10, validace oprávnění)
4. **#038** — Bodový systém (pozitivní + negativní)
5. **#047** — Negativní penalizace (cron job, manuální endpoint)
6. **#040** — Task Library seed (500 úkolů do DB)
7. **#046** — Task Library API (GET, POST, PUT, DELETE)
8. **#048** — UI Task Library (filtry, preview, přiřazení)
9. **#042** — Dashboard metrics (progress bar, statistiky, penalizace)
10. **#043** — Použití šablon z knihovny (create task from library)
11. **#044** — Servant motivace (streak, penalizace log)
12. **#039** — Achievementy (bonus, ne kritické)
13. **#041** — Onboarding (guided tour, první úkol)

---

## Fitness API Endpointy

### Tracking
```
POST /api/fitness/tracking
{
  "date": "2025-11-02",
  "weight": 78.5,
  "waist_circumference": 85,
  "hip_circumference": 98,
  "calories_consumed": 1450,
  "steps_count": 12000,
  "workout_minutes": 45,
  "photo_url": "/uploads/fitness/servant_123_20251102.jpg",
  "notes": "Dobrý den, cítím pokrok"
}

GET /api/fitness/tracking?user_id={id}&from=2025-10-01&to=2025-11-02
Response: [{ date, weight, ... }]

GET /api/fitness/tracking/latest?user_id={id}
Response: { date, weight, ... }
```

### Goals Management
```
PUT /api/households/{id}/fitness-goals
{
  "target_weight": 75.0,
  "target_body_fat": 12.0,
  "daily_calorie_limit": 1500,
  "daily_step_goal": 10000
}

GET /api/households/{id}/fitness-goals
Response: { target_weight, target_body_fat, ... }
```

### Weight Validation (pro úkoly)
```
GET /api/fitness/weight-compliance?user_id={id}&days=7
Response: {
  "compliant": true,
  "current_weight": 75.5,
  "target_weight": 75.0,
  "tolerance": 1.0,
  "average_weight_7days": 75.3
}
```

**Backend logika:**
- Automatická validace pro fitness úkoly
- Penalizace pokud váha přesáhne tolerance (-15b)
- Bonus body za dosažení target_weight (+50b, achievement)

---

## Poznámky

- **650 úkolů** = seed data v SQL nebo PHP seed script
- **Fitness tracking** = samostatná tabulka s denními záznamy
- **Weight compliance** = automatická kontrola cílové váhy
- **Photo uploads** = servant fotí tělo denně, domina schvaluje
- **Vlastní úkoly** dominy mají `is_custom=true`, `created_by=domina_id`
- **BDSM úkoly** mají `safety_notes` pro bezpečnost
- **Negativní motivace** drží uživatele aktivní — bez aktivity klesají body
- **Preference filtering** zajistí, že páry vidí pouze relevantní úkoly pro své hranice
- **Domina má kontrolu** — může ignorovat library a tvořit vše vlastní

---

**Konečný stav:** Systém nabízí 500 připravených úkolů, respektuje hranice BDSM, motivuje negativními penalizacemi, podporuje vlastní tvorbu.

**Design uzavřen.**
