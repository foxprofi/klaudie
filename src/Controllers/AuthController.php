<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Services\Auth;
use Klaudie\Response;
use Klaudie\Services\ActivityLogger;

/**
 * Authentication controller
 * Handles login, registration, and logout
 */
class AuthController
{
    /**
     * POST /api/auth/login
     */
    public function login(): string
    {
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['email']) || !isset($data['password'])) {
            return Response::validationError([
                'email' => 'Email is required',
                'password' => 'Password is required',
            ]);
        }

        if (Auth::attempt($data['email'], $data['password'])) {
            ActivityLogger::log(Auth::id(), null, 'user.login', [
                'email' => $data['email'],
            ]);

            return Response::success([
                'user' => Auth::user(),
            ], 'Login successful');
        }

        return Response::error('Invalid credentials', 401);
    }

    /**
     * POST /api/auth/register
     */
    public function register(): string
    {
        $data = json_decode(file_get_contents('php://input'), true);

        // Validation
        $errors = [];
        if (!isset($data['email']) || !filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            $errors['email'] = 'Valid email is required';
        }
        if (!isset($data['password']) || strlen($data['password']) < 8) {
            $errors['password'] = 'Password must be at least 8 characters';
        }
        if (!isset($data['display_name']) || strlen($data['display_name']) < 2) {
            $errors['display_name'] = 'Display name is required (min 2 characters)';
        }
        if (!isset($data['role']) || !in_array($data['role'], ['domina', 'servant'])) {
            $errors['role'] = 'Role must be either "domina" or "servant"';
        }

        if (!empty($errors)) {
            return Response::validationError($errors);
        }

        $userId = Auth::register(
            $data['email'],
            $data['password'],
            $data['display_name'],
            $data['role']
        );

        if (!$userId) {
            return Response::error('Email already exists', 409);
        }

        // Auto-login after registration
        Auth::attempt($data['email'], $data['password']);

        ActivityLogger::log($userId, null, 'user.register', [
            'email' => $data['email'],
            'role' => $data['role'],
        ]);

        return Response::success([
            'user' => Auth::user(),
        ], 'Registration successful', 201);
    }

    /**
     * POST /api/auth/logout
     */
    public function logout(): string
    {
        $userId = Auth::id();

        ActivityLogger::log($userId, null, 'user.logout', []);

        Auth::logout();

        return Response::success(null, 'Logout successful');
    }

    /**
     * GET /api/auth/me
     */
    public function me(): string
    {
        if (!Auth::check()) {
            return Response::unauthorized();
        }

        return Response::success(Auth::user());
    }
}
