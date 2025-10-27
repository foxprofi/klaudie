<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Middleware;

use Klaudie\Services\Auth;
use Klaudie\Response;

/**
 * Role-based access control middleware
 * Restricts access based on user role
 */
class RoleMiddleware implements MiddlewareInterface
{
    private array $allowedRoles;

    public function __construct(array $allowedRoles)
    {
        $this->allowedRoles = $allowedRoles;
    }

    public function handle(): bool
    {
        $currentRole = Auth::role();

        if (!$currentRole || !in_array($currentRole, $this->allowedRoles)) {
            echo Response::forbidden('Insufficient permissions');
            return false;
        }

        return true;
    }
}

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
