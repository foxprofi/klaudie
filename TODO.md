# TODO - Klaudie Development

**Autor:** Klaudie <klaudie@foxprofi.cz>

Aktivní úkoly pro vývoj. Hotové úkoly jsou přesunuty do `CHANGELOG.md`.

**Použití:** Při implementaci odkazuj na číslo úkolu (např. "Implementuji #005").

---

## 🔥 Priority (High)

### Frontend pro Progression System (KRITICKÉ - backend hotový, UI chybí)

- [ ] **#055** - Frontend: Achievement systém UI (BACKEND + FRONTEND)
  - Stránka se seznamem všech achievementů (locked/unlocked)
  - Achievement card s ikonou, názvem, popisem, progress barem
  - Filtrování podle kategorie (tasks, punishments, streak, level, power)
  - Notifikace při odemčení nového achievementu (toast/modal)
  - API: GET /api/households/{id}/achievements (již existuje)

- [ ] **#056** - Frontend: Task Library browser (BACKEND + FRONTEND)
  - Procházení 720 úkolů z knihovny
  - Filtry: kategorie (household, protocol, BDSM, mental, fitness), obtížnost, level, BDSM intensity
  - Preview úkolu (title, description, duration, difficulty, points_reward)
  - Tlačítko "Přiřadit servantovi" (vytvoří task z template)
  - Možnost upravit úkol před přiřazením
  - Backend API: GET /api/task-library (nový endpoint)

- [ ] **#057** - Frontend: Punishment Library browser (BACKEND + FRONTEND)
  - Procházení 100 trestů z knihovny
  - Filtry: kategorie (physical, mental, restrictive, creative, universal), severity
  - Preview trestu (title, description, severity, BDSM flags)
  - Tlačítko "Udělit trest servantovi"
  - Backend API: GET /api/punishment-library (nový endpoint)

- [ ] **#058** - Frontend: Manuální penalizace UI pro dominu (BACKEND + FRONTEND)
  - Formulář pro udělení penalizace servantovi
  - Výběr typu penalizace (rule violation -20b, disrespect -50b)
  - Povinné pole "důvod" (min 3 znaky)
  - Zobrazení statistik penalizací (GET /api/households/{id}/penalties/stats)
  - API endpointy již existují: POST /api/households/{id}/penalties/rule-violation, POST /api/households/{id}/penalties/disrespect

- [ ] **#059** - Frontend: Odmítnutí úkolu (servant UI) (BACKEND + FRONTEND)
  - Tlačítko "Odmítnout úkol" v task assignment detailu
  - Modal s polem pro důvod odmítnutí
  - Varování o penalizaci pro dominu (-25b)
  - API endpoint již existuje: PUT /api/assignments/{id}/reject

### Ostatní High Priority

- [ ] **#007** - Notifikace o nových úkolech (BACKEND + FRONTEND)
  - Backend: WebSocket/Server-Sent Events pro real-time notifikace
  - Frontend: Toast notifikace, badge s počtem nedokončených úkolů

- [ ] **#008** - Filtrování úkolů (FRONTEND)
  - Frontend: Filtry podle statusu (pending, completed, verified)
  - Frontend: Filtry podle obtížnosti
  - Frontend: Filtry podle data vytvoření

- [ ] **#009** - Detailní zobrazení trestu (FRONTEND)
  - Frontend: Modal s detailem trestu (popis, důvod, severity)
  - Frontend: Historie trestů servanta
  - Frontend: Možnost servanta přidat komentář k trestu (nový backend endpoint)

---

## 🎯 Střední priorita (Medium)

### Autentizace
- [ ] **#010** - Reset hesla (BACKEND + FRONTEND)
  - Backend: Endpoint pro žádost o reset, generování tokenu, email
  - Backend: Endpoint pro změnu hesla s tokenem
  - Frontend: Formulář "Zapomenuté heslo"
  - Frontend: Stránka pro zadání nového hesla s tokenem

- [ ] **#011** - Two-factor authentication (2FA) (BACKEND + FRONTEND)
  - Backend: TOTP generování, verifikace (Google Authenticator)
  - Backend: SMS integrace (Twilio)
  - Frontend: Nastavení 2FA v profilu
  - Frontend: 2FA prompt při přihlášení
  - Povinná pro roli domina

### Profil
- [ ] **#012** - Nastavení profilu (BACKEND + FRONTEND)
  - Backend: Endpoint pro update profilu (jméno, bio, avatar)
  - Backend: Upload a resize profilového obrázku
  - Frontend: Formulář pro editaci profilu
  - Frontend: Upload interface pro avatar
  - Frontend: Preview změn před uložením

