#!/usr/bin/env bash
set -euo pipefail

echo "1) Repo has site files:"
test -f _config.yml && echo "   - _config.yml ✓" || (echo "   - _config.yml MISSING"; exit 1)
test -d _posts && echo "   - _posts/ ✓" || (echo "   - _posts/ MISSING"; exit 1)
test -d _projects && echo "   - _projects/ ✓" || (echo "   - _projects/ MISSING"; exit 1)
test -d .github/workflows && echo "   - .github/workflows/ ✓" || (echo "   - .github/workflows/ MISSING"; exit 1)

echo "2) Jekyll config sanity:"
grep -q "^title:" _config.yml && echo "   - title present ✓" || (echo "   - title missing"; exit 1)
grep -q "^plugins:" _config.yml && echo "   - plugins present ✓" || (echo "   - plugins missing"; exit 1)

echo "3) Contact form placeholder present:"
grep -q "formspree.io/f/your-form-id" contact.md && echo "   - replace Formspree ID later ✓" || echo "   - custom Formspree already set"

echo "4) Blog template exists:"
test -f templates/blog-template.md && echo "   - templates/blog-template.md ✓" || (echo "   - blog template missing"; exit 1)

echo "✅ Local preflight checks passed. Commit & push if not already."
