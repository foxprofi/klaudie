<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Services;

/**
 * Session management
 * Handles secure session operations
 */
class Session
{
    private static bool $started = false;

    /**
     * Start session if not already started
     */
    public static function start(): void
    {
        if (self::$started || session_status() === PHP_SESSION_ACTIVE) {
            return;
        }

        $config = require __DIR__ . '/../../config/config.php';

        session_name($config['session']['name']);
        session_set_cookie_params([
            'lifetime' => $config['session']['lifetime'],
            'path' => '/',
            'domain' => '',
            'secure' => $config['session']['secure'],
            'httponly' => $config['session']['httponly'],
            'samesite' => $config['session']['samesite'],
        ]);

        session_start();
        self::$started = true;
    }

    /**
     * Set session value
     */
    public static function set(string $key, mixed $value): void
    {
        self::start();
        $_SESSION[$key] = $value;
    }

    /**
     * Get session value
     */
    public static function get(string $key, mixed $default = null): mixed
    {
        self::start();
        return $_SESSION[$key] ?? $default;
    }

    /**
     * Check if session key exists
     */
    public static function has(string $key): bool
    {
        self::start();
        return isset($_SESSION[$key]);
    }

    /**
     * Remove session value
     */
    public static function remove(string $key): void
    {
        self::start();
        unset($_SESSION[$key]);
    }

    /**
     * Destroy entire session
     */
    public static function destroy(): void
    {
        self::start();
        session_destroy();
        self::$started = false;
    }

    /**
     * Regenerate session ID (security measure)
     */
    public static function regenerate(): void
    {
        self::start();
        session_regenerate_id(true);
    }
}
