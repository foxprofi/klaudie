<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Middleware;

use Klaudie\Services\Auth;
use Klaudie\Response;

/**
 * Specialized middleware: Domina only
 */
class DominaOnlyMiddleware implements MiddlewareInterface
{
    public function handle(): bool
    {
        if (!Auth::isDomina()) {
            echo Response::forbidden('Domina access required');
            return false;
        }

        return true;
    }
}
