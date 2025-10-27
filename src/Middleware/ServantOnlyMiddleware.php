<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Middleware;

use Klaudie\Services\Auth;
use Klaudie\Response;

/**
 * Specialized middleware: Servant only
 */
class ServantOnlyMiddleware implements MiddlewareInterface
{
    public function handle(): bool
    {
        if (!Auth::isServant()) {
            echo Response::forbidden('Servant access required');
            return false;
        }

        return true;
    }
}
