<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Database;
use Klaudie\Response;

/**
 * Internal API controller
 * For system queries and debugging
 */
class InternalController
{
    /**
     * POST /api/internal/query
     * Execute database query
     */
    public function query(): string
    {
        // Security: require specific header
        $authHeader = $_SERVER['HTTP_X_INTERNAL_KEY'] ?? '';
        $expectedKey = $_ENV['INTERNAL_API_KEY'] ?? 'klaudie_internal_2024';

        if ($authHeader !== $expectedKey) {
            return Response::error('Unauthorized', 401);
        }

        $data = json_decode(file_get_contents('php://input'), true);
        $db = Database::getInstance();

        try {
            if (isset($data['query'])) {
                // Raw SQL
                $result = $db->query($data['query'], $data['params'] ?? []);
            } elseif (isset($data['table'])) {
                // Structured query
                $table = $data['table'];
                $sql = "SELECT * FROM {$table}";
                $params = [];

                if (isset($data['where'])) {
                    $whereClauses = [];
                    foreach ($data['where'] as $key => $value) {
                        $whereClauses[] = "{$key} = ?";
                        $params[] = $value;
                    }
                    $sql .= " WHERE " . implode(' AND ', $whereClauses);
                }

                if (isset($data['limit'])) {
                    $sql .= " LIMIT " . (int)$data['limit'];
                }

                if (isset($data['order'])) {
                    $sql .= " ORDER BY {$data['order']}";
                }

                $result = $db->query($sql, $params);
            } else {
                return Response::error('Either query or table must be specified');
            }

            return Response::success([
                'rows' => count($result),
                'data' => $result
            ]);

        } catch (\Exception $e) {
            return Response::error($e->getMessage(), 500);
        }
    }

    /**
     * POST /api/internal/execute
     * Execute INSERT/UPDATE/DELETE
     */
    public function execute(): string
    {
        $authHeader = $_SERVER['HTTP_X_INTERNAL_KEY'] ?? '';
        $expectedKey = $_ENV['INTERNAL_API_KEY'] ?? 'klaudie_internal_2024';

        if ($authHeader !== $expectedKey) {
            return Response::error('Unauthorized', 401);
        }

        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['query'])) {
            return Response::error('Query is required');
        }

        $db = Database::getInstance();

        try {
            $affected = $db->execute($data['query'], $data['params'] ?? []);

            return Response::success([
                'affected_rows' => $affected,
                'last_insert_id' => $db->lastInsertId()
            ]);

        } catch (\Exception $e) {
            return Response::error($e->getMessage(), 500);
        }
    }

    /**
     * GET /api/internal/tables
     * List all tables
     */
    public function tables(): string
    {
        $authHeader = $_SERVER['HTTP_X_INTERNAL_KEY'] ?? '';
        $expectedKey = $_ENV['INTERNAL_API_KEY'] ?? 'klaudie_internal_2024';

        if ($authHeader !== $expectedKey) {
            return Response::error('Unauthorized', 401);
        }

        $db = Database::getInstance();

        try {
            $tables = $db->query("SHOW TABLES");

            return Response::success([
                'count' => count($tables),
                'tables' => array_map(fn($t) => array_values($t)[0], $tables)
            ]);

        } catch (\Exception $e) {
            return Response::error($e->getMessage(), 500);
        }
    }
}
