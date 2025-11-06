# CHANGELOG - Klaudie

**Autor:** Klaudie <klaudie@foxprofi.cz>

Historie implementovaných funkcionalit a změn v projektu.

---

## [Unreleased] - 2025-11-04

### Added
- **#036** - Power-Based Progression System - Databázová migrace
  - Tabulka `domina_progress` - pouze domina má body, level, Power Index
  - Tabulka `servant_stats` - servant má pouze read-only statistiky (bez bodů)
  - View `v_servant_stats` pro bezpečné čtení servant statistik
  - Power Index (0-100%) - 7-day rolling average aktivity dominy
  - Severity multiplier pro tresty (1.0x až 2.5x podle Power Index)
  - Level systém 1-5 pouze pro dominu (0-999, 1000-2999, 3000-5999, 6000-9999, 10000+)
  - Migrace `003_progression_system.sql` s rollback podporou
  - Dokumentace v `PROGRESSION_SYSTEM.md` - kompletní Power-Based System v3

- **#037** - Level systém pro dominu - Backend implementace
  - Service `DominaProgressService` pro správu bodů a levelů
  - Metoda `getLevelInfo()` - získání detailních info o levelu (current level, points, progress %, Power Index)
  - Metoda `addPoints()` - přidání bodů s automatickým level-up detekováním
  - Metoda `deductPoints()` - odečtení bodů (penalizace) s automatickým level-down
  - Metoda `calculateLevel()` - výpočet levelu z bodů (5 levelů: Začátečnice, Učící se, Sebevědomá, Zkušená, Expertka)
  - Metoda `getPowerIndex()` - čtení Power Index dominy
  - API endpoint `GET /api/households/{householdId}/progress` - přístupný pro dominu i servanta
  - Controller `ProgressController` s autentizací a autorizací
  - Activity logging pro všechny změny bodů a levelů
  - Otestováno na databázi (add/deduct points, level-up/down, persistence)

- **#038** - Bodový systém s pozitivní motivací - Integrace do akcí
  - Domina získává body za akce: vytvoření úkolu (+5b), verifikace úkolu (+10b), udělení trestu (+15b)
  - Bonus body za verifikaci podle obtížnosti: trivial (+5b), easy (+10b), medium (+15b), hard (+20b), extreme (+25b)
  - Celkově za verifikaci: 10b (base) + 5-25b (difficulty bonus) = 15-35b
  - Integrace do `TaskController::create()` a `TaskController::verify()`
  - Integrace do `PunishmentController::create()`
  - Odstranění starého `PointsService` usage pro servanta (servant už nemá body v Power-Based System)
  - Aktualizace `StatsController` - domina dashboard zobrazuje její level, servant dashboard zobrazuje domina level
  - Automatický přepočet level up/down při změně bodů
  - Otestováno: 550b → 555b (+5b task) → 580b (+25b verify) → 595b (+15b punishment)

- **#039** - Achievement systém - Backend implementace
  - Databázová migrace: tabulka `domina_achievements` (many-to-many vztah domina - achievements)
  - Service `AchievementService` pro automatickou detekci a odemykání achievementů
  - Typy requirementů: `task_verified_count`, `punishment_issued_count`, `points_reached`, `level_reached`, `power_index_days`
  - Automatická kontrola achievementů po verifikaci úkolu a udělení trestu
  - Odměna bodů za odemčení achievementu (pokud má achievement `points_reward`)
  - Activity logging pro každé odemčení
  - API endpointy: `GET /api/households/{id}/achievements` (vše), `GET /api/households/{id}/achievements/unlocked` (pouze odemčené)
  - Controller `AchievementController` s autorizací (pouze domina)
  - Integrace do `TaskController::verify()` a `PunishmentController::create()`
  - Response obsahuje `new_achievements` pole s nově odemčenými achievementy

- **#040** - Task Library - 720 úkolů
  - Household: 120 úkolů (cleaning, cooking, laundry, organization, maintenance, shopping)
  - Protocol: 60 úkolů (rituals, positions, addressing, communication, service, rules)
  - BDSM: 240 úkolů (bondage, impact, service, dominance, sensory, roleplay, humiliation, tease & denial, power exchange, mixed)
  - Mental: 60 úkolů (reading, writing, learning, meditation, personal development)
  - Fitness: 150 úkolů (cardio, strength, flexibility, yoga, sports, challenges)
  - Physical: 30 úkolů (body modification, grooming)
  - Creative: 30 úkolů (art, crafts, music, photography, video, writing)
  - Feminine Power: 30 úkolů (empowerment activities)
  - Seed soubory: 005-006 (initial 195), 007-014 (complete 720)
  - Každý úkol má difficulty, level_required, bdsm_intensity, duration, instructions
  - BDSM preferences pro filtrování podle household settings

- **#052** - Punishment Library - 100 trestů
  - Physical discipline: 20 trestů (impact play, flagged for automatic assignment)
  - Mental punishments: 20 trestů (psychological, humiliation)
  - Restrictive punishments: 20 trestů (denial, restrictions)
  - Creative & household: 20 trestů (creative punishments, chores)
  - Universal punishments: 20 trestů (fallback when all preferences selected)
  - Seed soubor: 004_seed_punishment_library.sql
  - Automatic punishment selection based on BDSM preferences
  - Severity multipliers applied via Power Index
  - Documented in `AUTOMATIC_PUNISHMENTS.md`

