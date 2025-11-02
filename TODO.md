# TODO - Klaudie Development

**Autor:** Klaudie <klaudie@foxprofi.cz>

Aktivní úkoly pro vývoj. Hotové úkoly jsou přesunuty do `CHANGELOG.md`.

**Použití:** Při implementaci odkazuj na číslo úkolu (např. "Implementuji #005").

---

## 🔥 Priority (High)

### Panství
- [ ] **#006** - Dashboard pro servanta
  - Zobrazit informace o panství, do kterého patří
  - Zobrazit jméno dominy
  - Statistiky servanta v rámci panství

### Úkoly
- [ ] **#007** - Notifikace o nových úkolech
  - Real-time notifikace pro servanta
  - Badge s počtem nedokončených úkolů

- [ ] **#008** - Filtrování úkolů
  - Podle statusu (pending, completed, verified)
  - Podle obtížnosti
  - Podle data vytvoření

### Tresty
- [ ] **#009** - Detailní zobrazení trestu
  - Popis důvodu trestu
  - Historie trestů servanta
  - Možnost servanta vyjádřit se k trestu

---

## 🎯 Střední priorita (Medium)

### Autentizace
- [ ] **#010** - Reset hesla
  - Email s resetovacím linkem
  - Formulář pro změnu hesla

- [ ] **#011** - Two-factor authentication (2FA)
  - SMS nebo TOTP (Google Authenticator)
  - Povinná pro roli domina

### Profil
- [ ] **#012** - Nastavení profilu
  - Změna jména
  - Nahrání profilového obrázku
  - Osobní poznámky

- [ ] **#013** - Preferenční nastavení
  - Jazyk rozhraní (CZ/EN)
  - Emailové notifikace (on/off)
  - Theme (dark/light mode)

### Progression System (Vzdělávací systém pro páry)
- [ ] **#036** - Databázová migrace pro Progression System
  - Tabulka `levels` (5 levelů: 0-999, 1000-2999, 3000-5999, 6000-9999, 10000+)
  - Tabulka `achievements` (odznaky za milníky)
  - Tabulka `user_achievements` (vazba user ↔ achievement)
  - Tabulka `task_library` (650 předpřipravených úkolů z 7 kategorií)
  - Tabulka `user_progress` (body, aktuální level, statistiky, negativní penalizace)
  - Tabulka `fitness_tracking` (denní záznamy váhy, měření, kroky, kalorie, foto)
  - Sloupec `preferences` (JSON) v tabulce `households` včetně fitness_goals

- [ ] **#037** - Level systém pro dominu
  - 5 levelů s různými oprávněními (body vynásobeny 10)
  - Automatické odemykání funkcí podle pokroku
  - Progress bar k dalšímu levelu
  - Backend validace oprávnění podle levelu

- [ ] **#038** - Bodový systém s negativní motivací
  - Pozitivní body za akce (vytvoření: 5b, verifikace: 10b, trest: 15b)
  - Pozitivní body za splněné úkoly (5-25b dle obtížnosti)
  - NEGATIVNÍ PENALIZACE: žádný úkol 24h (-10b), odmítnutí (-25b), deadline miss (-15b), porušení pravidla (-20b), nerespekt (-50b)
  - Automatický přepočet bodů → level up/down

- [ ] **#039** - Achievement systém
  - Definice achievementů (První úkol, První týden, 10 úkolů, 100 úkolů)
  - Automatická detekce a odemykání achievementů
  - Notifikace při odemčení achievementu
  - Zobrazení achievementů v profilu

- [ ] **#040** - Task Library — 650 úkolů
  - Kategorie: Household (120), Protocol (80), BDSM (150), Mental (70), Fitness (150), Physical (50), Creative (30)
  - BDSM úkoly: Soft (50), Medium (60), Hard (40)
  - Fitness úkoly: Weight Management (30), Cardio (25), Strength (30), Flexibility (20), Diet (25), Measurements (10), Challenges (10)
  - Každý úkol: kategorie, subcategory, difficulty, level_required, bdsm_intensity, preferences_required
  - Filtrování podle household preferencí a levelu dominy
  - Seed data: 650 úkolů do databáze

- [ ] **#041** - Onboarding flow s BDSM preferencemi
  - Úvodní kvíz: zkušenosti, lifestyle focus (household/protocol/BDSM/mental/financial)
  - BDSM intensity (none/soft/medium/hard)
  - Hranice checklist (50+ položek: impact play, bondage, humiliation, atd.)
  - Uložení do household.preferences (JSON)
  - Doporučení startovního levelu
  - Guided tour + automatický první úkol podle preferencí

- [ ] **#042** - Dashboard s progression metrics
  - Aktuální level + progress bar
  - Počet bodů (celkem, k dalšímu levelu)
  - Odemčené achievementy (ikony)
  - Statistiky (úkolů zadáno, splněno, trestů aplikováno)
  - Servant streak (dny v řadě bez selhání)

