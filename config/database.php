<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

// Auto-detect Docker environment
$isDocker = file_exists('/.dockerenv') || (getenv('DOCKER_CONTAINER') === 'true');
$defaultHost = $isDocker ? 'host.docker.internal' : 'localhost';
$dbHost = $_ENV['DB_HOST'] ?? getenv('DB_HOST') ?: $defaultHost;

// Override for Docker if using external IP
if ($isDocker && $dbHost === '192.168.31.139') {
    $dbHost = 'host.docker.internal';
}

return [
    'host' => $dbHost,
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
