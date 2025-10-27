<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Middleware;

use Klaudie\Services\Auth;
use Klaudie\Response;

/**
 * Authentication middleware
 * Ensures user is authenticated before accessing protected routes
 */
class AuthMiddleware implements MiddlewareInterface
{
    public function handle(): bool
    {
        if (!Auth::check()) {
            echo Response::unauthorized('Authentication required');
            return false;
        }

        return true;
    }
}
