<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

return [
    'app' => [
        'name' => 'Klaudie',
        'version' => '1.0.0',
        'environment' => $_ENV['APP_ENV'] ?? getenv('APP_ENV') ?: 'development',
        'debug' => ($_ENV['APP_DEBUG'] ?? getenv('APP_DEBUG')) === 'true',
        'timezone' => 'Europe/Prague',
        'url' => $_ENV['APP_URL'] ?? getenv('APP_URL') ?: 'http://localhost',
    ],

    'session' => [
        'name' => 'KLAUDIE_SESSION',
        'lifetime' => 7200, // 2 hours
        'secure' => ($_ENV['APP_ENV'] ?? getenv('APP_ENV')) === 'production',
        'httponly' => true,
        'samesite' => 'Lax',
    ],

    'security' => [
        'password_algorithm' => PASSWORD_ARGON2ID,
        'password_options' => [
            'memory_cost' => 65536,
            'time_cost' => 4,
            'threads' => 1,
        ],
    ],

    'points' => [
        'level_multiplier' => 100, // Points needed: level * multiplier
        'task_difficulty_multipliers' => [
            'trivial' => 1,
            'easy' => 1.5,
            'medium' => 2,
            'hard' => 3,
            'extreme' => 5,
        ],
    ],

    'punishments' => [
        'severity_penalties' => [
            'warning' => 0,
            'minor' => -10,
            'moderate' => -25,
            'severe' => -50,
            'critical' => -100,
        ],
    ],
];
