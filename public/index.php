<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Application entry point
 */

require_once __DIR__ . '/../bootstrap.php';
require_once __DIR__ . '/../autoload.php';

use Klaudie\Router;
use Klaudie\Controllers\AuthController;
use Klaudie\Controllers\HouseholdController;
use Klaudie\Controllers\TaskController;
use Klaudie\Controllers\PunishmentController;
use Klaudie\Controllers\StatsController;
use Klaudie\Middleware\AuthMiddleware;
use Klaudie\Middleware\DominaOnlyMiddleware;
use Klaudie\Middleware\ServantOnlyMiddleware;
use Klaudie\Response;

// Error handling
error_reporting(E_ALL);
ini_set('display_errors', 1);

set_error_handler(function ($severity, $message, $file, $line) {
    throw new ErrorException($message, 0, $severity, $file, $line);
});

set_exception_handler(function ($exception) {
    error_log($exception->getMessage());
    // Temporarily show full error for debugging
    if (getenv('APP_DEBUG') === 'true') {
        echo Response::json([
            'success' => false,
            'error' => $exception->getMessage(),
            'file' => $exception->getFile(),
            'line' => $exception->getLine(),
            'trace' => $exception->getTraceAsString(),
        ], 500);
    } else {
        echo Response::serverError('An unexpected error occurred');
    }
});

// CORS headers for API
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Initialize router
$router = new Router();

// Public routes
$router->post('/api/auth/login', [AuthController::class, 'login']);
$router->post('/api/auth/register', [AuthController::class, 'register']);

// Protected routes
$router->group([AuthMiddleware::class], function ($router) {
    // Auth routes
    $router->post('/api/auth/logout', [AuthController::class, 'logout']);
    $router->get('/api/auth/me', [AuthController::class, 'me']);

    // Stats/Dashboard (both roles)
    $router->get('/api/stats/dashboard', [StatsController::class, 'dashboard']);

    // Households (shared, both roles can view)
    $router->get('/api/households', [HouseholdController::class, 'index']);
    $router->get('/api/households/{id}', [HouseholdController::class, 'show']);

    // Domina-only routes
    $router->group([DominaOnlyMiddleware::class], function ($router) {
        // Household management
        $router->post('/api/households', [HouseholdController::class, 'create']);
        $router->put('/api/households/{id}', [HouseholdController::class, 'update']);
        $router->delete('/api/households/{id}', [HouseholdController::class, 'delete']);
        $router->post('/api/households/{id}/servants', [HouseholdController::class, 'addServant']);
        $router->delete('/api/households/{id}/servants/{servantId}', [HouseholdController::class, 'removeServant']);

        // Task management
        $router->get('/api/households/{householdId}/tasks', [TaskController::class, 'index']);
        $router->post('/api/households/{householdId}/tasks', [TaskController::class, 'create']);
        $router->post('/api/tasks/{taskId}/assign', [TaskController::class, 'assign']);
        $router->get('/api/households/{householdId}/assignments', [TaskController::class, 'householdAssignments']);
        $router->put('/api/assignments/{assignmentId}/verify', [TaskController::class, 'verify']);

        // Punishment management
        $router->post('/api/households/{householdId}/punishments', [PunishmentController::class, 'create']);
        $router->get('/api/households/{householdId}/punishments', [PunishmentController::class, 'index']);
        $router->put('/api/punishments/{punishmentId}/resolve', [PunishmentController::class, 'resolve']);

        // Servant statistics
        $router->get('/api/stats/servant/{servantId}/household/{householdId}', [StatsController::class, 'servantStats']);
    });

    // Servant-only routes
    $router->group([ServantOnlyMiddleware::class], function ($router) {
        // My assignments
        $router->get('/api/assignments/my', [TaskController::class, 'myAssignments']);
        $router->put('/api/assignments/{assignmentId}/complete', [TaskController::class, 'complete']);

        // My punishments
        $router->get('/api/my-punishments', [PunishmentController::class, 'myPunishments']);
    });
});

// Dispatch request
$router->dispatch();
