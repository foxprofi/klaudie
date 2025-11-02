# Progression System — Architektura

**Autor:** Klaudie <klaudie@foxprofi.cz>

Vzdělávací systém pro páry začínající s femdom/FLR. Postupné vedení dominy od začátečnice k expertce.

---

## Koncept

Páry nově vstupující do femdom/FLR životního stylu často nevědí, jak začít. Tento systém jim poskytuje:

1. **Strukturovaný postup** — postupné odemykání funkcí podle zkušeností
2. **Motivaci** — bodový systém a achievementy
3. **Vzdělávání** — předpřipravený obsah (curriculum) rozdělený do levelů
4. **Bezpečí** — začínáme s lehkými úkoly, postupně rosteme

---

## Architektura

### 1. Level System (5 stupňů)

| Level | Název | Min. bodů | Odemčené funkce |
|-------|-------|-----------|-----------------|
| 1 | Začátečnice | 0 | Jednoduché úkoly (domácnost), curriculum L1 |
| 2 | Učící se | 100 | Pravidla chování, curriculum L2 |
| 3 | Sebevědomá | 300 | Lehké tresty, curriculum L3 |
| 4 | Zkušená | 600 | Pokročilé úkoly, vlastní pravidla, curriculum L4 |
| 5 | Expertka | 1000 | Vše vlastní, žádné šablony |

### 2. Bodový systém

**Domina získává body za:**
- Vytvoření úkolu: **5 bodů**
- Verifikace splněného úkolu: **10 bodů**
- Aplikace trestu: **15 bodů**
- Vytvoření pravidla: **8 bodů**
- Denní aktivita (min. 1 akce): **3 body**

**Servant získává body za:**
- Splněný úkol (easy): **5 bodů**
- Splněný úkol (medium): **15 bodů**
- Splněný úkol (hard): **25 bodů**
- Dodržení pravidla (denně): **2 body**

**Body se automaticky přepočítají → level up**

### 3. Achievement System

| Achievement | Podmínka | Body |
|-------------|----------|------|
| První krok | Vytvoření prvního úkolu | 10 |
| První týden | 7 dní aktivity v řadě | 25 |
| Věrná poslušnost | Servant — 10 úkolů bez selhání | 30 |
| Sebevědomá domina | 10 vytvořených úkolů | 40 |
| Disciplína | Aplikace prvního trestu | 20 |
| Měsíc síly | 30 dní aktivity | 100 |
| Stovka | 100 vytvořených úkolů | 200 |

### 4. Curriculum (předpřipravené šablony)

**Level 1 — Začátečnice (12 šablon úkolů)**
```
- Ranní káva do postele
- Uklizený obývací pokoj
- Uvařená večeře
- Vyprané prádlo
- Vyleštěná koupelna
- Nákup podle seznamu
- Příprava snídaně
- Vysátý byt
- Umyté nádobí
- Vyžehlené košile
- Uklizená ložnice
- Příprava relaxační koupele
```

**Level 2 — Učící se (10 šablon pravidel)**
```
- Zdravení: "Dobrý den, paní"
- Oslovení: pouze "paní" nebo dohodnuté jméno
- Pozice: klečení při vstupu dominy do místnosti
- Žádost o povolení mluvit
- Žádost o povolení sednout
- Oční kontakt pouze s povolením
- Příprava obuvi dominy každé ráno
- Otevírání dveří
- Nosení nákupu/tašek
- Denní hlášení večer (co bylo splněno)
```

**Level 3 — Sebevědomá (8 šablon trestů)**
```
- 15 minut v rohu (nos ke zdi)
- Psaní vět (50x "Budu poslouchat")
- Odebrání privilegií (TV/telefon na 24h)
- Klečení 10 minut (ticho, meditace)
- Dodatečný úkol (umýt okna)
- Žádný dezert 3 dny
- Omluva v kleku (písemná + ústní)
- Časný spánek (21:00)
```

**Level 4 — Zkušená (15 šablon pokročilých úkolů)**
```
- Týdenní projekt (reorganizace skříně)
- Naučit se novou dovednost (masáž nohou)
- Příprava romantického večera
- Péče o boty dominy (čištění, leštění)
- Vedení deníku poslušnosti
- Ranní rituál (káva, noviny, polštář k nohám)
- Příprava vany s vonnými oleji
- Kompletní úklid bytu (deep clean)
- Nákup a zabalení dárku pro dominu
- Výběr a nákup oblečení podle pokynů
- Příprava piknikového koše
- Péče o pokojové rostliny
- Organizace společenské akce
- Příprava 3chodového menu
- Osobní projekt ke schválení
```

