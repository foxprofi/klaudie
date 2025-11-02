#!/usr/bin/env php
<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * CLI Database Query Tool
 * Usage: php db-query.php --query="SELECT * FROM users LIMIT 5"
 * Usage: php db-query.php --table=users --limit=5
 */

require_once __DIR__ . '/bootstrap.php';
require_once __DIR__ . '/autoload.php';

use Klaudie\Database;

// Parse CLI arguments
$options = getopt('', ['query:', 'table:', 'where:', 'limit:', 'help']);

if (isset($options['help']) || empty($options)) {
    echo <<<HELP
Database Query Tool

Usage:
  php db-query.php --query="SELECT * FROM users LIMIT 5"
  php db-query.php --table=users --limit=5
  php db-query.php --table=users --where="role='domina'" --limit=10

Options:
  --query     Raw SQL query
  --table     Table name (for simple SELECT)
  --where     WHERE clause (use with --table)
  --limit     LIMIT clause
  --help      Show this help

HELP;
    exit(0);
}

try {
    $db = Database::getInstance();

    if (isset($options['query'])) {
        // Raw SQL query
        $result = $db->query($options['query']);
    } elseif (isset($options['table'])) {
        // Structured query
        $table = $options['table'];
        $sql = "SELECT * FROM {$table}";
        $params = [];

        if (isset($options['where'])) {
            $sql .= " WHERE {$options['where']}";
        }

        if (isset($options['limit'])) {
            $sql .= " LIMIT " . (int)$options['limit'];
        }

        $result = $db->query($sql, $params);
    } else {
        throw new Exception("Either --query or --table must be specified");
    }

    // Output JSON
    echo json_encode([
        'success' => true,
        'rows' => count($result),
        'data' => $result
    ], JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ], JSON_PRETTY_PRINT);
    exit(1);
}