- [ ] **#013** - Preferenční nastavení (BACKEND + FRONTEND)
  - Backend: Endpoint pro update preferencí (language, notifications, theme)
  - Backend: Uložení do users.preferences (JSON column)
  - Frontend: Settings page s toggle switches
  - Frontend: Language selector (CZ/EN)
  - Frontend: Email notification preferences
  - Frontend: Dark/light theme toggle

### Progression System (Vzdělávací systém pro páry)

- [ ] **#041** - Onboarding flow s BDSM preferencemi (BACKEND + FRONTEND)
  - Backend: API pro uložení preferences (POST /api/households/{id}/preferences)
  - Backend: Uložení do household.preferences (JSON column)
  - Backend: Algoritmus pro doporučení startovního levelu
  - Frontend: Multi-step wizard (3-5 kroků)
  - Frontend: Kvíz zkušeností (beginner/intermediate/advanced)
  - Frontend: Lifestyle focus checkboxes (household, protocol, BDSM, mental, financial)
  - Frontend: BDSM intensity slider (none/soft/medium/hard)
  - Frontend: Hranice checklist (50+ položek: impact play, bondage, humiliation)
  - Frontend: Guided tour po dokončení + automatický první úkol

- [ ] **#043** - Použití curriculum šablon (FRONTEND - deprecated, nahrazeno #056)
  - Sloučeno do #056 Task Library browser
  - Task Library má filtry podle levelu a preferencí

- [ ] **#044** - Motivační systém pro servanta (FRONTEND)
  - Frontend: Vizualizace statistik servanta (tasks completed, success rate)
  - Frontend: Streak counter (dny v řadě bez selhání) - nový backend endpoint
  - Frontend: Historie úkolů s výsledky
  - Poznámka: V Power-Based System servant nemá vlastní body, závisí na domině

