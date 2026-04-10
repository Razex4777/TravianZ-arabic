const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'GameEngine', 'Lang', 'ar.php');
const dirPath = path.join(__dirname, 'GameEngine', 'Lang', 'ar');

if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath);
}

const content = fs.readFileSync(filePath, 'utf8');
const lines = content.split('\n');

const parts = [];
let currentPart = [];
let linesInPart = 0;

for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (line.trim() === '<?php') continue;

    currentPart.push(line);
    linesInPart++;

    if (linesInPart >= 400 && line.trim() === '') {
        parts.push(currentPart);
        currentPart = [];
        linesInPart = 0;
    }
}

if (currentPart.length > 0) {
    parts.push(currentPart);
}

const includeLines = ["<?php", "// Automatically split parts"];
for (let i = 0; i < parts.length; i++) {
    const partFilename = `part${i + 1}.php`;
    const partFilepath = path.join(dirPath, partFilename);
    const writeContent = ["<?php"].concat(parts[i]).join('\n');
    fs.writeFileSync(partFilepath, writeContent, 'utf8');
    includeLines.push(`require_once(__DIR__ . '/ar/${partFilename}');`);
}

fs.writeFileSync(filePath, includeLines.join('\n'), 'utf8');
console.log(`Split into ${parts.length} parts effectively.`);