### Documentation
- Přidán `PROGRESSION_SYSTEM.md` v3 - Power-Based System
  - Pouze domina má body a level
  - Servant závislý na Power Index dominy
  - Koeficient trestů podle aktivity dominy
  - Kompletní bodový systém a penalizace

- Přidán `RECURRING_TASKS.md` - dokumentace opakujících se úkolů
  - Parent/child task pattern
  - Cron job pro automatické generování instancí
  - Periodicita: denně, každých X dní, týdně, měsíčně

- Přidán `AUTOMATIC_PUNISHMENTS.md` - automatický trestací systém
  - 2 tresty per penalty (physical + unpleasant)
  - Selection algorithm based on preferences
  - Power Index severity multipliers
  - Safety notes a instructions

---

## [Unreleased] - 2025-11-02

### Added
- **#001** - Registrace servanta s household klíčem
  - Backend validace UUID klíče při registraci
  - Frontend formulář s polem pro household key
  - Automatická validace existence klíče v databázi

- **#002** - Automatické přiřazení servanta do panství při registraci
  - Servant je okamžitě přidán do `household_members` po registraci
  - Vazba mezi servantem a panstvím vytvořena atomicky

- **#003** - Skrytí záložky "Panství" pro servanta
  - Frontend logika skrývá menu "Panství" pro roli servant
  - Servant vidí pouze: Dashboard, Úkoly, Moje tresty

- **#004** - UUID klíč pro pozvání servantů
  - Databázová migrace `002_add_household_key.sql`
  - Sloupec `household_key` (CHAR(36), UNIQUE) v tabulce `households`
  - Automatické generování UUID při vytvoření panství
  - Metody `findByKey()` a `generateUUID()` v Household modelu

- **#005** - Zobrazení household klíče pro dominu
  - Backend endpoint `PUT /api/households/{id}/regenerate-key` pro regeneraci klíče
  - Frontend zobrazení UUID klíče v detailu panství (pouze pro dominu)
  - Tlačítko pro kopírování klíče do schránky pomocí Clipboard API
  - Tlačítko pro regeneraci klíče s potvrzovacím dialogem
  - Metoda `regenerateKey()` v Household modelu

- **#034** - Seznam servantů v panství pro dominu
  - Frontend načítání detailů panství včetně seznamu servantů
  - Zobrazení servantů s informacemi: jméno, email, datum připojení, status
  - Vizuální rozlišení aktivních a neaktivních servantů
  - Zpráva při prázdném seznamu servantů

- **#035** - Barevné rozlišení statusu servanta
  - Aktivní servant: zelený badge (badge-success)
  - Neaktivní servant: červený badge (badge-danger) místo šedého

### Fixed
- CSS badge color classes nebyly definovány
  - Přidána třída `.badge-success` (zelený gradient)
  - Přidána třída `.badge-danger` (červený gradient)
  - Přidána třída `.badge-secondary` (šedý gradient)
  - Opraveno zobrazení barev u statusů servantů

### Changed
- Přejmenování "Domácnosti" na "Panství" v celé aplikaci
  - UI texty v HTML (menu, modaly, formuláře)
  - JavaScript uživatelské zprávy a notifikace
  - TODO.md a CHANGELOG.md aktualizovány
  - Kód a proměnné ponechány jako `household` pro konzistenci

- **#022** - Opraveny PHP 8.4 deprecated warnings v Model.php
  - Nullable type hint pro `$limit` parametr v metodě `findAll()`

- **#023** - Opraven Docker MySQL connection timeout
  - Auto-detekce Docker prostředí v `config/database.php`
  - Použití `host.docker.internal` pro Docker kontejner
  - Zachována přímá IP `192.168.31.139` pro hostitelský systém

### Security
- Přesun API credentials z hardcoded hodnot do `.env`
  - `INTERNAL_API_URL` a `INTERNAL_API_KEY` nyní v environment variables
  - Script `query-db.sh` načítá konfiguraci z `.env`

### Documentation
- Přidán `DEVELOPMENT.md` - technická dokumentace
  - Database connection setup (Docker vs. host)
  - Password hashing konfigurace
  - Internal API konfigurace
  - Testovací příkazy

- Přidán `TODO.md` - strukturovaný seznam budoucích úkolů
  - 33 úkolů s unikátními ID (#001-#033)
  - Kategorizace podle priority (High/Medium/Low)
  - Statistiky a tracking

- Přidán `CHANGELOG.md` - tento soubor
  - Historie změn podle sémantického verzování

---

## Template pro budoucí záznamy

```markdown
## [Verze] - YYYY-MM-DD

### Added
- **#XXX** - Název funkcionality
  - Detail implementace
  - Detail implementace

### Changed
- **#XXX** - Změna
  - Popis změny

### Deprecated
- **#XXX** - Co je deprecated

### Removed
- **#XXX** - Co bylo odstraněno

### Fixed
- **#XXX** - Oprava bugu
  - Popis fix

### Security
- **#XXX** - Bezpečnostní update
```

---

**Poznámka:** Changelog se řídí principy [Keep a Changelog](https://keepachangelog.com/) a [Semantic Versioning](https://semver.org/).
