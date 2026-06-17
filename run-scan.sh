#!/bin/bash

curl -s "https://md.archlinux.org/s/SxbqukK6IA" -o infected.html
awk '/<div id="doc"/{p=1; next} /`\`\`<\/div>/{p=0} p && NF {print}' infected.html | grep -E '^[a-zA-Z0-9]' > infected.txt
rm -f infected.html

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INFECTED="$SCRIPT_DIR/infected.txt"

installed=$(pacman -Qqe 2>/dev/null | sort)

matches=$(comm -12 <(sort "$INFECTED") <(echo "$installed"))
count=$(echo "$matches" | grep -c . 2>/dev/null || echo 0)

if [[ -z "$matches" ]]; then
    count=0
fi

echo "========================================"
echo "Infected package scan: $count match(es)"
echo "========================================"

if [[ $count -gt 0 ]]; then
    for pkg in $matches; do
        echo "  $pkg — https://aur.archlinux.org/packages/$pkg"
    done
else
    echo "None found — system is clean."
fi
