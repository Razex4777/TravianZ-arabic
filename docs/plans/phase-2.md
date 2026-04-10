# Phase 2: Gold and Prize Distribution Logic

## 1. Modify Prize Logic (Weekly to Daily)
- [ ] Trace current weekly medal/prize distribution logic (likely found in `GameEngine/Database.php`, `GameEngine/Automation.php`, or cron jobs)
- [ ] Refactor the timeframe logic from 7 days (weekly) to 1 day (daily)
- [ ] Update the UI where the countdown or schedule is displayed to players
- [ ] Ensure no duplicate payouts occur during the daily transition

## 2. Modify Gold Logic
- [ ] Investigate existing Gold distribution mechanics (e.g., registration bonus, invitation bonus)
- [ ] Implement new adjustments to the logic as per client specifies (e.g., automated daily gold, modified rates)

## Review
- [ ] Test the chron / automation manually by simulating a day passing locally
- [ ] Verify correct records inserted into the DB for users receiving gold/prizes
- [ ] Send update to Hassan K. on Phase 2 completion
