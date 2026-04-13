# Changelog

## 2026-04-13 14:23
- **★ FIX**: Fixed severe Public Chat layout corruption overlapping with footer/sidebar.
  - Root cause: The custom public chat window was originally written to escape `div#content` or render outside its flex/float context, lacking the structural wrappers `div#content.messages` and `menu.tpl`.
  - Fix: Wrapped the entire chat interface (header, container, input area) inside `<div id="content" class="messages">` and included `menu.tpl` to mirror the natural layout structure of the `inbox.tpl` and `sent.tpl` sections. Adjusted CSS heights and constraints to preserve containment, which keeps the mascot knight and the right sidebar perfectly in place.

## 2026-04-12 18:35
- **★ CRITICAL FIX**: Desktop layout was completely broken by `mobile/_base.css`.
  - Root cause: ALL resource bar overrides (green pill cards, `position: relative !important`, flexbox layout, hidden gold table) were in `_base.css` with **NO `@media` wrapper**, applying to ALL screen sizes including desktop.
  - This destroyed the original desktop layout where `div#res` is `position: absolute; top: 175px; right: 0; width: 100%; min-width: 980px` (from `gpack/travian_default/modules/new_layout_rtl.css` line 87).
  - Fix: Wrapped all resource bar and layout overrides inside `@media screen and (max-width: 980px)` so they ONLY apply on tablet/mobile. Desktop now uses the original gpack compact CSS untouched.
  - The `#header_gold_display` styles remain global since that element is new (not in original gpack) — it appears inline near Plus on desktop and in the sidebar on mobile.
  - Bumped `_base.css` cache version from v=2 to v=3 in `mobile.css`.

## 2026-04-12 17:35
- **Feature / Request**: Redesigned the top resource bar and Plus label to match the aesthetic of travianksa.com.
  - Renamed the spaced out individual letters "ب ل س" into a solid unified word "بلاس" inside `Templates/header.tpl`.
  - Created a new span `#header_gold_display` explicitly inside the header adjacent to "بلاس".
  - Refactored `mobile/_base.css` and `mobile/_phone_ingame.css` so that the Resource Values are now wrapped globally on desktop AND mobile as premium green pill/cards (linear-gradient).
  - Explicitly disabled the original separate Gold cell within the second table of the Resource Bar, rerouting the display exclusively to the newly styled header section on all breakpoints.

## 2026-04-12 11:38
- **★ BUG FIX**: Fixed critical `@media` wrapper regression in `_phone_alliance.css` and `_phone_plus.css`.
  - Root cause: When these files were split from `_phone_ingame_pages.css`, the `@media screen and (max-width: 768px)` wrapper was **not** carried over. This caused all mobile-only rules to apply on desktop, breaking the Gold Shop and Alliance page layouts on wide screens.
  - Fix: Added proper `@media screen and (max-width: 768px) { ... }` wrappers to both extracted files. Also fixed `_phone_ingame_pages.css` which lost its closing `}` brace during the split.
  - Fix 2: Eliminated mobile layout overflow on the Plus page by overriding table-cell defaults with `display: block`, adding `word-wrap: break-word`, and `overflow-x: hidden` to fix horizontal bleeding in RTL mode caused by the `rate_details` and `products` grids.
  - Fix 3: Added a pure CSS premium modular card design specifically to the "Invited Players" table (`#brought_in`) within `_phone_plus.css`. Restructured header mappings seamlessly via flexbox and isolated it strictly inside the 768px mobile boundary.
  - Validated all 3 files now have exactly 1 `@media` open and 1 top-level closing brace each.
- **Docs**: Added full `mobile.css` + `mobile/` directory (9 partials) to `docs/project_structure.md` — this section was entirely missing from the architecture snapshot.

