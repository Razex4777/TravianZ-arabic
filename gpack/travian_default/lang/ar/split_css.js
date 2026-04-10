const fs = require('fs');
const path = require('path');

const css = fs.readFileSync('compact.css', 'utf8');

const tokens = [];
const regex = /(\/\*[\s\S]*?\*\/)|([^{}/]+?\{[^}]*\})/g;
let match;
while ((match = regex.exec(css)) !== null) {
    if (match[1]) {
        tokens.push({ type: 'comment', value: match[1] });
    } else if (match[2]) {
        tokens.push({ type: 'rule', value: match[2] });
    }
}

const outDir = path.join(__dirname, 'compact');
if (fs.existsSync(outDir)) {
    fs.rmSync(outDir, { recursive: true, force: true });
}
fs.mkdirSync(outDir);

const categories = {
    layout: [],
    village1: [],
    village2: [],
    village3: [],
    login_signup: [],
    map: [],
    alliance: [],
    player: [],
    reports_messages: [],
    buildings: [],
    statistics: [],
    forum: [],
    quest: [],
    ui: [],
    cropfinder: [],
    warsim: [],
    plus: [],
    support: [],
    a2b: [],
    global: [],
    misc: []
};

let currentComments = [];

tokens.forEach(token => {
    if (token.type === 'comment') {
        currentComments.push(token.value);
    } else if (token.type === 'rule') {
        let rule = token.value.trim();
        let selectorPart = rule.split('{')[0].trim();
        let selectors = selectorPart.split(',').map(s => s.trim());
        let firstSelector = selectors[0] || "";
        
        let targetCat = 'misc';

        if (firstSelector.startsWith('div#header') || firstSelector.startsWith('div#mid') || firstSelector.startsWith('div#content') || firstSelector.startsWith('div#footer') || firstSelector.includes('#mtop') || firstSelector.includes('#dynamic_header') || firstSelector.includes('#side_navi') || firstSelector.includes('#side_info')) {
            targetCat = 'layout';
        } else if (firstSelector.startsWith('div.village1')) {
            targetCat = 'village1';
        } else if (firstSelector.startsWith('div.village2')) {
            targetCat = 'village2';
        } else if (firstSelector.startsWith('div.village3')) {
            targetCat = 'village3';
        } else if (firstSelector.startsWith('div.login') || firstSelector.startsWith('div.logout') || firstSelector.startsWith('div.signup') || firstSelector.startsWith('div.activate')) {
            targetCat = 'login_signup';
        } else if (firstSelector.startsWith('div.map') || firstSelector.includes('popup_map') || firstSelector.includes('div#map')) {
            targetCat = 'map';
        } else if (firstSelector.startsWith('div.alliance')) {
            targetCat = 'alliance';
        } else if (firstSelector.startsWith('div.player')) {
            targetCat = 'player';
        } else if (firstSelector.startsWith('div.reports') || firstSelector.startsWith('div.messages')) {
            targetCat = 'reports_messages';
        } else if (firstSelector.startsWith('div.build') || firstSelector.startsWith('div#build') || firstSelector.startsWith('.build')) {
            targetCat = 'buildings';
        } else if (firstSelector.startsWith('div.statistics')) {
            targetCat = 'statistics';
        } else if (firstSelector.startsWith('div.forum')) {
            targetCat = 'forum';
        } else if (firstSelector.includes('.quest') || firstSelector.includes('#qstd')) {
            targetCat = 'quest';
        } else if (firstSelector.startsWith('div.cropfinder')) {
            targetCat = 'cropfinder';
        } else if (firstSelector.startsWith('div.warsim')) {
            targetCat = 'warsim';
        } else if (firstSelector.startsWith('div.plus')) {
            targetCat = 'plus';
        } else if (firstSelector.startsWith('div.support')) {
            targetCat = 'support';
        } else if (firstSelector.startsWith('div.a2b')) {
            targetCat = 'a2b';
        } else if (firstSelector.startsWith('table') || firstSelector.startsWith('td') || firstSelector.startsWith('th') || firstSelector.startsWith('tr')) {
            targetCat = 'ui';
        } else if (firstSelector.startsWith('input') || firstSelector.startsWith('textarea') || firstSelector.startsWith('select')) {
            targetCat = 'ui';
        } else if (firstSelector.startsWith('p.') || firstSelector.startsWith('span.') || firstSelector.startsWith('a.') || firstSelector.startsWith('.f') || firstSelector.startsWith('.c') || firstSelector.startsWith('body.ie') || firstSelector.startsWith('body.presto')) {
            targetCat = 'ui';
        } else if (/^[a-zA-Z]/.test(firstSelector) && !firstSelector.includes('.')) {
            targetCat = 'global';
        }

        // Apply URL fix for depth + 1
        rule = rule.replace(/url\((['"]?)(.*?)(['"]?)\)/g, (match, p1, p2, p3) => {
            if (p2.startsWith('http') || p2.startsWith('data:') || p2.startsWith('/')) {
                return match;
            }
            return `url(${p1}../${p2}${p3})`;
        });

        let fullRuleText = currentComments.join('\n') + (currentComments.length > 0 ? '\n' : '') + rule;
        categories[targetCat].push(fullRuleText);
        currentComments = []; 
    }
});

if (currentComments.length > 0) {
    categories.misc.push(currentComments.join('\n'));
}

let imports = [];

for (let cat in categories) {
    if (categories[cat].length > 0) {
        let rulesArr = categories[cat];
        let chunks = [];
        let currentChunk = [];
        let currentLines = 0;
        
        rulesArr.forEach(ruleText => {
            let numLines = ruleText.split('\n').length;
            if (currentLines + numLines > 400 && currentChunk.length > 0) {
                chunks.push(currentChunk);
                currentChunk = [];
                currentLines = 0;
            }
            currentChunk.push(ruleText);
            currentLines += numLines;
        });
        if (currentChunk.length > 0) chunks.push(currentChunk);
        
        if (chunks.length === 1) {
            fs.writeFileSync(path.join(outDir, `${cat}.css`), chunks[0].join('\n\n'));
            imports.push(`@import url("compact/${cat}.css");`);
        } else {
            chunks.forEach((chunk, idx) => {
                let filename = `${cat}_part${idx + 1}.css`;
                // everything is flat in 'compact/' to make url fixing uniform
                fs.writeFileSync(path.join(outDir, filename), chunk.join('\n\n'));
                imports.push(`@import url("compact/${filename}");`);
            });
        }
    }
}

fs.writeFileSync(path.join(__dirname, 'compact.css'), imports.join('\n') + '\n');
console.log("Splitting finished and compact.css updated with imports. URLs fixed for depth+1.");
