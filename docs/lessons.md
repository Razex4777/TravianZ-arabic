# Lessons Learned

## 2026-04-21
- For oasis production requests, verify runtime formulas and search constants before changing core math; often only UI labels are stale.
- For village storage requests, avoid changing global storage base that also affects oasis logic; introduce/target a village-specific floor instead.
- For live chat upgrades in legacy PHP apps, incremental enhancement (polling API + new tab) is safer than replacing the entire mail subsystem.