- [ ] **#043** - Použití curriculum šablon
  - Tlačítko "Použít šablonu" při vytváření úkolu/trestu
  - Filtrování šablon podle aktuálního levelu
  - Preview šablony před použitím
  - Možnost upravit šablonu před vytvořením

- [ ] **#044** - Motivační systém pro servanta
  - Vizualizace bodů za splněné úkoly
  - Streak counter (dny v řadě bez selhání)
  - Penalizace zobrazení (ztracené body, důvody)
  - Žádné odměny — poslušnost JE odměna
  - Historie bodů a progressu

- [ ] **#045** - BDSM Preference System
  - Rozšíření onboarding kvízu o BDSM sekci
  - Lifestyle focus (household, protocol, BDSM, mental, financial)
  - BDSM intensity slider (none → hard)
  - Hranice hard/soft limits (checklist 50+ položek)
  - Uložení do households.preferences (JSON column)
  - Filtrování task library podle preferencí

- [ ] **#046** - Task Library Management API
  - GET /api/task-library (s filtry: category, difficulty, bdsm_intensity, match_preferences)
  - POST /api/task-library/custom (vytvoření vlastního úkolu dominou)
  - PUT /api/task-library/{id} (editace vlastního úkolu)
  - DELETE /api/task-library/{id} (smazání vlastního úkolu)
  - Backend validace: pouze created_by = Auth::id() může editovat

- [ ] **#047** - Negativní bodový systém (penalizace)
  - Cron job kontrola: žádný splněný úkol 24h → -10 bodů
  - Servant odmítne úkol → -25 bodů
  - Nesplněný deadline → -15 bodů
  - Porušení pravidla → -20 bodů (manuální trigger od dominy)
  - Nerespekt/argument → -50 bodů (manuální trigger)
  - Log všech penalizací do activity_log

- [ ] **#048** - UI pro výběr úkolů z knihovny
  - Stránka Task Library s filtry (kategorie, obtížnost, BDSM)
  - Preview úkolu před přiřazením
  - Tlačítko "Přiřadit servantovi" (vytvoří task z template)
  - Možnost upravit před přiřazením
  - Zobrazení vlastních úkolů dominy odděleně

- [ ] **#049** - Fitness Tracking System
  - API: POST /api/fitness/tracking (denní záznam váhy, měření, kroky, kalorie, foto)
  - API: GET /api/fitness/tracking (historie s filtrováním)
  - API: PUT /api/households/{id}/fitness-goals (nastavení cílů)
  - API: GET /api/fitness/weight-compliance (kontrola dodržení váhy)
  - Automatická penalizace při překročení tolerance (-15b)
  - Achievement za dosažení target_weight (+50b)
  - UI: Dashboard s grafem váhy a pokroku
  - UI: Formulář pro denní report (váha, měření, kroky, kalorie, upload foto)

### Původní gamifikace (nahrazeno Progression System)
- [x] **#014** - DEPRECATED — nahrazeno #036-#049
- [x] **#015** - DEPRECATED — nahrazeno #036-#049

---

## 💡 Nízká priorita (Low)

### Komunikace
- [ ] **#016** - Chat mezi dominou a servantem
  - Real-time messaging
  - Historie konverzací
  - Možnost přikládat obrázky

- [ ] **#017** - Komentáře k úkolům
  - Servant může přidat poznámku k dokončenému úkolu
  - Domina může komentovat verifikaci

### Reporting
- [ ] **#018** - Exporty a statistiky
  - Export úkolů do CSV/PDF
  - Grafy výkonnosti servantů
  - Měsíční reporty

- [ ] **#019** - Activity log
  - Kompletní historie akcí v panství
  - Filtrovatelný log pro auditing

### Integrace
- [ ] **#020** - API pro třetí strany
  - REST API dokumentace
  - Webhook notifikace
  - OAuth2 autentizace

- [ ] **#021** - Mobile app
  - React Native / Flutter
  - Push notifikace

---

## 📋 Technický dluh

- [ ] **#024** - Refactoring AuthController - příliš velká logika v controlleru
- [ ] **#025** - Implementovat caching pro často používané dotazy
- [ ] **#026** - Přidat DB indexy pro optimalizaci výkonu
- [ ] **#027** - Napsat unit testy (pokud bude požadováno)
- [ ] **#028** - Code review - odstranit duplicitní kód

---

## 💭 Nápady k diskusi

- **#029** - Multi-household support pro servanta? (jeden servant může patřit do více panství)
- **#030** - Video call integrace mezi dominou a servantem?
- **#031** - AI asistent pro návrhy úkolů?
- **#032** - Kalendář s naplánovanými úkoly?
- **#033** - Recurring tasks (opakující se úkoly)?

---

## 📊 Statistiky

**Aktivní úkoly:** 41
**High priority:** 4
**Medium priority:** 19 (14 Progression System úkolů včetně Fitness)
**Low priority:** 6
**Tech debt:** 5
**Nápady:** 5
**Deprecated:** 2
**Hotovo (v CHANGELOG.md):** 7

---

**Další volné číslo:** #050

**Poznámka:** Po dokončení úkolu přesuň záznam do `CHANGELOG.md`.
