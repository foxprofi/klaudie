# Power-Based Progression System — v3

**Autor:** Klaudie <klaudie@foxprofi.cz>

Vzdělávací systém pro páry začínající s femdom/FLR. **POUZE DOMINA** sbírá body a leveluje. Servant je závislý na jejím výkonu přes **Power Index**.

**REVIZE v3:** Power-Based System - servant nemá body, pouze domina. Power Index ovlivňuje přísnos trestů servanta.

---

## 🔥 Klíčová změna: POUZE DOMINA má body

### Proč?

V femdom/FLR dynamice má smysl, aby:
- **Domina** byla ta, kdo progresuje a odemyká nové možnosti
- **Servant** byl **závislý** na jejím výkonu
- Když domina selhává → servant dostává přísnější tresty
- **Motivace dominy**: Být aktivní, jinak servant trpí více a ona padá na bodech

---

## Level System (body pouze pro DOMINU)

| Level | Název | Body | Odemčené funkce |
|-------|-------|------|-----------------|
| 1 | Začátečnice | 0-999 | Household úkoly, Protocol basics |
| 2 | Učící se | 1000-2999 | BDSM soft, Mental domination |
| 3 | Sebevědomá | 3000-5999 | BDSM medium, tresty, vlastní pravidla |
| 4 | Zkušená | 6000-9999 | BDSM hard, pokročilé úkoly, full control |
| 5 | Expertka | 10000+ | Vše bez omezení, vlastní obsah dominuje |

---

## Bodový systém — Pouze DOMINA

### Pozitivní body (pouze pro dominu)

**Domina:**
- Vytvoření úkolu: **+5b**
- Verifikace úkolu: **+10b**
- Aplikace trestu: **+15b**
- Denní checklist splněn: **+20b**
- Vytvoření pravidla: **+8b**

### Negativní penalizace (pouze pro dominu)

**Automatické (cron job):**
- Denní checklist nesplněn: **-20b**
- Žádná aktivita 48h: **-30b**

**Manuální trigger:**
- Servant nesplní úkol (domina jej nesledovala): **-10b** (penalizace dominy!)

**Důsledky:**
- Penalizace může stáhnout level dominy dolů
- Log všech penalizací v `activity_log`
- Domina vidí důvod v dashboardu

---

## 🔋 Power Index (0-100%) — Ukazatel výkonu dominy

**Výpočet:**
Průměr z posledních **7 dní** aktivity dominy:

```
Denní body (max 100%):
- Denní checklist splněn: +30%
- Zadáno ≥1 úkol: +25%
- Verifikováno ≥1 úkol: +30%
- Aplikován ≥1 trest (pokud byl důvod): +15%

Power Index = průměr za 7 dní
```

**Příklad:**
- **7 dní plně aktivní**: 100%
- **5 dní aktivní, 2 dny nic**: ~71%
- **3 dny aktivní, 4 dny nic**: ~43%

---

## ⚡ Koeficient trestů (závislý na Power Index)

Když domina má nízký Power Index → servant dostává **přísnější tresty**.

| Power Index | Koeficient | Efekt |
|-------------|------------|-------|
| **95-100%** | 1.0 | Normální tresty (10 ran = 10 ran) |
| **85-94%** | 1.3 | +30% (10 ran = 13 ran) |
| **70-84%** | 1.6 | +60% (10 ran = 16 ran) |
| **50-69%** | 2.0 | +100% (10 ran = 20 ran) |
| **< 50%** | 2.5 | +150% (10 ran = 25 ran) |

**Aplikace:**

```php
// Power Index = 72% → koeficient 1.6
$basePunishment = "10 ran bičíkem";
$actualPunishment = 10 * 1.6 = 16 ran bičíkem

// Domina dostává také více penalizace:
$basePenalty = -15b (za servantovo selhání)
$actualPenalty = -15 * 1.6 = -24b (domině!)
```

**Důsledky:**
- Domina **musí** být aktivní, jinak servant trpí více
- Servant je závislý na dominině výkonu
- Správná femdom dynamika: domina řídí, servant následuje

---

## Servant: ŽÁDNÉ body, pouze read-only statistiky

Servant **nemá** vlastní body ani level. Pouze **metriky**:

- `tasks_completed` (počet dokončených úkolů)
- `tasks_failed` (počet selhání)
- `punishments_received` (počet trestů)
- `current_streak_days` (dny v řadě bez selhání)
- `longest_streak_days` (nejdelší streak)

**Servant vidí v dashboardu:**
- Své metriky (ne body!)
- **Power Index dominy** (aby věděl, jak moc trpí když domina selhává)
- Aktuální level dominy (a co to odemyká)

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

## Task Library — 720 úkolů

Nahrazuje původní "curriculum". Úkoly filtrované podle household preferencí a **levelu dominy**.

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
| **Feminine Power** | 70 | Vizuální dominance, oblečení, make-up, líčení (pouze pro dominu) |

**Celkem:** 720 úkolů

### BDSM úkoly breakdown

