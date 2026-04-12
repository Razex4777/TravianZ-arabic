#!/bin/bash
# fix_mobile_css_order.sh — Move mobile.css to be the LAST stylesheet in all PHP files
# This ensures mobile responsive styles override legacy compact.css and lang.css

cd /var/www/html

count=0
for f in *.php; do
  if grep -q 'mobile\.css' "$f"; then
    # Remove existing mobile.css link
    sed -i '/<link.*mobile\.css.*\/>/d' "$f"
    # Insert mobile.css right before </head>
    sed -i 's|</head>|\t<link rel="stylesheet" type="text/css" href="mobile.css" />\n</head>|' "$f"
    count=$((count + 1))
  fi
done

echo "Fixed CSS load order in $count PHP files"
