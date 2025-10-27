<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie;

/**
 * HTTP Response helper
 * Ensures consistent API responses
 */
class Response
{
    /**
     * Send JSON response
     */
    public static function json(mixed $data, int $statusCode = 200): string
    {
        http_response_code($statusCode);
        header('Content-Type: application/json');
        return json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }

    /**
     * Send success response
     */
    public static function success(mixed $data = null, string $message = 'Success', int $statusCode = 200): string
    {
        return self::json([
            'success' => true,
            'message' => $message,
            'data' => $data,
        ], $statusCode);
    }

    /**
     * Send error response
     */
    public static function error(string $message, int $statusCode = 400, mixed $details = null): string
    {
        return self::json([
            'success' => false,
            'error' => $message,
            'details' => $details,
        ], $statusCode);
    }

    /**
     * Send unauthorized response
     */
    public static function unauthorized(string $message = 'Unauthorized'): string
    {
        return self::error($message, 401);
    }

    /**
     * Send forbidden response
     */
    public static function forbidden(string $message = 'Forbidden'): string
    {
        return self::error($message, 403);
    }

    /**
     * Send not found response
     */
    public static function notFound(string $message = 'Not found'): string
    {
        return self::error($message, 404);
    }

    /**
     * Send validation error response
     */
    public static function validationError(array $errors): string
    {
        return self::error('Validation failed', 422, $errors);
    }

    /**
     * Send server error response
     */
    public static function serverError(string $message = 'Internal server error'): string
    {
        return self::error($message, 500);
    }
}
