<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Database installation script
 * Run this once to initialize the database
 */

require_once __DIR__ . '/bootstrap.php';
require_once __DIR__ . '/autoload.php';

use Klaudie\Database;

echo "===========================================\n";
echo "Virtual Domina - Database Installation\n";
echo "===========================================\n\n";

try {
    echo "Connecting to database...\n";
    $db = Database::getInstance();
    $pdo = $db->getConnection();

    echo "Reading migration file...\n";
    $sql = file_get_contents(__DIR__ . '/database/migrations/001_initial_schema.sql');

    echo "Executing migration...\n";
    $pdo->exec($sql);

    echo "\n✓ Database schema created successfully!\n\n";

    // Create default Domina account
    echo "Creating default Domina account...\n";
    $passwordHash = password_hash('Domina123!', PASSWORD_ARGON2ID);

    $db->execute(
        "INSERT INTO users (email, password_hash, display_name, role)
         VALUES (?, ?, ?, ?)",
        ['domina@example.com', $passwordHash, 'Mistress', 'domina']
    );

    echo "✓ Default Domina created!\n";
    echo "  Email: domina@example.com\n";
    echo "  Password: Domina123!\n\n";

    echo "===========================================\n";
    echo "Installation completed successfully!\n";
    echo "===========================================\n";

} catch (Exception $e) {
    echo "\n✗ Error: " . $e->getMessage() . "\n";
    exit(1);
}
