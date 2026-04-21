# Task Plan

## 2026-04-21 Client Requests
- [x] Set base village storage capacity to 1500 for villages without warehouse/granary.
- [x] Ensure oasis bonus values are consistent with requested production scheme (150/100/75) across runtime/search/display.
- [x] Build a direct-chat experience with live polling, unread highlighting, and no-refresh message updates.
- [x] Add API endpoint for direct-chat threads/messages/send/mark-read/summary.
- [x] Verify touched files and record follow-up checks.

## Review
- Implemented new `VILLAGE_STORAGE_BASE` constant and switched village-only storage floors to this value.
- Kept oasis production math intact (already compliant), and fixed outdated 25/50 display labels in map/admin views.
- Added WhatsApp-like direct chat tab with live thread list refresh, live message polling, unread colored threads, read-marking, and header unread icon refresh.
- Verification note: local `php -l` could not run because `php` binary is not available on host PATH; runtime validation should be done in Docker/PHP container.
