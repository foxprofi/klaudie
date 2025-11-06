#!/usr/bin/env php
<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Cron job for automatic penalty checks
 * Run daily at 00:01
 *
 * Usage:
 * 0 0 * * * /usr/bin/php /path/to/klaudie/bin/cron-penalties.php
 */

require_once __DIR__ . '/../bootstrap.php';
require_once __DIR__ . '/../autoload.php';

use Klaudie\Services\PenaltyService;

echo "[" . date('Y-m-d H:i:s') . "] Starting penalty checks\n";

// Check for inactivity penalties (no completed task in 24h)
echo "Checking inactivity penalties...\n";
$inactivityResults = PenaltyService::checkInactivityPenalties();
echo "Applied " . count($inactivityResults) . " inactivity penalties\n";

foreach ($inactivityResults as $result) {
    echo "  - Household #{$result['household_id']}, Servant #{$result['servant_id']}: {$result['penalty']} points ({$result['reason']})\n";
}

// Check for deadline penalties
echo "Checking deadline penalties...\n";
$deadlineResults = PenaltyService::checkDeadlinePenalties();
echo "Applied " . count($deadlineResults) . " deadline penalties\n";

foreach ($deadlineResults as $result) {
    echo "  - Household #{$result['household_id']}, Assignment #{$result['assignment_id']}: {$result['penalty']} points ({$result['reason']})\n";
}

echo "[" . date('Y-m-d H:i:s') . "] Penalty checks completed\n";
echo "Total penalties applied: " . (count($inactivityResults) + count($deadlineResults)) . "\n";
