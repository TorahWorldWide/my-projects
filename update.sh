#!/usr/bin/env bash
# Publish data.json/index.html changes to GitHub Pages: ./update.sh "what changed"
set -euo pipefail
cd "$(dirname "$0")"
python3 - <<'PY'
import json,datetime
d=json.load(open('data.json')); d['updated']=datetime.datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')
json.dump(d,open('data.json','w'),ensure_ascii=False,indent=2)
PY
git add -A && git commit -qm "${1:-update}" && GIT_ASKPASS="$HOME/.hermes/git-askpass.sh" git push -q origin main && echo "pushed: https://torahworldwide.github.io/my-projects/"
