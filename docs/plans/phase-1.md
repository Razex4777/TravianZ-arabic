# Phase 1: Comprehensive RTL, Translation, & Mobile Setup

## 1. Complete RTL & CSS Flip
- [x] Locate main CSS files (`layout.css`, etc.)
- [x] Flip grid and layout direction (`float: left` -> `float: right`, margins, paddings, absolute positioning)
- [x] Fix the top header so resources (wood, clay, iron, crop, gold) display right-to-left
- [x] Flip directional background images (sprites) like arrows and menus where necessary
- [x] Ensure consistent typography for Arabic layout text

## 2. Comprehensive Arabic Translation
- [x] Search `Templates/` for hardcoded English strings (e.g., building names, error messages)
- [x] Extract these strings and place them in the Arabic language file (`GameEngine/Lang/ar.php` or equivalent)
- [x] Substitute hardcoded text in templates with PHP translation constants (e.g. `<?php echo LANG_EXAMPLE; ?>`)
- [x] Verify contextual correctness of previously translated texts

## 3. Mobile Responsiveness Implementation
- [ ] Inject `<meta name="viewport" content="width=device-width, initial-scale=1.0">` into `header.tpl`
- [ ] Add base Media Queries (`@media (max-width: 768px)`, `@media (max-width: 480px)`)
- [ ] Adjust fixed ~1000px wrappers to relative widths (`100%`, `auto`)
- [ ] Collapse sidebar and main content vertically for smaller screens
- [ ] Ensure buttons, navigation elements, and the game map have sufficient touch targets

## Review
- [ ] Cross-check Layout against `travianksa.com` on desktop and simulated mobile
- [ ] Send update to Hassan K. with screenshots/evidence
