# Recurring Tasks System

**Autor:** Klaudie <klaudie@foxprofi.cz>

Systém opakujících se úkolů. Domina nastaví periodicitu, systém automaticky vytváří instance.

---

## Koncept

Domina má absolutní kontrolu. Když vytváří úkol, může nastavit:
- **Neopakovat** (default) — jednorázový
- **Denně** — každý den ve stejný čas
- **Každých X dní** (2-30) — custom interval
- **Týdně** — každý týden (výběr dne)
- **Měsíčně** — každý měsíc (výběr dne)

**Příklady:**
- Ranní káva denně v 08:00
- Úklid koupelny každý pátek v 18:00
- Fitness report každé 3 dny
- Návštěva kadeřníka každý měsíc 1. den

---

## Databázová struktura

### Rozšíření tabulky `tasks`

```sql
ALTER TABLE tasks ADD COLUMN is_recurring BOOLEAN DEFAULT FALSE;
ALTER TABLE tasks ADD COLUMN recurrence_pattern VARCHAR(50) NULL; -- 'daily', 'every_x_days', 'weekly', 'monthly'
ALTER TABLE tasks ADD COLUMN recurrence_interval INT NULL; -- pro 'every_x_days' (2-30)
ALTER TABLE tasks ADD COLUMN recurrence_day_of_week INT NULL; -- pro 'weekly' (1-7, pondělí-neděle)
ALTER TABLE tasks ADD COLUMN recurrence_day_of_month INT NULL; -- pro 'monthly' (1-31)
ALTER TABLE tasks ADD COLUMN recurring_task_id INT NULL; -- ID parent recurring task
ALTER TABLE tasks ADD COLUMN recurrence_end_date DATE NULL; -- volitelné datum ukončení
ALTER TABLE tasks ADD COLUMN recurrence_active BOOLEAN DEFAULT TRUE; -- domina může vypnout

ALTER TABLE tasks ADD FOREIGN KEY (recurring_task_id) REFERENCES tasks(id) ON DELETE CASCADE;
ALTER TABLE tasks ADD INDEX idx_recurring (is_recurring, recurrence_active);
ALTER TABLE tasks ADD INDEX idx_recurring_parent (recurring_task_id);
```

**Struktura:**
- **Parent task** = šablona (první úkol, `is_recurring=true`)
- **Child tasks** = instance (auto-generované, `recurring_task_id=parent.id`)

---

## Flow

### 1. Vytváření recurring task

**API:**
```php
POST /api/tasks
{
  "title": "Ranní káva",
  "description": "Přines kávu do postele",
  "assigned_to": 456,
  "deadline": "2025-11-03 08:00:00",
  "difficulty": "easy",
  "is_recurring": true,
  "recurrence_pattern": "daily",
  "recurrence_end_date": null
}

// Nebo weekly:
{
  ...
  "recurrence_pattern": "weekly",
  "recurrence_day_of_week": 5, // pátek
  "deadline": "2025-11-08 18:00:00"
}

// Nebo every_x_days:
{
  ...
  "recurrence_pattern": "every_x_days",
  "recurrence_interval": 3,
  "deadline": "2025-11-03 18:00:00"
}

Response: {
  "id": 789,
  "is_recurring": true,
  "message": "Recurring task created. Next instances will be auto-generated."
}
```

---

### 2. Automatické generování instancí (cron job)

