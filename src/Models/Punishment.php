<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Models;

/**
 * Punishment model
 * Disciplinary records and penalties
 */
class Punishment extends Model
{
    protected string $table = 'punishments';

    /**
     * Get punishments for servant
     */
    public function getByServant(int $servantId, int $householdId): array
    {
        return $this->findAll([
            'servant_id' => $servantId,
            'household_id' => $householdId,
        ], ['issued_at' => 'DESC']);
    }

    /**
     * Get punishments for household
     */
    public function getByHousehold(int $householdId): array
    {
        $sql = "SELECT p.*, u.display_name as servant_name
                FROM punishments p
                JOIN users u ON p.servant_id = u.id
                WHERE p.household_id = ?
                ORDER BY p.issued_at DESC";

        return $this->db->query($sql, [$householdId]);
    }

    /**
     * Get active (unresolved) punishments
     */
    public function getActive(int $servantId, int $householdId): array
    {
        $sql = "SELECT * FROM {$this->table}
                WHERE servant_id = ? AND household_id = ? AND resolved_at IS NULL
                ORDER BY issued_at DESC";

        return $this->db->query($sql, [$servantId, $householdId]);
    }

    /**
     * Resolve punishment
     */
    public function resolve(int $punishmentId, string $notes = null): int
    {
        return $this->update($punishmentId, [
            'resolved_at' => date('Y-m-d H:i:s'),
            'resolution_notes' => $notes,
        ]);
    }

    /**
     * Get punishment statistics for servant
     */
    public function getServantStats(int $servantId, int $householdId): array
    {
        $sql = "SELECT
                    COUNT(*) as total,
                    SUM(CASE WHEN severity = 'warning' THEN 1 ELSE 0 END) as warnings,
                    SUM(CASE WHEN severity = 'minor' THEN 1 ELSE 0 END) as minor,
                    SUM(CASE WHEN severity = 'moderate' THEN 1 ELSE 0 END) as moderate,
                    SUM(CASE WHEN severity = 'severe' THEN 1 ELSE 0 END) as severe,
                    SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END) as critical,
                    SUM(CASE WHEN resolved_at IS NULL THEN 1 ELSE 0 END) as active
                FROM punishments
                WHERE servant_id = ? AND household_id = ?";

        return $this->db->queryOne($sql, [$servantId, $householdId]) ?? [];
    }
}
