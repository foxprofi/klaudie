<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Middleware;

/**
 * Middleware interface
 * All middleware must implement this
 */
interface MiddlewareInterface
{
    /**
     * Handle middleware logic
     * Return false to block request, true to continue
     */
    public function handle(): bool;
}
