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
  - Tabulka `levels` (5 levelů dominy: Začátečnice → Expertka)
  - Tabulka `achievements` (odznaky za milníky)
  - Tabulka `user_achievements` (vazba user ↔ achievement)
  - Tabulka `curriculum_templates` (předpřipravené úkoly/tresty/pravidla dle levelů)
  - Tabulka `user_progress` (body, aktuální level, statistiky)

- [ ] **#037** - Level systém pro dominu
  - 5 levelů s různými oprávněními
  - Automatické odemykání funkcí podle pokroku
  - Progress bar k dalšímu levelu
  - Backend validace oprávnění podle levelu

- [ ] **#038** - Bodový systém
  - Body za akce dominy (vytvoření úkolu: 5b, verifikace: 10b, aplikace trestu: 15b)
  - Body za splněné úkoly servanta (podle obtížnosti: 5-25b)
  - Automatický přepočet bodů → level up

- [ ] **#039** - Achievement systém
  - Definice achievementů (První úkol, První týden, 10 úkolů, 100 úkolů)
  - Automatická detekce a odemykání achievementů
  - Notifikace při odemčení achievementu
  - Zobrazení achievementů v profilu

- [ ] **#040** - Curriculum (předpřipravený obsah)
  - Level 1: Jednoduché domácí úkoly (12 šablon)
  - Level 2: Základní pravidla chování (10 šablon)
  - Level 3: Lehké tresty (8 šablon)
  - Level 4: Pokročilé úkoly (15 šablon)
  - Level 5: Expertka — žádné šablony, vše vlastní

- [ ] **#041** - Onboarding flow pro nové páry
  - Úvodní kvíz (zkušenosti, hranice, preference)
  - Doporučení startovního levelu na základě odpovědí
  - Průvodce prvními kroky (guided tour)
  - Automatické vytvoření prvního jednoduchého úkolu

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
  - Žádné odměny — poslušnost JE odměna
  - Historie bodů a progressu

### Původní gamifikace (nahrazeno Progression System)
- [x] **#014** - DEPRECATED — nahrazeno #036-#044
- [x] **#015** - DEPRECATED — nahrazeno #036-#044

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

**Aktivní úkoly:** 35
**High priority:** 4
**Medium priority:** 13 (včetně 9 nových Progression System úkolů)
**Low priority:** 6
**Tech debt:** 5
**Nápady:** 5
**Deprecated:** 2
**Hotovo (v CHANGELOG.md):** 7

---

**Další volné číslo:** #045

**Poznámka:** Po dokončení úkolu přesuň záznam do `CHANGELOG.md`.