```php
// Cron: každý den v 00:01
public function generateRecurringTaskInstances(): void
{
    $parentTasks = Task::where('is_recurring', true)
        ->where('recurrence_active', true)
        ->get();

    foreach ($parentTasks as $parent) {
        // Check end_date
        if ($parent->recurrence_end_date && now() > $parent->recurrence_end_date) {
            $parent->recurrence_active = false;
            $parent->save();
            continue;
        }

        // Get last instance
        $lastInstance = Task::where('recurring_task_id', $parent->id)
            ->orderBy('deadline', 'desc')
            ->first();

        $nextDeadline = $this->calculateNextDeadline($parent, $lastInstance);

        // Create today's instance
        if ($nextDeadline && $nextDeadline->isToday()) {
            $newInstance = new Task();
            $newInstance->fill([
                'title' => $parent->title,
                'description' => $parent->description,
                'assigned_to' => $parent->assigned_to,
                'created_by' => $parent->created_by,
                'household_id' => $parent->household_id,
                'difficulty' => $parent->difficulty,
                'deadline' => $nextDeadline,
                'recurring_task_id' => $parent->id,
                'is_recurring' => false,
                'status' => 'pending'
            ]);
            $newInstance->save();

            ActivityLogger::log($parent->created_by, $parent->household_id, 'task.recurring_instance_created', [
                'parent_task_id' => $parent->id,
                'new_task_id' => $newInstance->id,
                'deadline' => $nextDeadline->format('Y-m-d H:i:s')
            ]);
        }
    }
}

private function calculateNextDeadline(Task $parent, ?Task $lastInstance): ?Carbon
{
    $baseDate = $lastInstance
        ? Carbon::parse($lastInstance->deadline)
        : Carbon::parse($parent->deadline);

    return match($parent->recurrence_pattern) {
        'daily' => $baseDate->addDay(),
        'every_x_days' => $baseDate->addDays($parent->recurrence_interval),
        'weekly' => $baseDate->addWeek()->setDayOfWeek($parent->recurrence_day_of_week),
        'monthly' => $baseDate->addMonth()->setDay(min($parent->recurrence_day_of_month, $baseDate->daysInMonth)),
        default => null
    };
}
```

---

### 3. Správa recurring tasks (domina)

**API:**

```php
// Vypnout (přestat generovat instance)
PUT /api/tasks/{id}/recurring/deactivate
Response: {
  "recurrence_active": false,
  "message": "Recurring task deactivated."
}

// Zapnout zpět
PUT /api/tasks/{id}/recurring/activate
Response: {
  "recurrence_active": true,
  "message": "Recurring task activated."
}

// Upravit periodicitu
PUT /api/tasks/{id}/recurring
{
  "recurrence_pattern": "every_x_days",
  "recurrence_interval": 5
}

Response: {
  "message": "Recurrence pattern updated."
}

// Smazat (včetně pending instancí)
DELETE /api/tasks/{id}
// Pokud je parent task:
// - Smaže parent
// - Smaže všechny pending child instances
// - Completed instances zůstávají (historie)

Response: {
  "deleted": true,
  "child_tasks_deleted": 5,
  "message": "Recurring task and pending instances deleted."
}
```

---

## UI Mock

### Vytváření úkolu s periodicitou

```
┌──────────────────────────────────────────────┐
│ Přiřadit úkol servantovi                     │
│                                              │
│ Název: Ranní káva do postele                 │
│ Popis: _________________________________     │
│ Obtížnost: [Easy ▼]                          │
│                                              │
│ Deadline: [03.11.2025] [08:00]               │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ Periodicita                              │ │
│ │                                          │ │
│ │ ◉ Neopakovat (jednorázový úkol)         │ │
│ │ ○ Denně v [08:00]                        │ │
│ │ ○ Každých [_3_] dní v [08:00]            │ │
│ │ ○ Týdně [Pátek ▼] v [18:00]             │ │
│ │ ○ Měsíčně [1. den ▼] v [08:00]          │ │
│ │                                          │ │
│ │ Ukončit opakování:                       │ │
│ │ ○ Nikdy                                  │ │
│ │ ○ K datu: [____-__-__]                   │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ℹ️ Nové instance budou vytvářeny            │
│   automaticky každý den v 00:01              │
│                                              │
│ [Přiřadit úkol]                              │
└──────────────────────────────────────────────┘
```

### Správa recurring tasks

