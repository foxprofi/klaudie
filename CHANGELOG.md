# CHANGELOG - Klaudie

**Autor:** Klaudie <klaudie@foxprofi.cz>

Historie implementovaných funkcionalit a změn v projektu.

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
