<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Models;

use Klaudie\Database;
use PDO;

/**
 * Base model class
 * Provides common database operations for all models
 */
abstract class Model
{
    protected Database $db;
    protected string $table;
    protected string $primaryKey = 'id';

    public function __construct()
    {
        $this->db = Database::getInstance();
    }

    /**
     * Find record by ID
     */
    public function find(int $id): ?array
    {
        $sql = "SELECT * FROM {$this->table} WHERE {$this->primaryKey} = ?";
        return $this->db->queryOne($sql, [$id]);
    }

    /**
     * Find all records with optional conditions
     */
    public function findAll(array $conditions = [], array $orderBy = [], ?int $limit = null): array
    {
        $sql = "SELECT * FROM {$this->table}";
        $params = [];

        if (!empty($conditions)) {
            $where = [];
            foreach ($conditions as $key => $value) {
                $where[] = "$key = ?";
                $params[] = $value;
            }
            $sql .= " WHERE " . implode(' AND ', $where);
        }

        if (!empty($orderBy)) {
            $orderClauses = [];
            foreach ($orderBy as $column => $direction) {
                $orderClauses[] = "$column $direction";
            }
            $sql .= " ORDER BY " . implode(', ', $orderClauses);
        }

        if ($limit !== null) {
            $sql .= " LIMIT ?";
            $params[] = $limit;
        }

        return $this->db->query($sql, $params);
    }

    /**
     * Find first record matching conditions
     */
    public function findOne(array $conditions): ?array
    {
        $results = $this->findAll($conditions, [], 1);
        return $results[0] ?? null;
    }

    /**
     * Insert new record
     */
    public function insert(array $data): int
    {
        $columns = array_keys($data);
        $placeholders = array_fill(0, count($data), '?');

        $sql = sprintf(
            "INSERT INTO %s (%s) VALUES (%s)",
            $this->table,
            implode(', ', $columns),
            implode(', ', $placeholders)
        );

        $this->db->execute($sql, array_values($data));
        return (int) $this->db->lastInsertId();
    }

    /**
     * Update record by ID
     */
    public function update(int $id, array $data): int
    {
        $set = [];
        $params = [];

        foreach ($data as $key => $value) {
            $set[] = "$key = ?";
            $params[] = $value;
        }
        $params[] = $id;

        $sql = sprintf(
            "UPDATE %s SET %s WHERE %s = ?",
            $this->table,
            implode(', ', $set),
            $this->primaryKey
        );

        return $this->db->execute($sql, $params);
    }

    /**
     * Delete record by ID
     */
    public function delete(int $id): int
    {
        $sql = "DELETE FROM {$this->table} WHERE {$this->primaryKey} = ?";
        return $this->db->execute($sql, [$id]);
    }

    /**
     * Count records with optional conditions
     */
    public function count(array $conditions = []): int
    {
        $sql = "SELECT COUNT(*) as count FROM {$this->table}";
        $params = [];

        if (!empty($conditions)) {
            $where = [];
            foreach ($conditions as $key => $value) {
                $where[] = "$key = ?";
                $params[] = $value;
            }
            $sql .= " WHERE " . implode(' AND ', $where);
        }

        $result = $this->db->queryOne($sql, $params);
        return (int) ($result['count'] ?? 0);
    }
}
