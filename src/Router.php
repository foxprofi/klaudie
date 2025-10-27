<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie;

/**
 * Simple but powerful router
 * Handles HTTP routing with middleware support
 */
class Router
{
    private array $routes = [];
    private array $middlewares = [];
    private array $groupMiddlewares = [];

    /**
     * Register GET route
     */
    public function get(string $path, callable|array $handler, array $middlewares = []): void
    {
        $this->addRoute('GET', $path, $handler, $middlewares);
    }

    /**
     * Register POST route
     */
    public function post(string $path, callable|array $handler, array $middlewares = []): void
    {
        $this->addRoute('POST', $path, $handler, $middlewares);
    }

    /**
     * Register PUT route
     */
    public function put(string $path, callable|array $handler, array $middlewares = []): void
    {
        $this->addRoute('PUT', $path, $handler, $middlewares);
    }

    /**
     * Register DELETE route
     */
    public function delete(string $path, callable|array $handler, array $middlewares = []): void
    {
        $this->addRoute('DELETE', $path, $handler, $middlewares);
    }

    /**
     * Register route group with shared middleware
     */
    public function group(array $middlewares, callable $callback): void
    {
        $this->groupMiddlewares = array_merge($this->groupMiddlewares, $middlewares);
        $callback($this);
        $this->groupMiddlewares = array_diff($this->groupMiddlewares, $middlewares);
    }

    /**
     * Add route to registry
     */
    private function addRoute(string $method, string $path, callable|array $handler, array $middlewares): void
    {
        $pattern = $this->convertPathToRegex($path);
        $allMiddlewares = array_merge($this->groupMiddlewares, $middlewares);

        $this->routes[] = [
            'method' => $method,
            'path' => $path,
            'pattern' => $pattern,
            'handler' => $handler,
            'middlewares' => $allMiddlewares,
        ];
    }

    /**
     * Convert path with parameters to regex
     * Example: /users/{id} -> /users/([^/]+)
     */
    private function convertPathToRegex(string $path): string
    {
        $pattern = preg_replace('/\{([a-zA-Z0-9_]+)\}/', '([^/]+)', $path);
        return '#^' . $pattern . '$#';
    }

    /**
     * Dispatch request to appropriate handler
     */
    public function dispatch(): void
    {
        $method = $_SERVER['REQUEST_METHOD'];
        $path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

        foreach ($this->routes as $route) {
            if ($route['method'] === $method && preg_match($route['pattern'], $path, $matches)) {
                array_shift($matches); // Remove full match

                // Execute middlewares
                foreach ($route['middlewares'] as $middleware) {
                    $middlewareInstance = new $middleware();
                    $result = $middlewareInstance->handle();
                    if ($result === false) {
                        return; // Middleware blocked request
                    }
                }

                // Execute handler
                if (is_array($route['handler'])) {
                    [$controller, $method] = $route['handler'];
                    $controllerInstance = new $controller();
                    echo call_user_func_array([$controllerInstance, $method], $matches);
                } else {
                    echo call_user_func_array($route['handler'], $matches);
                }
                return;
            }
        }

        // No route matched
        http_response_code(404);
        echo json_encode(['error' => 'Route not found']);
    }
}