```
┌──────────────────────────────────────────────┐
│ Opakující se úkoly                           │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ 🔁 Ranní káva                            │ │
│ │ Denně v 08:00                            │ │
│ │ Status: ✅ Aktivní                       │ │
│ │ Další instance: 04.11.2025 08:00         │ │
│ │ [Upravit] [Vypnout] [Smazat]             │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ 🔁 Úklid koupelny                        │ │
│ │ Týdně (pátek) v 18:00                    │ │
│ │ Status: ✅ Aktivní                       │ │
│ │ Další instance: 08.11.2025 18:00         │ │
│ │ [Upravit] [Vypnout] [Smazat]             │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ 🔁 Fitness report                        │ │
│ │ Každé 3 dny v 18:00                      │ │
│ │ Status: ⏸️ Vypnuto                       │ │
│ │ [Upravit] [Zapnout] [Smazat]             │ │
│ └──────────────────────────────────────────┘ │
└──────────────────────────────────────────────┘
```

### Servant Dashboard

```
┌──────────────────────────────────────────────┐
│ Úkoly — Dnes (03.11.2025)                    │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ 🔁 Ranní káva do postele                 │ │
│ │ 08:00 • Easy • Opakuje se denně          │ │
│ │ [Označit splněno]                        │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ 🔁 Fitness report                        │ │
│ │ 18:00 • Medium • Opakuje se každé 3 dny  │ │
│ │ [Označit splněno]                        │ │
│ └──────────────────────────────────────────┘ │
│                                              │
│ ┌──────────────────────────────────────────┐ │
│ │ ◆ Úklid skříně                           │ │
│ │ 14:00 • Medium • Jednorázový             │ │
│ │ [Označit splněno]                        │ │
│ └──────────────────────────────────────────┘ │
└──────────────────────────────────────────────┘
```

---

## Business Logika

### Penalizace

Každá instance = samostatný úkol.

Pokud servant nesplní instanci:
- Deadline miss: **-15b**
- Další instance se stále vytváří (parent aktivní)

Pokud domina nesplní denní checklist, nesouvisí s recurring tasks.

### Vypnutí vs Smazání

**Vypnutí (`recurrence_active=false`):**
- Parent zůstává v databázi
- Pending instances zůstávají
- **Nové instance se nevytváří**

**Smazání (`DELETE parent`):**
- Parent smazán
- **Všechny pending instances smazány** (CASCADE)
- Completed instances zůstávají (historie, audit)

### Historie

Completed child instances = historie opakujících se úkolů.

```php
GET /api/tasks/history?recurring_task_id=789

Response: [
  { "id": 790, "deadline": "2025-11-01 08:00", "status": "verified", "verified_at": "2025-11-01 08:15" },
  { "id": 791, "deadline": "2025-11-02 08:00", "status": "verified", "verified_at": "2025-11-02 08:10" },
  { "id": 792, "deadline": "2025-11-03 08:00", "status": "pending", "verified_at": null }
]
```

---

## Validace

**Backend validace při vytváření:**
- `recurrence_interval`: 2-30 dní
- `recurrence_day_of_week`: 1-7
- `recurrence_day_of_month`: 1-31
- `recurrence_end_date`: >= deadline, <= 1 rok do budoucna
- Pouze domina může vytvořit recurring task

**Frontend validace:**
- Periodicita disabled pokud deadline < dnes
- Warning pokud end_date < 7 dní od začátku

---

## Implementační poznámky

**Cron timing:**
- Běží v 00:01 (po půlnoci)
- Vytváří instance s deadlinem na DNEŠEK
- Servant vidí úkol hned ráno

**Performance:**
- Index na `is_recurring`, `recurrence_active`
- Cron iteruje pouze aktivní recurring tasks (ne všechny tasks)
- Cascade delete při smazání parent → efektivní cleanup

**Edge cases:**
- Měsíční opakování 31. den → pokud měsíc má 30 dní, nastaví se na poslední den
- Týdenní opakování přes přestupný den → Carbon řeší automaticky
- Parent task completion → zakázat (parent je šablona, ne executable task)

---

**Design uzavřen.**
