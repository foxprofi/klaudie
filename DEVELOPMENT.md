# Development Notes

**Autor:** Klaudie <klaudie@foxprofi.cz>

## Database Connection Setup

### Problém
Projekt běží ve dvou prostředích:
- **Docker kontejner** (aplikace na `localhost:39111`)
- **Hostitelský systém** (CLI nástroje jako `db-query.php`)

MySQL server běží na externím hostu `192.168.31.139:8889`.

### Řešení
`config/database.php` obsahuje automatickou detekci prostředí:

```php
// Auto-detect Docker environment
$isDocker = file_exists('/.dockerenv') || (getenv('DOCKER_CONTAINER') === 'true');
$defaultHost = $isDocker ? 'host.docker.internal' : 'localhost';
$dbHost = $_ENV['DB_HOST'] ?? getenv('DB_HOST') ?: $defaultHost;

// Override for Docker if using external IP
if ($isDocker && $dbHost === '192.168.31.139') {
    $dbHost = 'host.docker.internal';
}
```

### Jak to funguje
- **V Dockeru:** Detekuje `/.dockerenv`, použije `host.docker.internal` → routuje na `192.168.31.139:8889`
- **Na hostiteli:** Použije přímou IP `192.168.31.139` z `.env`

### .env konfigurace
```env
DB_HOST=192.168.31.139
DB_PORT=8889
DB_NAME=klaudie
DB_USER=webuser
DB_PASS=web123456789
```

V Dockeru se `DB_HOST` automaticky přepíše na `host.docker.internal`.

### Internal API Configuration
Bezpečnostní údaje pro interní API jsou v `.env`:

```env
INTERNAL_API_URL=http://localhost:39111/api/internal/query
INTERNAL_API_KEY=klaudie_internal_2024
```

**Použití:**
- `query-db.sh` automaticky načítá tyto hodnoty z `.env`
- Nikdy necommituj `.env` do gitu (už je v `.gitignore`)
- Pro nové vývojáře: zkopíruj `.env.example` do `.env` a nastav správné hodnoty

### Password Hashing
Konfigurace v `config/config.php`:

```php
'security' => [
    'password_algorithm' => PASSWORD_ARGON2ID,
    'password_options' => [
        'memory_cost' => 65536,
        'time_cost' => 4,
        'threads' => 1,  // DŮLEŽITÉ: threads=1 pro konzistenci hashů
    ],
],
```

**Pozor:** Hash vygenerovaný s `threads => 3` nebude fungovat s heslem při `threads => 1`. Vždy používej stejnou konfiguraci.

### Testování připojení

**Z Dockeru:**
```bash
docker exec klaudie php -r "
\$conn = new PDO('mysql:host=host.docker.internal;port=8889;dbname=klaudie', 'webuser', 'web123456789');
echo 'SUCCESS';
"
```

**Z hostitele:**
```bash
php db-query.php --query="SELECT 1"
```

### Vygenerování password hashe
```bash
docker exec klaudie php -r "echo password_hash('TvojeHeslo', PASSWORD_ARGON2ID);"
```

---

*Dokumentace vytvořena po debugování connection issues. Neměň bez důvodu.*
