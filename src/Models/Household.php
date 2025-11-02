<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Models;

/**
 * Household model
 * Represents Domina's domain/household
 */
class Household extends Model
{
    protected string $table = 'households';

    /**
     * Get all households for a Domina
     */
    public function getByDomina(int $dominaId): array
    {
        return $this->findAll(['domina_id' => $dominaId, 'is_active' => true]);
    }

    /**
     * Find household by invitation key
     */
    public function findByKey(string $key): ?array
    {
        $sql = "SELECT * FROM {$this->table} WHERE household_key = ? AND is_active = true";
        return $this->db->queryOne($sql, [$key]);
    }

    /**
     * Create household with auto-generated UUID key
     */
    public function create(array $data): int
    {
        // Generate UUID if not provided
        if (!isset($data['household_key'])) {
            $data['household_key'] = $this->generateUUID();
        }

        return $this->insert($data);
    }

    /**
     * Generate UUID v4
     */
    private function generateUUID(): string
    {
        $sql = "SELECT UUID() as uuid";
        $result = $this->db->queryOne($sql);
        return $result['uuid'];
    }

    /**
     * Add servant to household
     */
    public function addServant(int $householdId, int $servantId, string $notes = null): int
    {
        $sql = "INSERT INTO household_members (household_id, servant_id, notes)
                VALUES (?, ?, ?)
                ON DUPLICATE KEY UPDATE status = 'active'";

        return $this->db->execute($sql, [$householdId, $servantId, $notes]);
    }

    /**
     * Remove servant from household
     */
    public function removeServant(int $householdId, int $servantId): int
    {
        $sql = "DELETE FROM household_members WHERE household_id = ? AND servant_id = ?";
        return $this->db->execute($sql, [$householdId, $servantId]);
    }

    /**
     * Update servant status in household
     */
    public function updateServantStatus(int $householdId, int $servantId, string $status): int
    {
        $sql = "UPDATE household_members SET status = ? WHERE household_id = ? AND servant_id = ?";
        return $this->db->execute($sql, [$status, $householdId, $servantId]);
    }

    /**
     * Get all servants in household
     */
    public function getServants(int $householdId): array
    {
        $sql = "SELECT u.*, hm.status, hm.joined_at, hm.notes
                FROM users u
                JOIN household_members hm ON u.id = hm.servant_id
                WHERE hm.household_id = ?";

        return $this->db->query($sql, [$householdId]);
    }

    /**
     * Get all households for a servant
     */
    public function getByServant(int $servantId): array
    {
        $sql = "SELECT h.*, hm.status, hm.joined_at
                FROM households h
                JOIN household_members hm ON h.id = hm.household_id
                WHERE hm.servant_id = ? AND h.is_active = true";

        return $this->db->query($sql, [$servantId]);
    }

    /**
     * Check if user owns household
     */
    public function isOwner(int $householdId, int $userId): bool
    {
        $household = $this->find($householdId);
        return $household && $household['domina_id'] == $userId;
    }

    /**
     * Check if servant is member of household
     */
    public function isMember(int $householdId, int $servantId): bool
    {
        $sql = "SELECT COUNT(*) as count FROM household_members
                WHERE household_id = ? AND servant_id = ? AND status = 'active'";

        $result = $this->db->queryOne($sql, [$householdId, $servantId]);
        return $result && $result['count'] > 0;
    }
}
