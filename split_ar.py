import os

file_path = r"c:\Users\MSI-PC\OneDrive\Documents\freelancing\TravianZ-master\GameEngine\Lang\ar.php"
dir_path = r"c:\Users\MSI-PC\OneDrive\Documents\freelancing\TravianZ-master\GameEngine\Lang\ar"

if not os.path.exists(dir_path):
    os.makedirs(dir_path)

with open(file_path, "r", encoding="utf-8") as f:
    lines = f.readlines()

parts = []
current_part = []
part_index = 1
lines_in_part = 0

for line in lines:
    if line.strip() == "<?php":
        continue
    current_part.append(line)
    lines_in_part += 1
    # Try to split near 400 lines, but only at a naturally empty line or comment
    if lines_in_part >= 400 and line.strip() == "":
        parts.append(current_part)
        current_part = []
        lines_in_part = 0

if current_part:
    parts.append(current_part)

include_lines = ["<?php\n", "// Automatically split parts\n"]
for i, p in enumerate(parts):
    part_filename = f"part{i+1}.php"
    part_filepath = os.path.join(dir_path, part_filename)
    with open(part_filepath, "w", encoding="utf-8") as pf:
        pf.write("<?php\n")
        pf.writelines(p)
    include_lines.append(f"require_once(__DIR__ . '/ar/{part_filename}');\n")

with open(file_path, "w", encoding="utf-8") as f:
    f.writelines(include_lines)

print(f"Split into {len(parts)} parts effectively.")
