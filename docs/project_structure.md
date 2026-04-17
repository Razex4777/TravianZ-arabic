# TravianZ Project Architecture

```text
TravianZ-master/
│
├── 📄 .dockerignore                  # Docker build exclusion rules
├── 📄 .env.example                   # Environment variable template for DB/server config
├── 📄 .gitattributes                 # Git line-ending and diff settings
├── 📄 .gitignore                     # Git-tracked file exclusions
├── 📄 .htaccess                      # Apache URL rewrite rules for the root application
├── 📄 AC_OETags.js                   # ActiveX/Object Embed tags helper (legacy Flash detection)
├── 📄 CHANGELOG.md                   # Original project changelog from upstream TravianZ
├── 📄 CODE_OF_CONDUCT.md             # Community code of conduct
├── 📄 CONTRIBUTING.md                # Contribution guidelines for the open-source project
├── 📄 DOCKER_README.md               # Docker deployment documentation
├── 📄 Dockerfile                     # Docker container build instructions (PHP+MySQL)
├── 📄 LICENSE                        # GNU GPL v2 license
├── 📄 README.md                      # Project introduction and setup instructions
├── 📄 docker-compose.yml             # Docker Compose orchestration (app + db services)
├── 📄 favicon.ico                    # Browser tab icon
├── 📄 flaggen.js                     # Country flag display logic
├── 📄 mt-core.js                     # MooTools core library (legacy JS framework)
├── 📄 mt-full.js                     # MooTools full bundle with all modules
├── 📄 mt-more.js                     # MooTools additional plugins and utilities
├── 📄 new.js                         # Custom game UI interactions and AJAX handlers
├── 📄 new2.js                        # Extended game UI script (village/building actions)
├── 📄 uncrypt.js                     # Client-side decryption utilities
├── 📄 unx.js                         # Complex game logic handler (100+ functions)
├── 📄 sql_updates.txt                # Sequential SQL migration/update statements
├── 📄 todo.txt                       # Developer task notes
│
├── 📄 index.php                      # Main entry point: landing page, registration, and server info
├── 📄 login.php                      # Player login authentication handler
├── 📄 logout.php                     # Session destruction and redirect
├── 📄 anmelden.php                   # Registration form processing (German: "sign up")
├── 📄 activate.php                   # Account email activation handler
├── 📄 password.php                   # Password reset and recovery
├── 📄 autoloader.php                 # Class autoloading configuration
├── 📄 ajax.php                       # Central AJAX request dispatcher
├── 📄 dorf1.php                      # Village resource fields view (Village Overview 1)
├── 📄 dorf2.php                      # Village buildings view (Village Overview 2)
├── 📄 dorf3.php                      # Village overview alternative layout
├── 📄 build.php                      # Building construction/upgrade logic
├── 📄 build_croppers.php             # Cropper village building logic (9/15-crop specials)
├── 📄 karte.php                      # World map display (German: "map")
├── 📄 karte2.php                     # Extended map view with search
├── 📄 spieler.php                    # Player profile page (German: "player")
├── 📄 allianz.php                    # Alliance management and overview
├── 📄 statistiken.php                # Statistics and rankings page (TARGET: Hall of Fame)
├── 📄 nachrichten.php                # In-game messaging system (German: "messages")
├── 📄 berichte.php                   # Battle/trade reports viewer (German: "reports")
├── 📄 plus.php                       # Travian Plus premium features overview
├── 📄 plus1.php                      # Plus feature activation handler
├── 📄 packages.php                   # Gold package purchase page
├── 📄 celebration.php                # Village celebration/party launcher
├── 📄 finder.php                     # Generic map search for oases and croppers
├── 📄 massmessage.php                # Mass messaging system for alliances
├── 📄 support.php                    # Player support ticket system
├── 📄 warsim.php                     # Battle simulator for attack planning
├── 📄 winner.php                     # World Wonder winner detection and endgame logic
├── 📄 version.php                    # Server version check and update notifications
├── 📄 maintenance.php                # Server maintenance mode handler
├── 📄 banned.php                     # Banned player notification page
├── 📄 sysmsg.php                     # System message broadcast handler
├── 📄 tutorial.php                   # New player tutorial/quest system
├── 📄 manual.php                     # In-game manual/guide viewer
├── 📄 anleitung.php                  # Game instructions page (German: "instructions")
├── 📄 mailme.php                     # Email notification sender utility
├── 📄 impressum.php                  # Legal imprint page
├── 📄 rules.php                      # Server rules display page
├── 📄 spielregeln.php                # Extended game rules (German: "game rules")
├── 📄 agb.php                        # Terms of service page (German: "AGB")
├── 📄 terms.php                      # Simplified terms redirect
├── 📄 a2b.php                        # Troop transfer between villages (A to B)
├── 📄 a2b2.php                       # Extended troop transfer with advanced options
│
├── 📄 client_project_detail and conversations.txt  # Client requirements and chat history
│
├── 📁 GameEngine/                    # Core backend engine (PHP classes for all game logic)
│   ├── 📄 index.php                  # Directory access guard
│   ├── 📄 favicon.ico                # Duplicate favicon
│   ├── 📄 functions.php              # Global utility/helper functions
│   ├── 📄 Database.php               # MAIN: MYSQLi DB wrapper (340KB) - queries, gold, prizes, game state
│   ├── 📄 Session.php                # Player session management and authentication
│   ├── 📄 Account.php                # Account creation, deletion, and management
│   ├── 📄 Village.php                # Village data model and resource calculations
│   ├── 📄 Building.php               # Building definitions, requirements, and upgrade logic
│   ├── 📄 Technology.php             # Research/technology tree and upgrade handler
│   ├── 📄 Units.php                  # Troop types, stats, training, and movement
│   ├── 📄 Battle.php                 # Combat simulation engine (attack/defense calculations)
│   ├── 📄 Market.php                 # Marketplace trade logic (offers, merchants)
│   ├── 📄 Alliance.php               # Alliance CRUD, diplomacy, and member management
│   ├── 📄 Ranking.php                # Rankings engine (players, alliances, villages, heroes)
│   ├── 📄 Automation.php             # MASSIVE (240KB): Cron jobs, resource ticks, troop movements, prizes
│   ├── 📄 Artifacts.php              # Artifact effects, spawning, and ownership
│   ├── 📄 Message.php                # In-game messaging backend
│   ├── 📄 BBCode.php                 # BBCode-to-HTML parser for messages/forums
│   ├── 📄 Chat.php                   # Real-time alliance chat handler
│   ├── 📄 Profile.php                # Player profile data management
│   ├── 📄 Form.php                   # Form validation utility class
│   ├── 📄 Generator.php              # World generation (map tiles, oases, resources)
│   ├── 📄 Logging.php                # Action and error logging system
│   ├── 📄 Mailer.php                 # Email sending wrapper (activation, password reset)
│   ├── 📄 Multisort.php              # Multi-column array sorting utility
│   ├── 📄 Protection.php             # Beginner protection timer and checks
│   │
│   ├── 📁 Admin/                     # Admin panel backend logic
│   │   ├── 📄 .htaccess              # Access restriction for admin directory
│   │   ├── 📄 admin.php              # Admin panel core controller
│   │   ├── 📄 database.php           # Admin-specific DB queries (user search, bans, stats)
│   │   ├── 📄 function.php           # Admin utility functions (permissions, formatting)
│   │   ├── 📄 ajax.js                # Admin panel AJAX interactions
│   │   ├── 📄 welcome.tpl            # Admin dashboard welcome template
│   │   ├── 📄 index.php              # Directory guard
│   │   └── 📁 Mods/                  # Admin modification modules (46 PHP files)
│   │       ├── 📄 addUsers.php       # Batch user creation
│   │       ├── 📄 addTroops.php      # Troop injection for testing
│   │       ├── 📄 addABTroops.php    # A-to-B troop additions
│   │       ├── 📄 editUser.php       # User account editing
│   │       ├── 📄 editVillageOwner.php # Village ownership transfer
│   │       ├── 📄 editServerSet.php  # Server settings configuration
│   │       ├── 📄 editPlusSet.php    # Plus/premium settings
│   │       ├── 📄 editNewFunctions.php # Feature toggles
│   │       ├── 📄 editHero.php       # Hero stats manipulation
│   │       ├── 📄 gold.php           # Gold distribution admin tool
│   │       ├── 📄 gold_1.php         # Extended gold management
│   │       ├── 📄 medals.php         # Medal/award management
│   │       ├── 📄 mainteneceBan.php  # Ban management
│   │       ├── 📄 mainteneceUnban.php # Unban processing
│   │       ├── 📄 mainteneceResetGold.php    # Mass gold reset
│   │       ├── 📄 mainteneceResetPlus.php    # Mass plus reset
│   │       ├── 📄 mainteneceResetPlusBonus.php # Plus bonus reset
│   │       ├── 📄 ... (30+ more mod files)
│   │       └── 📄 index.php          # Directory guard
│   │
│   ├── 📁 Data/                      # Static game data definitions
│   │   ├── 📄 buidata.php            # Building stats, costs, and upgrade data (87KB)
│   │   ├── 📄 resdata.php            # Resource production tables per building level (63KB)
│   │   ├── 📄 unitdata.php           # Unit stats (attack, defense, speed, cost)
│   │   ├── 📄 hero_full.php          # Hero items, abilities, and adventure data (85KB)
│   │   ├── 📄 cp.php                 # Culture point calculation tables
│   │   ├── 📄 cel.php                # Celebration cost and duration data
│   │   └── 📄 index.php              # Directory guard
│   │
│   ├── 📁 Game/                      # Game-specific logic modules
│   │   ├── 📄 WorldWonderName.php    # World Wonder naming constants
│   │   └── 📄 index.php              # Directory guard
│   │
│   ├── 📁 Lang/                      # Translation/localization files (define-based constants)
│   │   ├── 📄 en.php                 # English language file (116KB, ~3000+ constants)
│   │   ├── 📄 ar.php                 # Main Arabic inclusion file
│   │   ├── 📁 ar/                    # Split Arabic language files
│   │   │   ├── 📄 part1.php          # Arabic constants part 1
│   │   │   ├── 📄 part2.php          # Arabic constants part 2
│   │   │   ├── 📄 part3.php          # Arabic constants part 3
│   │   │   ├── 📄 part4.php          # Arabic constants part 4
│   │   │   └── 📄 part5.php          # Arabic constants part 5
│   │   ├── 📄 fr.php                 # French translation
│   │   ├── 📄 it.php                 # Italian translation
│   │   ├── 📄 zh_tw.php              # Traditional Chinese translation
│   │   └── 📄 index.php              # Directory guard
│   │
│   ├── 📁 Prevention/                # Anti-cheat and rate-limiting mechanisms
│   │   ├── 📄 empty.txt              # Placeholder
│   │   ├── 📄 lock.lock              # Lock file for concurrent access prevention
│   │   └── 📄 index.php              # Directory guard
│   │
│   └── 📁 Notes/                     # Developer notes storage
│       ├── 📄 DO NOT REMOVE THIS FOLDER.txt  # Folder preservation marker
│       └── 📄 index.php              # Directory guard
│
├── 📁 Templates/                     # Frontend UI templates (.tpl files rendered by PHP)
│   ├── 📄 header.tpl                 # MAIN LAYOUT: HTML head, resource bar, navigation (RTL target)
│   ├── 📄 footer.tpl                 # Page footer with links and scripts
│   ├── 📄 menu.tpl                   # Left/right sidebar navigation menu
│   ├── 📄 links.tpl                  # External/internal link display
│   ├── 📄 res.tpl                    # Resource production summary display
│   ├── 📄 production.tpl             # Detailed resource production view
│   ├── 📄 field.tpl                  # Resource field rendering template
│   ├── 📄 Building.tpl               # Building detail/info popup
│   ├── 📄 dorf2.tpl                  # Village buildings overview layout
│   ├── 📄 movement.tpl               # Troop movement tracking display
│   ├── 📄 multivillage.tpl           # Multi-village management panel
│   ├── 📄 troops.tpl                 # Troop overview display
│   ├── 📄 quest.tpl                  # Quest/tutorial tracker overlay
│   ├── 📄 natars.tpl                 # Natar NPC village template
│   ├── 📄 text.tpl                   # Generic text content renderer
│   ├── 📄 text_format.tpl            # BBCode formatting toolbar
│   ├── 📄 news.tpl                   # News item display card
│   ├── 📄 indexnews.tpl              # Landing page news section
│   ├── 📄 support.tpl                # Support page wrapper
│   ├── 📄 rules.tpl                  # Server rules display
│   ├── 📄 version.tpl                # Version info snippet
│   ├── 📄 index.php                  # Directory guard
│   │
│   ├── 📁 Ajax/                      # AJAX response fragments (7 files)
│   │   └── 📄 quest_core.tpl + quest_core25.tpl + plusmap.tpl + mapscroll*.tpl
│   │
│   ├── 📁 Alliance/                  # Alliance management templates (21 files)
│   │   ├── 📄 overview.tpl           # Alliance homepage
│   │   ├── 📄 forum.tpl              # Alliance forum
│   │   ├── 📄 chat.tpl               # Alliance chat room
│   │   ├── 📄 chgdiplo.tpl           # Diplomacy management
│   │   └── 📁 Forum/                 # Alliance forum sub-templates
│   │
│   ├── 📁 Anleitung/                 # Game instructions templates (11 files)
│   │   └── 📄 attack.tpl, units_1-5.tpl, search.tpl, sendback.tpl, newdorf.tpl
│   │
│   ├── 📁 Build/                     # Building construction templates (99 files)
│   │   ├── 📄 1.tpl - 42.tpl        # Individual building type templates (1-42)
│   │   ├── 📄 16_incomming.tpl       # Rally point incoming attacks
│   │   ├── 📄 17_*.tpl               # Marketplace sub-views (offers, NPC, routes)
│   │   ├── 📄 22_1-5.tpl             # Academy research views per tribe
│   │   ├── 📄 25_*.tpl / 26_*.tpl    # Great Barracks/Stable training
│   │   ├── 📄 37_hero.tpl            # Hero mansion hero management (38KB)
│   │   ├── 📄 avaliable.tpl          # Available buildings list
│   │   ├── 📄 upgrade.tpl            # Building upgrade confirmation
│   │   └── 📄 ww.tpl / wwupgrade.tpl # World Wonder templates
│   │
│   ├── 📁 dorf3/                     # Alternative village view (9 files)
│   │   └── 📄 1-5.tpl, menu.tpl, noplus.tpl
│   │
│   ├── 📁 goldClub/                  # Gold Club premium templates (7 files)
│   │   └── 📄 farmlist.tpl, trooplist.tpl, farmlist_add/edit*.tpl
│   │
│   ├── 📁 Manual/                    # In-game manual pages (133 files!)
│   │   └── 📄 0.tpl - 442.tpl       # Individual manual entries per building/unit/feature
│   │
│   ├── 📁 Map/                       # Map display templates (5 files)
│   │   └── 📄 mapview.tpl, mapviewlarge.tpl, vilview.tpl
│   │
│   ├── 📁 Message/                   # Messaging system templates (9 files)
│   │   └── 📄 inbox.tpl, sent.tpl, write.tpl, read.tpl, archive.tpl, notes.tpl
│   │
│   ├── 📁 News/                      # News display templates (5 files + home/ subdir)
│   │   └── 📄 newsbox1-3.tpl
│   │
│   ├── 📁 Notice/                    # Notification templates (6 files)
│   │   └── 📄 0.tpl - 4.tpl (notification types)
│   │
│   ├── 📁 Plus/                      # Premium features display (24 files)
│   │   └── 📄 1-15.tpl, getplus.tpl, invite.tpl, pmenu.tpl, 110-113.tpl
│   │
│   ├── 📁 Profile/                   # Player profile templates (13 files)
│   │   └── 📄 overview.tpl, profile.tpl, account.tpl, preference.tpl, graphic.tpl, medal.php
│   │
│   ├── 📁 Ranking/                   # Statistics/ranking templates (18 files) - TARGET for Hall of Fame
│   │   ├── 📄 general.tpl            # Main ranking page layout
│   │   ├── 📄 overview.tpl           # Ranking overview with tabs
│   │   ├── 📄 player_1-3.tpl         # Player ranking views
│   │   ├── 📄 player_top10.tpl       # Top 10 players display
│   │   ├── 📄 ally_top10.tpl         # Top 10 alliances display
│   │   ├── 📄 alliance.tpl           # Alliance rankings
│   │   ├── 📄 heroes.tpl             # Hero rankings
│   │   ├── 📄 villages.tpl           # Village rankings
│   │   ├── 📄 ww.tpl                 # World Wonder progress ranking
│   │   └── 📄 ranksearch.tpl         # Ranking search functionality
│   │
│   ├── 📁 Simulator/                 # Battle simulator templates (26 files)
│   │   └── 📄 att_1-5.tpl, def_1-5.tpl, res_*.tpl, return.tpl
│   │
│   ├── 📁 Tutorial/                  # New player tutorial templates (10 files)
│   │   └── 📄 1.tpl - 22.tpl, all.tpl
│   │
│   ├── 📁 a2b/                       # Troop transfer templates (7 files)
│   │   └── 📄 1-5.tpl (per tribe)
│   │
│   └── 📁 activate/                  # Account activation templates (6 files)
│       └── 📄 activate.tpl, activated.tpl, cantfind.tpl, delete.tpl
│
├── 📁 Admin/                         # Admin panel frontend (separate from GameEngine/Admin)
│   ├── 📄 .htaccess                  # Admin access restriction
│   ├── 📄 admin.php                  # Admin panel entry point and router
│   ├── 📄 ajax.js                    # Admin AJAX handlers
│   ├── 📄 jquery.cookie.js           # jQuery cookie plugin for admin sessions
│   ├── 📄 welcome.tpl                # Admin welcome page
│   ├── 📁 Templates/                 # Admin panel templates (90 files!)
│   │   ├── 📄 home.tpl               # Admin dashboard
│   │   ├── 📄 login.tpl              # Admin login form
│   │   ├── 📄 config.tpl             # Server configuration panel (30KB)
│   │   ├── 📄 editServerSet.tpl      # Server settings editor (18KB)
│   │   ├── 📄 map.tpl                # Admin map viewer (20KB)
│   │   ├── 📄 troops.tpl             # Troop management (14KB)
│   │   ├── 📄 village.tpl            # Village administration (14KB)
│   │   ├── 📄 editUser.tpl           # User editing form
│   │   ├── 📄 editHero.tpl           # Hero editing form
│   │   ├── 📄 ban.tpl                # Ban management
│   │   ├── 📄 gold.tpl               # Gold distribution panel
│   │   ├── 📄 resetServer.tpl/.php   # Server reset functionality
│   │   ├── 📄 ... (70+ more admin templates)
│   │   ├── 📁 Message/               # Admin message templates
│   │   ├── 📁 Notice/                # Admin notice templates
│   │   └── 📁 report/                # Admin report templates
│   ├── 📁 Mods/                      # Admin frontend modifications (10 files)
│   │   └── 📄 addTroops.php, editUser.php, gold.php, medals.php, etc.
│   ├── 📁 gpack/                     # Admin theme pack
│   │   └── 📁 travian_default/       # Default admin theme
│   └── 📁 img/                       # Admin panel images
│       └── 📁 rpage/                 # Report page images
│
├── 📁 Security/                      # Security layer
│   ├── 📄 Security.class.php         # XSS/CSRF protection, input sanitization, rate limiting
│   └── 📄 index.php                  # Directory guard
│
├── 📁 css/                           # Root-level CSS (minimal)
│   └── 📄 admin_map_tile.css         # Admin map tile styling
│
├── 📁 img/                           # Game image assets and CSS
│   ├── 📄 img.css                    # Image sprite positions and CSS background mapping (22KB)
│   ├── 📄 portal_ltr.css             # Portal/landing page LTR layout (19KB) - KEY RTL TARGET
│   ├── 📄 travian_basics.css          # Base Travian styling
│   ├── 📄 galai.png                  # Gaul tribe icon
│   ├── 📄 germanai.png               # Teuton tribe icon
│   ├── 📄 romenai.png                # Roman tribe icon
│   ├── 📄 lol.PNG                    # Misc image asset
│   ├── 📄 x.gif                      # Transparent pixel spacer
│   ├── 📁 admin/                     # Admin-specific images and CSS
│   │   ├── 📄 admin.css              # Admin panel desktop layout CSS (696 lines)
│   │   ├── 📄 acp.css                # Admin control panel styles (256 lines)
│   │   └── 📄 admin_mobile.css       # Admin panel mobile responsive overrides (≤768px)
│   ├── 📁 bezahlung/                 # Payment/billing images
│   ├── 📁 en/                        # English-specific images
│   ├── 📁 rpage/                     # Report page images
│   ├── 📁 t4n/                       # Travian 4 Natar images
│   ├── 📁 tutorial/                  # Tutorial step images
│   └── 📁 un/                        # Unit/troop images
│
├── 📁 gpack/                         # Game graphic packs (themes/skins)
│   ├── 📄 index.php                  # Directory guard
│   ├── 📁 download/                  # Downloadable resource packs
│   ├── 📁 travian/                   # Classic Travian theme
│   │   ├── 📄 main.css               # Main game layout CSS (13KB) - PRIMARY RTL TARGET
│   │   ├── 📄 main_en.css            # English-specific overrides (14KB)
│   │   ├── 📄 flaggs.css             # Country flag sprite positions (10KB)
│   │   ├── 📁 elements/              # UI element sprites
│   │   │   └── 📄 country_sprite.gif # All country flags in one sprite
│   │   └── 📁 images/                # Theme image assets
│   │
│   ├── 📁 travian_default/           # Default theme (extends travian)
│   │   ├── 📄 travian.css            # Theme override (minimal)
│   │   ├── 📁 modules/               # Theme CSS modules
│   │   │   ├── 📄 new_layout_ltr.css # LTR layout definitions (5KB) - RTL TARGET
│   │   │   ├── 📄 new_images.css     # Image path overrides
│   │   │   ├── 📄 new_colors.css     # Color scheme definitions
│   │   │   └── 📄 index.php          # Directory guard
│   │   ├── 📁 lang/                  # Language-specific theme overrides
│   │   │   ├── 📁 en/                # English language CSS
│   │   │   │   ├── 📄 compact.css    # Import wrapper for modularized CSS components
│   │   │   │   └── 📁 compact/       # Split CSS components categorized by feature (<=400 lines)
│   │   │   └── 📁 ar/                # Arabic language CSS
│   │   │       ├── 📄 compact.css    # RTL mirror of English compact wrapper
│   │   │       ├── 📁 compact/       # Split CSS components ready for RTL styling
│   │   │       └── 📄 flip_css.js    # Node script to batch-process CSS to RTL using rtlcss
│   │   ├── 📁 images/                # Default theme images
│   │   └── 📁 img/                   # Additional image assets
│   │
│   └── 📁 travian_t4/                # Travian T4 theme (modern look)
│       ├── 📄 bodybg_fix.jpg         # Fixed background image (187KB)
│       ├── 📄 naviSmall.png          # Small navigation icon
│       ├── 📄 travian.css            # T4 theme override
│       ├── 📁 modules/               # T4 CSS modules (same structure as default)
│       │   ├── 📄 new_layout_ltr.css # T4 LTR layout
│       │   ├── 📄 new_images.css     # T4 image paths
│       │   └── 📄 new_colors.css     # T4 color scheme
│       ├── 📁 lang/                  # T4 language overrides
│       │   └── 📁 en/                # English
│       ├── 📁 images/                # T4 theme images
│       └── 📁 img/                   # T4 additional images
│
├── 📁 src/                           # Modern PHP source (partial refactor attempt)
│   ├── 📄 index.php                  # Directory guard
│   ├── 📁 Database/                  # Database abstraction layer
│   │   ├── 📄 IDbConnection.php      # Database connection interface contract
│   │   └── 📄 index.php              # Directory guard
│   ├── 📁 Entity/                    # Data entities/models
│   │   ├── 📄 User.php               # User entity class with typed properties
│   │   └── 📄 index.php              # Directory guard
│   └── 📁 Utils/                     # Utility classes
│       ├── 📄 AccessLogger.php       # HTTP access logging utility
│       ├── 📄 DateTime.php           # Date/time helper functions
│       ├── 📄 Math.php               # Mathematical utility functions
│       └── 📄 index.php              # Directory guard
│
├── 📁 install/                       # First-time installation wizard
│   ├── 📄 index.php                  # Installation entry point and step controller
│   ├── 📄 process.php                # Installation processing (DB creation, config write)
│   ├── 📄 ajax_croppers.php          # Cropper generation AJAX handler
│   ├── 📁 data/                      # Installation SQL data
│   │   ├── 📄 .htaccess              # Access restriction
│   │   └── 📄 constant_format.tpl    # Config file template with placeholders
│   ├── 📁 include/                   # Installation helper functions
│   │   └── 📄 accounts.php           # Default account creation logic
│   └── 📁 templates/                 # Installation UI templates (9 files)
│       ├── 📄 greet.tpl              # Welcome/language selection
│       ├── 📄 config.tpl             # Database configuration form (34KB)
│       ├── 📄 accounts.tpl           # Admin account setup
│       ├── 📄 wdata.tpl              # World data generation progress
│       ├── 📄 dataform.tpl           # Data import form
│       ├── 📄 script.tpl             # Post-install script execution
│       ├── 📄 end.tpl                # Installation complete
│       └── 📄 menu.tpl               # Installation step navigation
│
├── 📁 notification/                  # Push notification system
│   ├── 📄 index.php                  # Notification entry point
│   ├── 📄 crypt.js                   # Notification encryption (147KB)
│   ├── 📄 favicon.ico                # Notification page icon
│   ├── 📁 gpack/                     # Notification theme assets
│   │   └── 📁 notification_v1_zzjhons/ # V1 notification skin
│   ├── 📁 lang/                      # Notification translations
│   │   ├── 📄 en.php                 # English notification strings
│   │   └── 📄 index.php              # Directory guard
│   └── 📁 img/                       # Notification images
│
├── 📁 tools/                         # Developer/maintenance tools
│   ├── 📄 escape_function_parameters.php  # SQL injection prevention tool (147KB)
│   ├── 📄 regexor.php                # Query regex optimizer
│   ├── 📄 regexor.sql                # Regex optimization SQL dumps (1.5MB)
│   ├── 📄 regexor-for-slow-queries.php # Slow query analyzer
│   ├── 📄 regexor-slow.sql           # Slow query examples
│   └── 📄 index.php                  # Directory guard
│
├── 📁 var/                           # Runtime variable storage
│   ├── 📄 .htaccess                  # Access restriction
│   ├── 📄 index.php                  # Directory guard
│   ├── 📁 db/                        # Database cache/temp files
│   └── 📁 log/                       # Application log files
│
│
├── 📄 mobile.css                      # Master mobile CSS aggregator — imports all partials from mobile/
├── 📁 mobile/                         # Modular mobile responsive CSS partials (≤768px breakpoints)
│   ├── 📄 _base.css                   # Global defaults (hide mobile-only elements on desktop)
│   ├── 📄 _tablet.css                 # ≤980px — remove fixed widths for public + in-game pages
│   ├── 📄 _phone_public.css           # ≤768px — public pages (index, tutorials, hamburger sidebar)
│   ├── 📄 _phone_outgame.css          # ≤768px — outgame pages (login, signup, activate forms)
│   ├── 📄 _phone_ingame.css           # ≤768px — in-game core (import aggregator)
│   ├── 📁 _phone_ingame/              # Modularized ingame CSS chunks
│   │   ├── 📄 global.css              # Global resets and flexbox wrappers
│   │   ├── 📄 header.css              # Top navigation, time display, and banner
│   │   ├── 📄 navigation.css          # Side and tab pill-button navigation
│   │   ├── 📄 content.css             # Main content area, maps, side info, and tables
│   │   └── 📄 popups_footer.css       # Popups, dialog overrides, and footer
│   ├── 📄 _phone_ingame_pages.css     # ≤768px — page-specific overrides (messages, reports, mass msg)
│   ├── 📄 _phone_alliance.css         # ≤768px — alliance pages (forum, chat, overview, diplomacy)
│   ├── 📄 _phone_plus.css             # ≤768px — gold shop/plus page (cards grid, buy buttons)
│   └── 📄 _small_phone.css            # ≤480px — final tightening for narrow screens
│
└── 📁 docs/                          # Project documentation (our workspace)
    ├── 📄 project_structure.md       # This file - current architecture snapshot
    ├── 📄 changelog.md               # Change history log
    └── 📁 plans/                     # Phase execution checklists
        ├── 📄 phase-1.md             # RTL, Arabic translation, mobile responsiveness
        ├── 📄 phase-2.md             # Gold/prize distribution (weekly to daily)
        └── 📄 phase-3.md             # Hall of Fame feature

---
### 🎨 Project Metadata
- **Design System**: Classic Travian browser game UI (table-based + CSS positioning)
- **Typography**: Default browser fonts (to be replaced with Arabic web fonts in Phase 1)
- **Color Palette**: Travian green/brown earth tones with gold accents
- **Tech Stack**: PHP 7+, MySQL/MariaDB, MooTools JS, Apache (.htaccess)
- **Localization**: define()-based constants in GameEngine/Lang/ (en, fr, it, zh_tw — NO Arabic yet)
- **Themes**: 3 graphic packs (travian, travian_default, travian_t4) with modular CSS
- **Key CSS Files for RTL**:
  - `gpack/travian/main.css` (13KB - primary game layout)
  - `gpack/travian/main_en.css` (14KB - English overrides)
  - `gpack/travian_default/modules/new_layout_ltr.css` (5KB - LTR layout)
  - `gpack/travian_t4/modules/new_layout_ltr.css` (5KB - T4 LTR layout)
  - `img/portal_ltr.css` (19KB - landing page LTR)
- **Total Files**: ~500+ (excluding images)
- **Largest Files**: Database.php (340KB), Automation.php (240KB), en.php (116KB)
```
