<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Models\Household;
use Klaudie\Models\TaskAssignment;
use Klaudie\Models\Punishment;
use Klaudie\Services\Auth;
use Klaudie\Services\PointsService;
use Klaudie\Response;

/**
 * Statistics controller
 * Dashboard and analytics
 */
class StatsController
{
    /**
     * GET /api/stats/dashboard
     * Get dashboard overview for current user
     */
    public function dashboard(): string
    {
        if (Auth::isDomina()) {
            return $this->dominaDashboard();
        } else {
            return $this->servantDashboard();
        }
    }

    /**
     * Domina dashboard
     */
    private function dominaDashboard(): string
    {
        $householdModel = new Household();
        $households = $householdModel->getByDomina(Auth::id());

        $stats = [
            'total_households' => count($households),
            'total_servants' => 0,
            'total_tasks' => 0,
            'pending_verifications' => 0,
            'recent_activities' => [],
        ];

        foreach ($households as $household) {
            $servants = $householdModel->getServants($household['id']);
            $stats['total_servants'] += count($servants);

            $assignmentModel = new TaskAssignment();
            $pendingVerifications = $assignmentModel->getByHousehold($household['id'], 'completed');
            $stats['pending_verifications'] += count($pendingVerifications);
        }

        return Response::success($stats);
    }

    /**
     * Servant dashboard
     */
    private function servantDashboard(): string
    {
        $householdModel = new Household();
        $households = $householdModel->getByServant(Auth::id());

        $stats = [
            'households' => [],
        ];

        foreach ($households as $household) {
            $householdId = $household['id'];

            $assignmentModel = new TaskAssignment();
            $taskStats = $assignmentModel->getServantStats(Auth::id(), $householdId);

            $levelInfo = PointsService::getLevelInfo(Auth::id(), $householdId);

            $punishmentModel = new Punishment();
            $punishmentStats = $punishmentModel->getServantStats(Auth::id(), $householdId);

            $stats['households'][] = [
                'household' => $household,
                'level' => $levelInfo,
                'tasks' => $taskStats,
                'punishments' => $punishmentStats,
            ];
        }

        return Response::success($stats);
    }

    /**
     * GET /api/stats/servant/{servantId}/household/{householdId}
     * Get detailed stats for specific servant in household (Domina)
     */
    public function servantStats(int $servantId, int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden();
        }

        $levelInfo = PointsService::getLevelInfo($servantId, $householdId);

        $assignmentModel = new TaskAssignment();
        $taskStats = $assignmentModel->getServantStats($servantId, $householdId);

        $punishmentModel = new Punishment();
        $punishmentStats = $punishmentModel->getServantStats($servantId, $householdId);

        $pointsHistory = PointsService::getHistory($servantId, $householdId, 20);

        return Response::success([
            'level' => $levelInfo,
            'tasks' => $taskStats,
            'punishments' => $punishmentStats,
            'points_history' => $pointsHistory,
        ]);
    }
}
