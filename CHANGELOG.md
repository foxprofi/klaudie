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

- **#002** - Automatické přiřazení servanta do domácnosti při registraci
  - Servant je okamžitě přidán do `household_members` po registraci
  - Vazba mezi servantem a domácností vytvořena atomicky

- **#003** - Skrytí záložky "Domácnosti" pro servanta
  - Frontend logika skrývá menu "Domácnosti" pro roli servant
  - Servant vidí pouze: Dashboard, Úkoly, Moje tresty

- **#004** - UUID klíč pro pozvání servantů
  - Databázová migrace `002_add_household_key.sql`
  - Sloupec `household_key` (CHAR(36), UNIQUE) v tabulce `households`
  - Automatické generování UUID při vytvoření domácnosti
  - Metody `findByKey()` a `generateUUID()` v Household modelu

### Changed
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
