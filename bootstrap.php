<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Bootstrap - Load environment variables from .env file
 */

// Load .env file if exists
$envFile = __DIR__ . '/.env';
if (file_exists($envFile)) {
    $lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        // Skip comments
        if (strpos(trim($line), '#') === 0) {
            continue;
        }

        // Parse KEY=VALUE
        if (strpos($line, '=') !== false) {
            list($key, $value) = explode('=', $line, 2);
            $key = trim($key);
            $value = trim($value);

            // Set in $_ENV and putenv
            $_ENV[$key] = $value;
            putenv("$key=$value");
        }
    }
}
