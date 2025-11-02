# Klaudie

**Autor:** Klaudie <klaudie@foxprofi.cz>

Multi-tenant webová aplikace pro správu virtuální dominance. Systém zahrnuje role Domina/Servant, správu úkolů, bodový systém, gamifikaci a disciplinární protokoly.

## Technologie

- **Backend:** PHP 8.4
- **Database:** MySQL 8.0+
- **Frontend:** Vanilla JavaScript (SPA)
- **Architecture:** REST API, PSR-4 autoloading, MVC pattern

## Funkce

### Pro Dominu
- Vytváření a správa domácností (households)
- Přidávání servantů do domácností
- Vytváření úkolů a jejich přiřazování
- Verifikace dokončených úkolů
- Vydávání trestů různé závažnosti
- Sledování statistik servantů
- Real-time monitoring aktivit

### Pro Servanta
- Přehled přiřazených úkolů
- Označování úkolů jako dokončených
- Sledování bodů a levelů
- Přehled trestů
- Dashboard sProgressBar

## Instalace

### 1. Požadavky

- PHP 8.4 nebo vyšší
- MySQL 8.0 nebo vyšší
- Web server (Apache/Nginx)

### 2. Konfigurace databáze

Vytvořte `.env` soubor podle `.env.example`:

```bash
cp .env.example .env
```

Upravte konfiguraci databáze:

```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=virtual_domina
DB_USER=root
DB_PASS=your_password
```

### 3. Vytvoření databáze

```bash
mysql -u root -p
CREATE DATABASE virtual_domina CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EXIT;
```

### 4. Spuštění instalace

```bash
php install.php
```

Tento skript:
- Vytvoří všechny databázové tabulky
- Vytvoří výchozí Domina účet:
  - Email: `domina@example.com`
  - Heslo: `Domina123!`

### 5. Konfigurace web serveru

#### Apache (.htaccess)

```apache
RewriteEngine On
RewriteBase /

# Redirect all requests to public/index.php
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ public/index.php [QSA,L]
```

#### Nginx

```nginx
location / {
    try_files $uri $uri/ /public/index.php?$query_string;
}

location ~ \.php$ {
    fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    fastcgi_index index.php;
    include fastcgi_params;
}
```

### 6. Spuštění aplikace

#### Vývojový server (PHP built-in)

```bash
php -S localhost:8000 -t public
```

Aplikace bude dostupná na: `http://localhost:8000`

## Struktura projektu

```
klaudie/
├── autoload.php              # PSR-4 autoloader
├── install.php               # Instalační skript
├── composer.json             # Composer konfigurace
├── config/
│   ├── config.php           # Hlavní konfigurace
│   └── database.php         # Databázová konfigurace
├── database/
│   └── migrations/
│       └── 001_initial_schema.sql
├── src/
│   ├── Database.php         # Database singleton
│   ├── Router.php           # Router
│   ├── Response.php         # API response helper
│   ├── Controllers/         # API controllers
│   │   ├── AuthController.php
│   │   ├── HouseholdController.php
│   │   ├── TaskController.php
│   │   ├── PunishmentController.php
│   │   └── StatsController.php
│   ├── Models/              # Data models
│   │   ├── Model.php        # Base model
│   │   ├── User.php
│   │   ├── Household.php
│   │   ├── Task.php
│   │   ├── TaskAssignment.php
│   │   └── Punishment.php
│   ├── Middleware/          # Request middleware
│   │   ├── MiddlewareInterface.php
│   │   ├── AuthMiddleware.php
│   │   └── RoleMiddleware.php
│   └── Services/            # Business logic
│       ├── Session.php
│       ├── Auth.php
│       ├── PointsService.php
│       └── ActivityLogger.php
└── public/
    ├── index.php            # Application entry point
    ├── index.html           # Frontend SPA
    ├── css/
    │   └── style.css
    └── js/
        └── app.js

```

## API Endpoints

### Autentizace
- `POST /api/auth/register` - Registrace
- `POST /api/auth/login` - Přihlášení
- `POST /api/auth/logout` - Odhlášení
- `GET /api/auth/me` - Aktuální uživatel

### Domácnosti
- `GET /api/households` - Seznam domácností
- `POST /api/households` - Vytvořit domácnost (Domina)
- `GET /api/households/{id}` - Detail domácnosti
- `PUT /api/households/{id}` - Upravit domácnost (Domina)
- `DELETE /api/households/{id}` - Deaktivovat domácnost (Domina)
- `POST /api/households/{id}/servants` - Přidat servanta (Domina)
- `DELETE /api/households/{id}/servants/{servantId}` - Odebrat servanta (Domina)

### Úkoly
- `GET /api/households/{householdId}/tasks` - Seznam úkolů
- `POST /api/households/{householdId}/tasks` - Vytvořit úkol (Domina)
- `POST /api/tasks/{taskId}/assign` - Přiřadit úkol servantovi (Domina)
- `GET /api/assignments/my` - Moje úkoly (Servant)
- `PUT /api/assignments/{assignmentId}/complete` - Označit jako hotové (Servant)
- `PUT /api/assignments/{assignmentId}/verify` - Verifikovat úkol (Domina)

### Tresty
- `POST /api/households/{householdId}/punishments` - Vydat trest (Domina)
- `GET /api/households/{householdId}/punishments` - Seznam trestů (Domina)
- `GET /api/my-punishments` - Moje tresty (Servant)
- `PUT /api/punishments/{punishmentId}/resolve` - Vyřešit trest (Domina)

### Statistiky
- `GET /api/stats/dashboard` - Dashboard
- `GET /api/stats/servant/{servantId}/household/{householdId}` - Statistiky servanta (Domina)

## Bodový systém

### Získávání bodů
- Dokončení úkolu (po verifikaci Dominou)
- Body závisí na obtížnosti:
  - Trivial: 1x base points
  - Easy: 1.5x base points
  - Medium: 2x base points
  - Hard: 3x base points
  - Extreme: 5x base points

### Levely
- Level = Total Points / 100
- Každý level vyžaduje další 100 bodů
- Progress bar ukazuje postup k dalšímu levelu

### Tresty
- Warning: 0 bodů
- Minor: -10 bodů
- Moderate: -25 bodů
- Severe: -50 bodů
- Critical: -100 bodů

## Bezpečnost

- Hesla hashovaná pomocí Argon2id
- Session management s secure cookies
- Role-based access control (RBAC)
- Multi-tenant data isolation
- Activity logging pro audit trail

## Výchozí přihlašovací údaje

Po instalaci:
- **Email:** domina@example.com
- **Heslo:** Domina123!

⚠️ **Změňte heslo okamžitě po prvním přihlášení!**

## Vývoj

### Přidání nového endpointu

1. Vytvořte metodu v příslušném Controlleru
2. Přidejte route v `public/index.php`
3. Aktualizujte frontend API v `public/js/app.js`

### Přidání nového Modelu

1. Vytvořte třídu v `src/Models/` dědící z `Model`
2. Definujte `$table` property
3. Přidejte custom metody podle potřeby

## Licence

Proprietární software. Všechna práva vyhrazena.

**Autor:** Klaudie <klaudie@foxprofi.cz>

---

*Vytvořeno s absolutní přesností a bez kompromisů.*