| Intenzita | Počet | Příklady |
|-----------|-------|----------|
| **Soft** | 50 | Lehké bondage, spanking, roleplay |
| **Medium** | 60 | Impact play, orgasm denial, humiliation |
| **Hard** | 40 | Těžké tresty, extended bondage, breath play |

### Fitness úkoly breakdown

| Kategorie | Počet | Popis |
|-----------|-------|-------|
| **Weight Management** | 30 | Denní vážení, target weight compliance |
| **Cardio** | 25 | Běh, cycling, HIIT |
| **Strength** | 30 | Dřepy, kliky, shyby, plank |
| **Flexibility** | 20 | Strečink, jóga |
| **Diet** | 25 | Meal prep, kalorie tracking, sladkosti zákaz |
| **Measurements** | 10 | Měření těla, foto progress |
| **Challenges** | 10 | 30-day challenges, fitness milníky |

### Feminine Power úkoly (pouze domina)

| Level | Počet | Požadavky |
|-------|-------|-----------|
| **Level 1-2** | 20 | Základní oblečení, líčení |
| **Level 3-4** | 30 | Pokročilý styling, hair, shoes |
| **Level 5** | 20 | Expert styling, dominantní vzhled |

**Denní checklist (podle levelu):**
- Level 1: 3/5 položek denně
- Level 2: 4/6 položek denně
- Level 3: 5/7 položek denně
- Level 4: 6/8 položek denně
- Level 5: 7/9 položek denně

---

## Achievements — Pouze pro DOMINU

| Achievement | Požadavek | Body |
|-------------|-----------|------|
| První verifikace | Verifikuj první úkol | +10b |
| Týden > 95% | 7 dní Power Index > 95% | +50b |
| 10 verifikací | Verifikuj 10 úkolů | +25b |
| 50 verifikací | Verifikuj 50 úkolů | +100b |
| 100 verifikací | Verifikuj 100 úkolů | +200b |
| Level 2 | Dosáhni Level 2 | +50b |
| Level 3 | Dosáhni Level 3 | +100b |
| Level 4 | Dosáhni Level 4 | +200b |
| Level 5 - Expertka | Dosáhni Level 5 | +500b |
| Měsíc > 90% | 30 dní Power Index > 90% | +300b |

---

## Databázová struktura

### Nové tabulky:

1. **levels** - 5 levelů pro dominu
2. **achievements** - Odznaky pro dominu
3. **user_achievements** - Vazba domina ↔ achievement
4. **task_library** - 720 úkolů
5. **domina_progress** - Body, level, Power Index (pouze domina)
6. **servant_stats** - Read-only metriky (ne body!)
7. **fitness_tracking** - Denní záznamy váhy, měření, foto
8. **punishment_library** - 100 trestů (s severity_multiplier)
9. **domina_daily_checklist** - Denní checklist dominy

### Upravené tabulky:

