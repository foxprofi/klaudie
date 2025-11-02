# TODO - Klaudie Development

**Autor:** Klaudie <klaudie@foxprofi.cz>

Aktivní úkoly pro vývoj. Hotové úkoly jsou přesunuty do `CHANGELOG.md`.

**Použití:** Při implementaci odkazuj na číslo úkolu (např. "Implementuji #005").

---

## 🔥 Priority (High)

### Domácnosti
- [ ] **#006** - Dashboard pro servanta
  - Zobrazit informace o domácnosti, do které patří
  - Zobrazit jméno dominy
  - Statistiky servanta v rámci domácnosti

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

### Gamifikace
- [ ] **#014** - Achievement system
  - Odznaky za splněné milníky
  - Úrovně servanta (Beginner → Expert → Master)
  - Leaderboard mezi servanty v domácnosti

- [ ] **#015** - Body a levely
  - Vizualizace postupu k dalšímu levelu
  - Odměny za dosažení úrovní

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
  - Kompletní historie akcí v domácnosti
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

- **#029** - Multi-household support pro servanta? (jeden servant může patřit do více domácností)
- **#030** - Video call integrace mezi dominou a servantem?
- **#031** - AI asistent pro návrhy úkolů?
- **#032** - Kalendář s naplánovanými úkoly?
- **#033** - Recurring tasks (opakující se úkoly)?

---

## 📊 Statistiky

**Aktivní úkoly:** 28
**High priority:** 4
**Medium priority:** 6
**Low priority:** 6
**Tech debt:** 5
**Nápady:** 5
**Hotovo (v CHANGELOG.md):** 5

---

**Další volné číslo:** #034

**Poznámka:** Po dokončení úkolu přesuň záznam do `CHANGELOG.md`.
