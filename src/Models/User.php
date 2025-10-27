<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Models;

/**
 * User model
 * Handles user data operations
 */
class User extends Model
{
    protected string $table = 'users';

    /**
     * Find user by email
     */
    public function findByEmail(string $email): ?array
    {
        return $this->findOne(['email' => $email]);
    }

    /**
     * Update last login timestamp
     */
    public function updateLastLogin(int $userId): void
    {
        $sql = "UPDATE {$this->table} SET last_login = NOW() WHERE id = ?";
        $this->db->execute($sql, [$userId]);
    }

    /**
     * Get all Dominas
     */
    public function getAllDominas(): array
    {
        return $this->findAll(['role' => 'domina', 'is_active' => true]);
    }

    /**
     * Get all Servants
     */
    public function getAllServants(): array
    {
        return $this->findAll(['role' => 'servant', 'is_active' => true]);
    }

    /**
     * Deactivate user
     */
    public function deactivate(int $userId): int
    {
        return $this->update($userId, ['is_active' => false]);
    }

    /**
     * Activate user
     */
    public function activate(int $userId): int
    {
        return $this->update($userId, ['is_active' => true]);
    }
}
