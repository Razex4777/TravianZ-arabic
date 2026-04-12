# Gold Instant Training - Implementation Plan

## Objective
Add a "Finish Training" gold button to all military training queues (Barracks, Stable, Workshop, Great Barracks, Great Stable, Great Workshop, Trapper).

## Architecture

### How it works (mirroring existing `finishAll` pattern):
1. Player clicks a gold clock icon next to the training queue header
2. URL parameter `?trainingFinish=1` is sent
3. `Building.php` detects the parameter and calls `finishTraining()`
4. All training rows for this village are completed instantly:
   - Units from training queue are added to the village's unit count
   - Training rows are deleted from the DB
5. 2 gold is deducted from the player

### Key Insight:
The existing `finishAll()` method handles buildings + research but **not** training.  
We need a **new method** `finishTraining()` in `Technology.php` (since training logic lives there), called from the `finishAll()` flow.

## Changes Required

### 1. `GameEngine/Technology.php` - Add `finishTraining()` method
- [x] Create `finishTraining($vid)` that:
  - Gets all training rows for the village via `$database->getTraining($vid)`
  - For each row: adds the units to the village's unit table via `modifyUnit()`
  - Deletes all training rows for the village
  - Returns count of finished jobs (for gold deduction logic)

### 2. `GameEngine/Building.php` - Extend `finishAll()` 
- [x] Call `$technology->finishTraining($village->wid)` inside `finishAll()`
- [x] Include training completion in the `$countPlus2Gold` flag

### 3. Training Templates (19.tpl, 20.tpl, 21.tpl, 29.tpl, 30.tpl, 42.tpl, 36.tpl)
- [x] Add gold finish clock icon next to the "Training" table header
- [x] Similar to the one in `Building.tpl` line 21

## Review
- [ ] Browser test to verify

