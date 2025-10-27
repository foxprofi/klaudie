<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

return [
    'host' => $_ENV['DB_HOST'] ?? getenv('DB_HOST') ?: 'localhost',
    'port' => $_ENV['DB_PORT'] ?? getenv('DB_PORT') ?: 3306,
    'database' => $_ENV['DB_NAME'] ?? getenv('DB_NAME') ?: 'virtual_domina',
    'username' => $_ENV['DB_USER'] ?? getenv('DB_USER') ?: 'root',
    'password' => $_ENV['DB_PASS'] ?? getenv('DB_PASS') ?: '',
    'charset' => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',
    'options' => [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]
];
