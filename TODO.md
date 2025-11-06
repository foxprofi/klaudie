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

- [ ] **#050** - Feminine Power System (denní checklist dominy)
  - Databázová tabulka `domina_daily_checklist`
  - 5 levelů denních checklistů (progressive requirements: 3/5 → 7/9)
  - API: POST /api/domina/checklist (domina vyplní)
  - API: POST /api/domina/checklist/verify (servant jako witness)
  - API: GET /api/domina/checklist (get pro den)
  - API: GET /api/domina/checklist/history (historie)
  - Cron job: denní kontrola compliance (23:59)
  - Penalizace při nesplnění: -20b až -50b domina, -10b až -30b servant (dle levelu)
  - Body za splnění: +5b až +30b dle levelu
  - 70 úkolů kategorie Feminine Power (oblečení, make-up, styling)
  - UI: Domina checklist dashboard
  - UI: Servant verification interface (může potvrdit za dominu jako svědek)
  - Validace: servant nemůže přepsat checklist vyplněný dominou

- [ ] **#051** - Recurring Tasks (opakující se úkoly)
  - Databázové sloupce v `tasks`: is_recurring, recurrence_pattern, recurrence_interval, recurrence_day_of_week, recurrence_day_of_month, recurring_task_id, recurrence_end_date, recurrence_active
  - Foreign key: recurring_task_id → tasks(id) CASCADE
  - Periodicita: neopakovat, denně, každých X dní (2-30), týdně, měsíčně
  - Parent task = šablona, child tasks = auto-generované instance
  - Cron job: generování instancí (00:01 denně)
  - API: POST /api/tasks (s periodicitu)
  - API: PUT /api/tasks/{id}/recurring/deactivate|activate
  - API: PUT /api/tasks/{id}/recurring (úprava periodicitu)
  - API: DELETE /api/tasks/{id} (smaže parent + pending instances)
  - UI: Periodicita při vytváření úkolu (radio buttons)
  - UI: Správa recurring tasks (seznam, vypnout/zapnout/smazat)
  - UI: Servant dashboard zobrazí 🔁 ikonu pro recurring instance
  - Validace: interval 2-30, end_date max 1 rok, pouze domina vytváří

### Původní gamifikace (nahrazeno Progression System)
- [x] **#014** - DEPRECATED — nahrazeno #036-#051
- [x] **#015** - DEPRECATED — nahrazeno #036-#051

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

---

## 📊 Statistiky

**Aktivní úkoly:** 38
**High priority:** 4
**Medium priority:** 16 (11 Progression System úkolů včetně Fitness, Feminine Power, Recurring a Punishments)
**Low priority:** 6
**Tech debt:** 5
**Nápady:** 4
**Deprecated:** 2
**Hotovo (v CHANGELOG.md):** 13

---

**Další volné číslo:** #053

**Poznámka:** Po dokončení úkolu přesuň záznam do `CHANGELOG.md`.
