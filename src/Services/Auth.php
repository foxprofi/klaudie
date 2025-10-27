<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Services;

use Klaudie\Models\User;

/**
 * Authentication service
 * Handles login, logout, and user state
 */
class Auth
{
    private const SESSION_USER_KEY = 'user_id';
    private const SESSION_ROLE_KEY = 'user_role';

    /**
     * Attempt login with credentials
     */
    public static function attempt(string $email, string $password): bool
    {
        $userModel = new User();
        $user = $userModel->findByEmail($email);

        if (!$user || !password_verify($password, $user['password_hash'])) {
            return false;
        }

        if (!$user['is_active']) {
            return false;
        }

        // Update last login
        $userModel->updateLastLogin($user['id']);

        // Set session
        Session::regenerate();
        Session::set(self::SESSION_USER_KEY, $user['id']);
        Session::set(self::SESSION_ROLE_KEY, $user['role']);

        return true;
    }

    /**
     * Register new user
     */
    public static function register(string $email, string $password, string $displayName, string $role = 'servant'): ?int
    {
        $config = require __DIR__ . '/../../config/config.php';

        $passwordHash = password_hash(
            $password,
            $config['security']['password_algorithm'],
            $config['security']['password_options']
        );

        $userModel = new User();

        // Check if email already exists
        if ($userModel->findByEmail($email)) {
            return null;
        }

        return $userModel->insert([
            'email' => $email,
            'password_hash' => $passwordHash,
            'display_name' => $displayName,
            'role' => $role,
        ]);
    }

    /**
     * Logout current user
     */
    public static function logout(): void
    {
        Session::destroy();
    }

    /**
     * Check if user is authenticated
     */
    public static function check(): bool
    {
        return Session::has(self::SESSION_USER_KEY);
    }

    /**
     * Get current user ID
     */
    public static function id(): ?int
    {
        return Session::get(self::SESSION_USER_KEY);
    }

    /**
     * Get current user role
     */
    public static function role(): ?string
    {
        return Session::get(self::SESSION_ROLE_KEY);
    }

    /**
     * Get current user data
     */
    public static function user(): ?array
    {
        $id = self::id();
        if (!$id) {
            return null;
        }

        $userModel = new User();
        return $userModel->find($id);
    }

    /**
     * Check if current user is Domina
     */
    public static function isDomina(): bool
    {
        return self::role() === 'domina';
    }

    /**
     * Check if current user is Servant
     */
    public static function isServant(): bool
    {
        return self::role() === 'servant';
    }
}