**Level 5 — Expertka**
- Žádné šablony
- Vše vytváří domina podle vlastní kreativity a zkušeností
- Plná svoboda v nastavování dynamiky vztahu

### 5. Onboarding Flow

**Krok 1: Úvodní kvíz** (po registraci páru)
```
1. Máte zkušenosti s femdom/FLR?
   - Žádné (→ Level 1)
   - Málo (→ Level 1)
   - Středně (→ Level 2)
   - Hodně (→ Level 3)

2. Jaké jsou vaše hranice?
   - [ ] Fyzický kontakt
   - [ ] Ponižování
   - [ ] Veřejné projevy
   - (uloženo do household_settings)

3. Co chcete z této aplikace?
   - [ ] Naučit se základy
   - [ ] Strukturu a pravidelnost
   - [ ] Inspiraci pro úkoly
   - [ ] Tracking pokroku
```

**Krok 2: Guided Tour**
```
1. Vítej, [jméno]! Tady začíná tvá cesta.
2. Toto je tvůj dashboard. Uvidíš zde pokrok.
3. Toto je menu Úkoly — zde zadáš první příkaz.
4. Použij šablonu nebo vytvoř vlastní.
5. Servant vidí úkol a plní ho.
6. Ty ověříš a potvrdíš — získáš body.
```

**Krok 3: První úkol**
```
Automaticky vytvoří jeden úkol z Level 1 curriculum
(např. "Ranní káva do postele")
Status: pending
Assigned: servant
```

### 6. Dashboard Metrics

**Pro dominu:**
```
┌─────────────────────────────────────┐
│ Level 2: Učící se                   │
│ ███████████░░░░░░░░░ 150/300 bodů   │
│                                     │
│ Achievementy: ⭐ 🏆 ✨ (3/15)       │
│                                     │
│ Statistiky:                         │
│ • Úkolů zadáno: 23                  │
│ • Úkolů splněno: 19                 │
│ • Trestů aplikováno: 2              │
│ • Aktivních dní v řadě: 12          │
└─────────────────────────────────────┘
```

**Pro servanta:**
```
┌─────────────────────────────────────┐
│ Poslušnost: 127 bodů                │
│                                     │
│ Streak: 🔥 12 dní bez selhání       │
│                                     │
│ Úkoly:                              │
│ • Splněno: 19                       │
│ • Pending: 4                        │
│ • Selhání: 1                        │
└─────────────────────────────────────┘
```

---

## Databázové tabulky

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
```

**Seed data:**
```sql
INSERT INTO levels (id, name, min_points, max_points, permissions) VALUES
(1, 'Začátečnice', 0, 99, '["tasks.basic", "curriculum.level1"]'),
(2, 'Učící se', 100, 299, '["tasks.basic", "rules.create", "curriculum.level1", "curriculum.level2"]'),
(3, 'Sebevědomá', 300, 599, '["tasks.basic", "rules.create", "punishments.basic", "curriculum.level1", "curriculum.level2", "curriculum.level3"]'),
(4, 'Zkušená', 600, 999, '["tasks.all", "rules.all", "punishments.all", "curriculum.level1", "curriculum.level2", "curriculum.level3", "curriculum.level4"]'),
(5, 'Expertka', 1000, NULL, '["*"]');
```

### `achievements`
```sql
CREATE TABLE achievements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    icon VARCHAR(10),
    condition_type ENUM('task_count', 'streak_days', 'points', 'punishment_count', 'custom'),
    condition_value INT,
    points_reward INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### `user_achievements`
```sql
CREATE TABLE user_achievements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    achievement_id INT NOT NULL,
    unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_achievement (user_id, achievement_id)
);
```

