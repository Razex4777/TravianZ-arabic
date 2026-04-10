# Changelog

## 2026-04-10 18:30
- **CRITICAL FIX**: Replaced broken `rtlcss` bulk conversion with smart selective RTL flipping script (`fix_rtl.js`)
  - Root cause: `rtlcss` corrupted ALL sprite `background-position` values (e.g., `-17px 0` → `right -17px top 0`) and flipped the global `background-position: left top` default, breaking all icon sprites and layout images
  - Fix: Copy EN CSS as base, then selectively flip ONLY layout properties: `float`, `text-align`, `margin-left/right`, `padding-left/right`, `left/right` positioning
  - Preserved: All sprite `background-position` pixel values, background-image URLs, shorthand properties
  - Restored `lang.css` from EN (contains only image asset definitions, no layout to flip)
  - Reverted global `background-position` from `right top` back to `left top` (sprites anchor left regardless of text direction)

## 2026-04-10 18:25
- Split monolithic `GameEngine/Lang/ar.php` (1700+ lines) into 5 smaller module parts inside `GameEngine/Lang/ar/part*.php` to strictly adhere to the 500-line global rule limit.
- Updated `GameEngine/Lang/ar.php` to act cleanly as an inclusion wrapper.
## 2026-04-10 17:25
- Resolved massive PHP Constant already defined warnings by refactoring GameEngine/Technology.php to dynamically include the active LANG file instead of hardcoding en.php.
- Created lip_css.js and bulk-converted 36 modular CSS files in gpack/travian_default/lang/ar/compact/ using tlcss (converting floats, margins, paddings for RTL architecture).
- Appended direction: rtl; text-align: right; directly to ody in gpack/travian_default/lang/ar/compact/global.css.
- Started standard docker-compose stack (DB, phpMyAdmin, Web) for local review.


## 2026-04-10 16:49
- Duplicated `en` localization and style assets into `ar` to build out Arabic RTL support base.
- Changed default game language in `GameEngine/config.php` to `ar`.

## 2026-04-10 16:35
- Created `gpack/travian_default/lang/en/compact/` to modularize `compact.css`.
- Split the monolithic `compact.css` (9200+ lines) into 36 modular, component-specific CSS files (each <=400 lines) to adhere strictly to the 500-line limit and improve maintainability.
- Replaced `compact.css` content with `@import url(...)` declarations mapping to the newly split components.

## 2026-04-10 13:05
- Updated `docs/project_structure.md` with COMPLETE file tree (500+ files mapped)
- Every file and folder now has a detailed description and purpose
- Added metadata footer with CSS targets for RTL, tech stack details
- Identified key files for Phase 1: main.css, portal_ltr.css, new_layout_ltr.css, en.php

## 2026-04-10 10:30
- Created `docs/plans/phase-1.md` (RTL, Arabic Translation, Mobile Responsiveness)
- Created `docs/plans/phase-2.md` (Gold/Prize Distribution - Weekly to Daily)
- Created `docs/plans/phase-3.md` (Hall of Fame Feature)
- Created `docs/project_structure.md` (initial architecture overview)
- Initialized `docs/changelog.md`