- **households** - přidány `preferences` (JSON), `fitness_goals` (JSON)
- **tasks** - rozšíření pro Recurring Tasks (#051)
- **punishments** - rozšíření pro Automatic Punishments (#052), přidán `applied_severity_multiplier`

---

## Cron Jobs

### 1. Výpočet Power Index (denně 00:00)

```php
public function calculatePowerIndex(): void
{
    $dominas = DominaProgress::all();

    foreach ($dominas as $progress) {
        $last7Days = [];

        for ($i = 0; $i < 7; $i++) {
            $date = now()->subDays($i)->format('Y-m-d');
            $dailyScore = 0;

            // Checklist splněn?
            $checklist = DominaDailyChecklist::where('domina_id', $progress->domina_id)
                ->where('checklist_date', $date)
                ->where('completion_percentage', '>=', 100)
                ->first();
            if ($checklist) $dailyScore += 30;

            // Zadáno ≥1 úkol?
            $tasksCreated = Task::where('created_by', $progress->domina_id)
                ->whereDate('created_at', $date)
                ->count();
            if ($tasksCreated > 0) $dailyScore += 25;

            // Verifikováno ≥1 úkol?
            $tasksVerified = Task::where('verified_by', $progress->domina_id)
                ->whereDate('verified_at', $date)
                ->count();
            if ($tasksVerified > 0) $dailyScore += 30;

            // Aplikován ≥1 trest? (pokud byl důvod)
            $punishmentsIssued = Punishment::where('issued_by', $progress->domina_id)
                ->whereDate('issued_at', $date)
                ->count();
            if ($punishmentsIssued > 0) $dailyScore += 15;

            $last7Days[] = $dailyScore;
        }

        // Průměr
        $powerIndex = array_sum($last7Days) / 7;

        $progress->power_index = $powerIndex;
        $progress->power_index_history = json_encode($last7Days);
        $progress->save();
    }
}
```

### 2. Automatické penalizace (denně 23:59)

```php
public function applyDailyPenalties(): void
{
    // Penalizace dominy za nesplněný checklist
    $missingChecklists = DominaProgress::whereDoesntHave('checklist', function($q) {
        $q->where('checklist_date', today())
          ->where('completion_percentage', '>=', 100);
    })->get();

    foreach ($missingChecklists as $progress) {
        $progress->total_points -= 20;
        $progress->save();

        ActivityLogger::log($progress->domina_id, $progress->household_id, 'penalty.checklist_missed', [
            'points' => -20,
            'date' => today()->format('Y-m-d')
        ]);
    }

    // Penalizace za 48h nečinnost
    $inactiveDominas = DominaProgress::where('last_activity_at', '<', now()->subHours(48))->get();

    foreach ($inactiveDominas as $progress) {
        $progress->total_points -= 30;
        $progress->save();

        ActivityLogger::log($progress->domina_id, $progress->household_id, 'penalty.inactivity_48h', [
            'points' => -30
        ]);
    }
}
```

### 3. Generování recurring tasks (denně 00:01)

Viz `RECURRING_TASKS.md`

---

## API Endpoints (příklady)

### Domina Progress

```php
// Získat progress dominy
GET /api/domina/progress
Response: {
  "domina_id": 123,
  "household_id": 456,
  "current_level": 3,
  "total_points": 4250,
  "power_index": 87.5,
  "power_index_history": [85, 90, 82, 88, 92, 86, 89],
  "tasks_created": 45,
  "tasks_verified": 38,
  "punishments_issued": 12
}
```

### Servant Stats

```php
// Získat statistiky servanta
GET /api/servant/stats
Response: {
  "servant_id": 789,
  "household_id": 456,
  "tasks_completed": 34,
  "tasks_failed": 4,
  "punishments_received": 6,
  "current_streak_days": 12,
  "longest_streak_days": 18,

  // Servant vidí také Power Index dominy
  "domina_power_index": 87.5,
  "punishment_severity_multiplier": 1.3 // kvůli Power Index 87.5%
}
```

### Power Index Koeficient

```php
// Získat aktuální koeficient trestů
GET /api/household/punishment-multiplier
Response: {
  "power_index": 87.5,
  "multiplier": 1.3,
  "message": "Domina má Power Index 87.5%, tresty jsou o 30% přísnější"
}
```

---

## UI Mockups

### Domina Dashboard

```
┌──────────────────────────────────────────────┐
│ Dashboard — Domina                           │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ Level 3: Sebevědomá                      │ │
│ │ 4250 / 6000 bodů (71%)                   │ │
│ │ [████████████░░░░░░░] → Level 4          │ │
│ │                                          │ │
│ │ Power Index: 87.5% 🔋                    │ │
│ │ [███████████████░░░] 7-denní průměr      │ │
│ │                                          │ │
│ │ ⚠️ Power Index < 95%                     │ │
│ │ Servant dostává +30% přísnější tresty    │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ Dnes (03.11.2025)                        │ │
│ │ ☑ Denní checklist: 7/7 splněno (+20b)   │ │
│ │ ☑ Zadáno úkolů: 2 (+10b)                 │ │
│ │ ☑ Verifikováno úkolů: 1 (+10b)           │ │
│ │ Celkem dnes: +40 bodů                    │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ Achievementy odemčené                    │ │
│ │ 🎯 První verifikace                      │ │
│ │ ✅ 10 verifikací                         │ │
│ │ 🔓 Level 3                               │ │
│ │                                          │ │
│ │ Další: 50 verifikací (38/50)             │ │
│ └──────────────────────────────────────────┘ │
└──────────────────────────────────────────────┘
```

### Servant Dashboard

```
┌──────────────────────────────────────────────┐
│ Dashboard — Servant                          │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ Domina: Level 3 (Sebevědomá)             │ │
│ │ Power Index: 87.5% 🔋                    │ │
│ │ [███████████████░░░]                     │ │
│ │                                          │ │
│ │ ⚠️ Kvůli Power Index < 95%:              │ │
│ │ Tresty jsou o 30% přísnější              │ │
│ │ (10 ran = 13 ran)                        │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ Moje statistiky                          │ │
│ │ Dokončeno úkolů: 34                      │ │
│ │ Selhání: 4                               │ │
│ │ Tresty obdrženy: 6                       │ │
│ │ Aktuální streak: 12 dní 🔥               │ │
│ │ Nejdelší streak: 18 dní                  │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ℹ️ Nemáš vlastní body. Tvůj výkon ovlivňuje │
│   streaky a statistiky. Domina má body.      │
└──────────────────────────────────────────────┘
```

---

## Implementační poznámky

**Priority:**
1. Databázová migrace (#036) ✅ HOTOVO
2. Seed Task Library (#040) - 720 úkolů
3. Seed Punishment Library (#052) - 100 trestů
4. Backend bodový systém (#038)
5. Power Index calculation (cron)
6. Koeficient trestů (#052 backend)
7. Frontend dashboardy (#042)

**Bezpečnost:**
- Pouze domina může měnit body (backend validace)
- Servant nemá přístup k úpravě Power Index
- Power Index read-only pro všechny (pouze cron mění)
- Koeficient trestů aplikován automaticky

**Performance:**
- Power Index cachování (přepočet pouze 1x denně)
- Index na `power_index` sloupci
- JSON historie max 30 dní (cleanup cron)

---

**Design uzavřen.**