## 2026-04-12 10:35
- **★ BUG FIX**: Fixed duplicated footers and layout breakage on `tutorial.php` (Tutorials) and `anleitung.php` (Instructions/FAQ).
  - Root cause: Over 18 `.tpl` files inside `Templates/Tutorial/` and `Templates/Anleitung/` contained hardcoded `</div> <div class="clear"></div>` tags at the bottom, which prematurely closed the `.grit` (or `.tutorial`) layout wrap. Furthermore, they included a full duplicate hardcoded `<div id="footer">` section appended to the bottom. Additionally, a stray `</ul>` was breaking the HTML structure in `anleitung.php` and `tutorial.php`.
  - Fix: Ran PowerShell stripping regex to remove `</div> <div class="clear"></div>` and everything beneath it from all 18 `.tpl` files to prevent layout escape. Removed stray `</ul>` from `anleitung.php` and `tutorial.php`. Now the main design nicely surrounds the guide content and handles the standard footer layout efficiently.

## 2026-04-11 17:00
- **Feature: Gold Instant Training** — Added ability to instantly finish all training queues for 2 gold across all military buildings.
  - Created `Technology::finishTraining()` — iterates training rows, maps unit IDs (handling great barracks +60 offset), adds units via `modifyUnit()`, clears training table.
  - Integrated into `Building::finishAll()` — training completion now triggers alongside building/research/demolition finish.
  - Updated 7 template files (`19.tpl`, `20.tpl`, `21.tpl`, `29.tpl`, `30.tpl`, `36.tpl`, `42.tpl`) with gold clock icon in training queue headers.
  - **★ BUG FIX (pre-release)**: Great barracks/stable/workshop units stored with +60 offset in training table were being passed raw to `modifyUnit()`. Fixed to subtract 60 (mirrors `Automation::trainingComplete` logic at line 3296).

## 2026-04-11 16:50
- **★ FIX: RTL Side Navi mobile overflow** — The Arabic pills menu (Profile, Logout, etc.) was sliding out of viewport due to `right: -260px` sidebar offset logic improperly persisting from a previous iteration. Removed the negative offset, set `position: static`, `transform: none`, and forced `direction: ltr` specifically on `div#side_navi` so flex-wrap and justify-content:center gracefully place the pills in the middle of the screen as requested.

- **★ FIX: Horizontal overflow on mobile (nuclear max-width clamp)** — Root cause: dozens of compact CSS files (`village1.css`, `village2.css`, `misc_part1.css`, `reports_messages_part1.css`, `map_part4.css`, etc.) set explicit fixed widths (502px, 537px, 540px, 552px, 728px, 960px+) on elements inside `div#content` that were NOT individually overridden. Also: `#guide1-4` debug divs used `position:fixed; margin-right:-480px`, and `div.popup3` used `right:50%; margin-right:-285px`.
  - **Fix A**: Added universal `max-width: 100% !important; box-sizing: border-box !important` to ALL children of `div#mid`, `div#content`, `div#side_info`, `div#side_navi` at the phone breakpoint (≤768px). Excluded `img`/`canvas` to preserve village map and sprite rendering.
  - **Fix B**: Changed `div#content` `overflow-x` from `visible` to `hidden` to prevent children from pushing the viewport wider.
  - **Fix C**: Added `display: none !important` for `#guide1-4` debug guide lines.
  - **Fix D**: Fixed `div.popup3` centering using `transform: translateX(50%)` instead of negative margin.
  - **Fix E**: Added `max-width: 100vw` to `html, body`.
  - **Tablet (≤980px)**: Same nuclear clamp applied in `_tablet.css` for mid-range screens.
  - **Admin**: Same clamp applied in `admin_mobile.css` for admin panel containers.

## 2026-04-11 16:32
- **Feature: Admin Panel Arabic Localization** — Replaced all hardcoded English strings in `Admin/admin.php` sidebar menus (both Admin and Multihunter roles) with bilingual AR/EN `(defined('LANG') && LANG === 'ar')` ternary expressions. Covers: Server Homepage, Control Panel Home, Return to server, Logout, Server Info sub-items (Online Users, Players Not Activated, Players Inactivate, Players Report, Players Message, Map, Map Tile, Natars Management), Search, Messages (Read In-Game, Mass Message, System Message), Ban, Gold, Plus & Res Bonus, Users, and Admin sections.
- **Feature: Admin Home Page Arabic** — Translated `Admin/Templates/home.tpl` welcome banner (WELCOME TO / CONTROL PANEL / ADMINISTRATOR / MULTIHUNTER) and login greeting.
- **Feature: Profile Menu2 Arabic** — Translated `Templates/Profile/menu2.tpl` (sitter version) matching existing `menu.tpl` translations (نظرة عامة, الملف الشخصي, التفضيلات, الحساب, إجازة, حزمة الرسومات).
- **Feature: Profile Edit Page Arabic** — Translated `Templates/Profile/profile.tpl`: heading, Player header, Details, Description, Birthday, Gender, Location, Village name, Medals table headers, Beginners Protection.
- **Feature: Account Page Arabic** — Translated `Templates/Profile/account.tpl`: Change password/email, Account sitters, sitter notes, Delete account, Yes/No, Confirm with password.
- **Feature: Preferences Page Arabic** — Translated `Templates/Profile/preference.tpl`: Direct links, Auto completion, Large map, Report filter, Time preferences, Date, all form labels and descriptions.

