/**
 * flip_css.js - RTL CSS Converter for TravianZ
 * 
 * Copies CSS files from EN compact/ to AR compact/ and performs
 * proper LTR → RTL conversion by swapping directional properties.
 * 
 * Usage: node flip_css.js
 * Run from: gpack/travian_default/lang/ar/
 */

const fs = require('fs');
const path = require('path');

const enDir = path.join(__dirname, '..', 'en', 'compact');
const arDir = path.join(__dirname, 'compact');

// Ensure AR compact dir exists
if (!fs.existsSync(arDir)) {
  fs.mkdirSync(arDir, { recursive: true });
}

/**
 * Swap left↔right in a CSS file with safe placeholder-based approach.
 * Handles: float, text-align, margin-*, padding-*, left/right positioning,
 * background-position, border-*-radius, border-left/right, clear.
 */
function flipCss(css) {
  // Use unique placeholders to avoid double-swap
  const PH_LEFT = '___PLACEHOLDER_LEFT___';
  const PH_RIGHT = '___PLACEHOLDER_RIGHT___';

  // 1. Swap float: left ↔ float: right
  css = css.replace(/float:\s*left/gi, 'float:' + PH_RIGHT);
  css = css.replace(/float:\s*right/gi, 'float:' + PH_LEFT);
  css = css.replace(new RegExp('float:' + PH_RIGHT, 'g'), 'float: right');
  css = css.replace(new RegExp('float:' + PH_LEFT, 'g'), 'float: left');

  // 2. Swap text-align: left ↔ text-align: right
  css = css.replace(/text-align:\s*left/gi, 'text-align:' + PH_RIGHT);
  css = css.replace(/text-align:\s*right/gi, 'text-align:' + PH_LEFT);
  css = css.replace(new RegExp('text-align:' + PH_RIGHT, 'g'), 'text-align: right');
  css = css.replace(new RegExp('text-align:' + PH_LEFT, 'g'), 'text-align: left');

  // 3. Swap clear: left ↔ clear: right
  css = css.replace(/clear:\s*left(?!\s*;)/gi, 'clear:' + PH_RIGHT);
  css = css.replace(/clear:\s*right(?!\s*;)/gi, 'clear:' + PH_LEFT);
  css = css.replace(new RegExp('clear:' + PH_RIGHT, 'g'), 'clear: right');
  css = css.replace(new RegExp('clear:' + PH_LEFT, 'g'), 'clear: left');

  // 4. Swap margin-left ↔ margin-right (property names)
  css = css.replace(/margin-left/gi, 'margin-' + PH_RIGHT);
  css = css.replace(/margin-right/gi, 'margin-' + PH_LEFT);
  css = css.replace(new RegExp('margin-' + PH_RIGHT, 'g'), 'margin-right');
  css = css.replace(new RegExp('margin-' + PH_LEFT, 'g'), 'margin-left');

  // 5. Swap padding-left ↔ padding-right (property names)
  css = css.replace(/padding-left/gi, 'padding-' + PH_RIGHT);
  css = css.replace(/padding-right/gi, 'padding-' + PH_LEFT);
  css = css.replace(new RegExp('padding-' + PH_RIGHT, 'g'), 'padding-right');
  css = css.replace(new RegExp('padding-' + PH_LEFT, 'g'), 'padding-left');

  // 6. Swap left: ↔ right: (positional properties - careful with selectors)
  //    Only swap standalone "left:" and "right:" at the start of a CSS property
  css = css.replace(/^(\s+)left:/gm, '$1' + PH_RIGHT + ':');
  css = css.replace(/^(\s+)right:/gm, '$1' + PH_LEFT + ':');
  css = css.replace(new RegExp(PH_RIGHT + ':', 'g'), 'right:');
  css = css.replace(new RegExp(PH_LEFT + ':', 'g'), 'left:');

  // 7. Swap border-left ↔ border-right
  css = css.replace(/border-left/gi, 'border-' + PH_RIGHT);
  css = css.replace(/border-right/gi, 'border-' + PH_LEFT);
  css = css.replace(new RegExp('border-' + PH_RIGHT, 'g'), 'border-right');
  css = css.replace(new RegExp('border-' + PH_LEFT, 'g'), 'border-left');

  // 8. Swap background-position: left ↔ right (keyword-based only)
  css = css.replace(/background-position:\s*left/gi, 'background-position: ' + PH_RIGHT);
  css = css.replace(/background-position:\s*right/gi, 'background-position: ' + PH_LEFT);
  css = css.replace(new RegExp('background-position: ' + PH_RIGHT, 'g'), 'background-position: right');
  css = css.replace(new RegExp('background-position: ' + PH_LEFT, 'g'), 'background-position: left');

  // 9. Swap border-*-left-radius ↔ border-*-right-radius
  css = css.replace(/border-top-left-radius/gi, 'border-top-' + PH_RIGHT + '-radius');
  css = css.replace(/border-top-right-radius/gi, 'border-top-' + PH_LEFT + '-radius');
  css = css.replace(new RegExp('border-top-' + PH_RIGHT + '-radius', 'g'), 'border-top-right-radius');
  css = css.replace(new RegExp('border-top-' + PH_LEFT + '-radius', 'g'), 'border-top-left-radius');

  css = css.replace(/border-bottom-left-radius/gi, 'border-bottom-' + PH_RIGHT + '-radius');
  css = css.replace(/border-bottom-right-radius/gi, 'border-bottom-' + PH_LEFT + '-radius');
  css = css.replace(new RegExp('border-bottom-' + PH_RIGHT + '-radius', 'g'), 'border-bottom-right-radius');
  css = css.replace(new RegExp('border-bottom-' + PH_LEFT + '-radius', 'g'), 'border-bottom-left-radius');

  return css;
}

// Process all CSS files
const files = fs.readdirSync(enDir);
let count = 0;

for (const file of files) {
  if (!file.endsWith('.css')) continue;

  const enPath = path.join(enDir, file);
  const arPath = path.join(arDir, file);

  // Read fresh EN source
  const enCss = fs.readFileSync(enPath, 'utf8');

  // Flip to RTL
  const arCss = flipCss(enCss);

  // Write to AR
  fs.writeFileSync(arPath, arCss, 'utf8');
  console.log(`Flipped: ${file}`);
  count++;
}

console.log(`\nDone! ${count} files converted from LTR to RTL.`);