- [ ] **#045** - BDSM Preference System (BACKEND + FRONTEND)
  - Backend: Validace a uložení BDSM preferencí
  - Backend: Filtrování task library podle preferencí (match algorithm)
  - Frontend: Součást onboarding flow (#041)
  - Frontend: Editace preferencí v settings

- [ ] **#046** - Task Library Management API (BACKEND)
  - Backend: GET /api/task-library (s filtry: category, difficulty, bdsm_intensity, match_preferences)
  - Backend: POST /api/task-library/custom (vytvoření vlastního úkolu dominou)
  - Backend: PUT /api/task-library/{id} (editace vlastního úkolu)
  - Backend: DELETE /api/task-library/{id} (smazání vlastního úkolu)
  - Backend: Validace: pouze created_by = Auth::id() může editovat
  - Frontend: Implementováno v #056

- [ ] **#049** - Fitness Tracking System (BACKEND + FRONTEND)
  - Backend: API POST /api/fitness/tracking (denní záznam váhy, měření, kroky, kalorie, foto)
  - Backend: API GET /api/fitness/tracking (historie s filtrováním)
  - Backend: API PUT /api/households/{id}/fitness-goals (nastavení cílů)
  - Backend: API GET /api/fitness/weight-compliance (kontrola dodržení váhy)
  - Backend: Automatická penalizace při překročení tolerance (-15b)
  - Backend: Achievement za dosažení target_weight (+50b)
  - Frontend: Dashboard s grafem váhy (Chart.js/D3.js)
  - Frontend: Formulář pro denní report
  - Frontend: Upload interface pro progress foto
  - Frontend: Měření body (chest, waist, hips, arms, legs)

- [ ] **#050** - Feminine Power System (BACKEND + FRONTEND)
  - Backend: Databázová tabulka `domina_daily_checklist`
  - Backend: 5 levelů denních checklistů (progressive requirements: 3/5 → 7/9)
  - Backend: API POST /api/domina/checklist (domina vyplní)
  - Backend: API POST /api/domina/checklist/verify (servant witness)
  - Backend: API GET /api/domina/checklist, GET /api/domina/checklist/history
  - Backend: Cron job pro denní kontrolu (23:59)
  - Backend: Penalizace/body podle levelu
  - Backend: 70 úkolů kategorie Feminine Power (seed data)
  - Frontend: Domina checklist dashboard (daily checklist form)
  - Frontend: Servant verification interface
  - Frontend: Historie compliance s vizualizací
  - Validace: servant nemůže přepsat domina checklist

- [ ] **#051** - Recurring Tasks (BACKEND + FRONTEND)
  - Backend: Databázové sloupce v `tasks` (is_recurring, recurrence_pattern, atd.)
  - Backend: Cron job pro generování instancí (00:01 denně)
  - Backend: API POST /api/tasks (s periodicitou)
  - Backend: API PUT /api/tasks/{id}/recurring (activate/deactivate/edit)
  - Backend: API DELETE /api/tasks/{id} (smaže parent + pending instances)
  - Frontend: Periodicita při vytváření úkolu (radio buttons + date picker)
  - Frontend: Správa recurring tasks (seznam s toggle on/off)
  - Frontend: Servant dashboard zobrazí 🔁 ikonu
  - Frontend: Edit recurring pattern (změna periodicitu, end date)
  - Validace: interval 2-30, end_date max 1 rok

### Původní gamifikace (nahrazeno Progression System)
- [x] **#014** - DEPRECATED — nahrazeno #036-#051
- [x] **#015** - DEPRECATED — nahrazeno #036-#051

---

## 💡 Nízká priorita (Low)

### Komunikace
- [ ] **#016** - Chat mezi dominou a servantem (BACKEND + FRONTEND)
  - Backend: Databázové tabulky pro messages, conversations
  - Backend: WebSocket/Socket.io pro real-time messaging
  - Backend: API GET/POST /api/conversations/{id}/messages
  - Backend: Upload a storage pro obrázky v chatu
  - Frontend: Chat interface (message list, input, emoji picker)
  - Frontend: Real-time updates (WebSocket connection)
  - Frontend: Image upload a preview
  - Frontend: Conversation list s unread countem

- [ ] **#017** - Komentáře k úkolům (BACKEND + FRONTEND)
  - Backend: Tabulka task_comments (task_id, user_id, comment, created_at)
  - Backend: API GET/POST /api/tasks/{id}/comments
  - Frontend: Comment thread pod task detailem
  - Frontend: Formulář pro přidání komentáře
  - Frontend: Zobrazení komentářů s avatarem a timestampem

### Reporting
- [ ] **#018** - Exporty a statistiky (BACKEND + FRONTEND)
  - Backend: API GET /api/households/{id}/export (CSV/PDF format)
  - Backend: Generování PDF reportů (TCPDF/FPDF)
  - Backend: Agregace dat pro grafy (task completion rate, punishment trends)
  - Frontend: Export button s výběrem formátu
  - Frontend: Grafy výkonnosti (Chart.js) - task completion timeline, success rate
  - Frontend: Měsíční report preview před exportem
  - Frontend: Filter pro date range

- [ ] **#019** - Activity log (BACKEND + FRONTEND)
  - Backend: Již existuje activity_log tabulka, jen API chybí
  - Backend: API GET /api/households/{id}/activity-log (s paginací, filtry)
  - Frontend: Activity timeline UI
  - Frontend: Filtry podle action type (task.create, task.verify, penalty.applied)
  - Frontend: Filtry podle user (domina/servant)
  - Frontend: Filtry podle date range
  - Frontend: Infinite scroll nebo pagination

### Integrace
- [ ] **#020** - API pro třetí strany (BACKEND)
  - Backend: REST API dokumentace (OpenAPI/Swagger)
  - Backend: API keys generování a management
  - Backend: Webhook system (trigger events, delivery queue)
  - Backend: OAuth2 server implementation
  - Backend: Rate limiting a throttling
  - Frontend: Developer portal (API keys management)

- [ ] **#021** - Mobile app (FRONTEND - separate codebase)
  - React Native / Flutter
  - Push notifikace (FCM/APNS)
  - Offline mode s sync
  - Responsive layout pro mobile
  - Biometric auth (TouchID/FaceID)

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

**Aktivní úkoly:** 40
**High priority:** 7 (4 kritických frontend tasků pro Progression System + 3 ostatní)
**Medium priority:** 17 (vše BACKEND + FRONTEND)
**Low priority:** 6 (vše BACKEND + FRONTEND)
**Tech debt:** 5
**Nápady:** 4
**Deprecated:** 3 (#014, #015, #043 sloučeno do #056)
**Hotovo (v CHANGELOG.md):** 18

**KRITICKÉ:** Frontend pro Progression System (#055-#059) - backend hotový, UI chybí!
✓ #053 Dashboard pro dominu HOTOVO
✓ #054 Servant dashboard HOTOVO

---

**Další volné číslo:** #060

**Poznámka:** Po dokončení úkolu přesuň záznam do `CHANGELOG.md`.