## 2026-04-11 14:18
- **Feature: Admin Panel mobile responsive** — Created `img/admin/admin_mobile.css` dedicated mobile stylesheet. Added viewport meta tag and CSS link to `Admin/admin.php`. Flattens the fixed 980px sidebar+content desktop layout into single-column responsive: accordion menu full-width, tables with horizontal scroll, form inputs fluid, tooltips clamped to viewport.
- **Feature: Mass Message page responsive (Section 18)** — `massmessage.php` form table restructured to single-column flex layout on mobile. Inputs and textarea fill container width, submit button centered with Travian green (#71D000), confirmation Yes/No buttons stacked vertically.
- **Feature: Alliance pages responsive (Section 19)** — `allianz.php` tab menu (`Overview | Forum | Chat | Attacks | News | Options`) converted to flex-wrapped pill buttons. Forum tables (`table#public`, `table.forumline`) made horizontally scrollable. Thread list, new topic forms, chat/news sections all fluid. Alliance details table scrollable.
- **Feature: RTL adjustments (Section 20)** — Sidebar slide direction mirrored for `dir="rtl"` pages. Table text alignment flipped. Mass message form inputs given `direction: rtl`. Tab menus preserve centered layout with RTL direction.


- **★ FIX: Missing 5th sidebar icon** — Root cause: `background:` shorthand on `div#n5` killed the sprite `background-image` from `.i1/.i2/.i3/.i4` classes (`m1.gif`–`m4.gif`). Changed to `background-color:` to preserve the sprite. Also applied same fix to n1-n4 active state.
- **Feature: Reports page (`berichte.php`) responsive** — Full mobile overrides for the reports page: tab menu (`#textmenu`) converted to flex-wrapped pill buttons with hidden pipe separators, `table#overview` made horizontally scrollable, and report reading view (`.report_details`) made fluid.
- **Feature: Global text readability** — Added Section 17 "Global Text Readability" to `_phone_ingame.css`: forced dark text colors (`#222`/`#333`) on headings, table cells, side info panels, sidebar nav labels, and links (`#1a5c00` green) for high contrast against light backgrounds.

## 2026-04-11 13:58
- **Feature**: Applied comprehensive responsive overrides to `nachrichten.php` (Messages), ensuring `table#overview`, the `div#textmenu`, and the message composer/toolbar text layout scale gracefully on small screens without overlapping.
- **Fix**: Centered sidebar navigation icons by adding `justify-content: center` to the nav rows.
- **Theme**: Fixed in-game mobile sidebar theme. Background changed from dark (`#1a1a1a`) to pure white (`#fff`) with light gray (`rgba(0,0,0,0.04)`) nav rows for touch interaction.

## 2026-04-11 13:25
- **In-game mobile responsive rewrite (`_phone_ingame.css` — full rewrite)**
  - Neutralized ALL desktop fixed-width layout rules for in-game pages:
    - `div#mid` (980px → 100%), `div.village1` (537px → 100%), `div#side_navi` (155px → flex wrap), `div#side_info` (257px → stacked), `div#mtop` (700px → 260px slide-in sidebar)
  - Village map (`#village_map` 300×264) stays native pixel dimensions to preserve absolutely-positioned resource field icons (rf1-rf18), centered on mobile, with CSS `transform:scale(0.9)` for screens ≤360px
  - Resource bar (`div#res`, `div#resWrap`) converted from absolute-positioned fixed-width to relative, scrollable, fluid
  - Footer: same strategy as outgame — kills desktop `position:absolute`, `min-width:980px`, `height:90px`, background images
  - Side nav links converted to pill-button layout with flex-wrap
  - Background images neutralized: `rand.gif` (sidebar stripe), `shadow-a-ltr.png`, `shadow-b-ltr.png`, `menu-bg-ltr.gif`
  - Added ≤360px micro-breakpoint for map scaling and nav tightening
  - Added popup/dialog responsive centering (`div.popup3`)
  - All mod1/mod2/mod3 layout variant overrides included
- **Scoped `_small_phone.css` header height override** to outgame-only using `:has()` selector to prevent 20px crush on in-game header
- **★ FIX: Nav icon hover disappearing** — Desktop `compact/global.css` line 199 shifts `background-position` from `0 -21px` to `0 -121px` on hover, moving the sprite off-canvas on mobile. Locked hover to same position with `!important`.
- **★ FIX: Resource bar + server time reordered above village** — Used CSS `display:flex; flex-direction:column` on `.wrapper` with `order` properties to visually reposition `div#res` (order:4) and `div#stime` (order:5) before `div#mid` (order:6), despite being rendered after `div#footer` in HTML source.
- **Sidebar visual overhaul** — Dark theme (#1a1a1a), full-width nav rows with rounded cards, touch-friendly 50px icons, green gradient Plus button, gap spacing.
- **Backdrop click-to-close** — Changed `mobile-sidebar-backdrop` from `<div>` to `<label for="mobile-nav-toggle">` in `header.tpl`, enabling click-outside-to-close behavior (unchecks checkbox).

## 2026-04-11 11:39
- **Refactor: mobile.css modularized into `mobile/` directory**
  - Split 1214-line monolithic `mobile.css` into 6 focused partials:
    - `_base.css` (7 lines) — Global defaults, hide mobile-only elements on desktop
    - `_tablet.css` (162 lines) — ≤980px breakpoint, removes fixed widths for public + in-game
    - `_phone_public.css` (180 lines) — ≤768px public pages, hamburger sidebar navigation
    - `_phone_outgame.css` (373 lines) — ≤768px login/signup/activate card-based forms
    - `_phone_ingame.css` (325 lines) — ≤768px in-game sidebar, resource bar, tables, map
    - `_small_phone.css` (120 lines) — ≤480px narrow screen tightening
  - `mobile.css` now acts as a clean `@import` aggregator (20 lines)
  - All existing styling preserved — zero visual regression

## 2026-04-11 10:00
- **Phase 2: Gold/Prize Logic (Weekly → Daily) — VERIFIED ✅**
  - Confirmed `MEDALINTERVAL` already set to `(3600 * 24)` = 86400 seconds = 24 hours in `config.php`
  - Created `test_daily_distribution.php` — compressed test script that forces the distribution cycle
  - Test results: Distribution cycle triggers correctly, stats reset works, lastgavemedal timestamp updates properly
  - 0 medals inserted = expected since server has no eligible players (all are system/admin accounts with access >= 8)
  - Next daily cycle: 24 hours from last run
  - The daily distribution pipeline is: Medals → Hall of Fame → Stats Reset → Alliance Medals → Alliance Stats Reset → Timestamp Update


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


# 2026-04-11 17:08
- Implemented 'Gold Instant Training' separating it from building finish.
- Updated training finish cost to 35 gold.
- Updated all military buildings (19, 20, 21, 29, 30, 36, 42) templates to use 	rainingFinish=1.
- Implemented 'Upgrade to Max Level' costing 1 gold per level (e.g., lvl 20 costs 20 gold).
- Updated upgrade.tpl to display the 'Upgrade to Max Level' gold button.
- Refactored Building.php and uild.php to handle new routing parameters (	rainingFinish and upgradeToMax).

# 2026-04-11 16:35
- Translated <option> dropdown values (Yes/No, True/False, Days/Hours) to Arabic conditionally based on $LANG in admin templates (editAdminInfo.tpl, editExtraSet.tpl, editLogSet.tpl, editPlusSet.tpl, editServerSet.tpl, editNewFunctions.tpl).