### `curriculum_templates`
```sql
CREATE TABLE curriculum_templates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    level_id INT NOT NULL,
    type ENUM('task', 'rule', 'punishment') NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    difficulty ENUM('easy', 'medium', 'hard') DEFAULT 'easy',
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (level_id) REFERENCES levels(id) ON DELETE CASCADE
);
```

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
    current_streak INT DEFAULT 0,
    longest_streak INT DEFAULT 0,
    last_activity_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (level_id) REFERENCES levels(id),
    UNIQUE KEY unique_user_progress (user_id)
);
```

---

## API Endpointy

### Progress
- `GET /api/progress` — aktuální pokrok přihlášeného uživatele
- `POST /api/progress/points` — přidat body (internal, automatické)
- `GET /api/progress/achievements` — seznam odemčených achievementů
- `GET /api/levels` — seznam všech levelů

### Curriculum
- `GET /api/curriculum/templates?level={id}&type={task|rule|punishment}` — šablony dle levelu
- `GET /api/curriculum/templates/{id}` — detail šablony
- `POST /api/curriculum/use/{id}` — použít šablonu (vytvoří task/rule/punishment)

### Achievements
- `GET /api/achievements` — všechny achievementy
- `GET /api/achievements/available` — co může user ještě odemknout
- `POST /api/achievements/check` — kontrola splnění (automaticky voláno po každé akci)

---

## Business logika

### Automatické přidávání bodů

**Hook v TaskController@verify():**
```php
// Po verifikaci úkolu
$progressService->addPoints($domina->id, 10, 'task_verified');
$progressService->addPoints($servant->id, $task->difficulty_points, 'task_completed');
$progressService->checkAchievements($domina->id);
$progressService->checkAchievements($servant->id);
```

**Hook v TaskController@create():**
```php
$progressService->addPoints($domina->id, 5, 'task_created');
$progressService->incrementStat($domina->id, 'tasks_created');
```

**Hook v PunishmentController@create():**
```php
$progressService->addPoints($domina->id, 15, 'punishment_applied');
$progressService->incrementStat($domina->id, 'punishments_applied');
```

### Level up detection

```php
public function addPoints(int $userId, int $points, string $reason): void
{
    $progress = UserProgress::findByUserId($userId);
    $progress->total_points += $points;

    // Check level up
    $newLevel = Level::getByPoints($progress->total_points);
    if ($newLevel->id > $progress->level_id) {
        $progress->level_id = $newLevel->id;
        // Notify user
        Notification::send($userId, "Level up! Nyní jsi {$newLevel->name}");
    }

    $progress->save();
}
```

### Achievement check

```php
public function checkAchievements(int $userId): void
{
    $progress = UserProgress::findByUserId($userId);
    $unlocked = UserAchievement::getUnlockedIds($userId);
    $available = Achievement::getAvailable($unlocked);

    foreach ($available as $achievement) {
        if ($this->isConditionMet($achievement, $progress)) {
            UserAchievement::unlock($userId, $achievement->id);
            Notification::send($userId, "Nový achievement: {$achievement->name}!");
            $this->addPoints($userId, $achievement->points_reward, 'achievement_unlocked');
        }
    }
}
```

---

## UI/UX

### Progress Bar Component
```html
<div class="progress-container">
    <div class="progress-header">
        <span class="level-name">Level 2: Učící se</span>
        <span class="points">150/300 bodů</span>
    </div>
    <div class="progress-bar">
        <div class="progress-fill" style="width: 50%"></div>
    </div>
    <div class="next-level">
        Další level: <strong>Sebevědomá</strong> (ještě 150 bodů)
    </div>
</div>
```

### Achievement Badge
```html
<div class="achievement ${unlocked ? 'unlocked' : 'locked'}">
    <div class="achievement-icon">${icon}</div>
    <div class="achievement-name">${name}</div>
    <div class="achievement-desc">${description}</div>
</div>
```

### Curriculum Template Card
```html
<div class="template-card">
    <div class="template-header">
        <span class="template-title">${title}</span>
        <span class="badge badge-${difficulty}">${difficulty}</span>
    </div>
    <div class="template-body">${description}</div>
    <button class="btn btn-primary" onclick="useTemplate(${id})">
        Použít šablonu
    </button>
</div>
```

---

## Implementační pořadí

1. **#036** — Databázové migrace (foundation)
2. **#037** — Level systém (core mechanic)
3. **#038** — Bodový systém (motivace)
4. **#042** — Dashboard metrics (viditelnost pokroku)
5. **#039** — Achievementy (dodatečná motivace)
6. **#040** — Curriculum content (hodnota pro uživatele)
7. **#043** — Použití šablon (UX)
8. **#044** — Servant motivace (rovnováha)
9. **#041** — Onboarding (first impression)

---

## Poznámky

- Žádný leaderboard — každý pár si jde vlastní cestou
- Servant nemá odměny — poslušnost JE odměna
- Body nejsou měna — jsou měřítko pokroku
- Curriculum je návrh, ne příkaz — domina má vždy poslední slovo
- Level 5 = žádné šablony = expertka nepotřebuje vedení

---

**Konečný stav:** Pár má strukturovanou cestu od úplných začátků k plné autonomii ve femdom/FLR dynamice.

**Klaudie rozhodla. Toto je design.**
