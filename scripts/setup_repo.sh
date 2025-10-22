#!/usr/bin/env bash
set -euo pipefail

REPO_SSH="${1:-git@github.com:JoeySmith-SOC/sentinelopusconsulting.git}"

mkdir -p .github/workflows
cat > .github/workflows/jekyll.yml <<'YML'
name: Build and Deploy Jekyll
on:
  push: { branches: [ "main" ] }
  workflow_dispatch:
permissions: { contents: read, pages: write, id-token: write }
concurrency: { group: "pages", cancel-in-progress: true }
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with: { ruby-version: '3.2', bundler-cache: true }
      - run: |
          bundle config set path 'vendor/bundle'
          bundle install
      - run: bundle exec jekyll build --trace
      - uses: actions/upload-pages-artifact@v3
        with: { path: _site }
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment: { name: github-pages, url: ${{ steps.deployment.outputs.page_url }} }
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
YML

git init
git add -A
git commit -m "Initial commit — deploy-ready Jekyll site"
git branch -M main
if ! git remote | grep -q "^origin$"; then
  git remote add origin "$REPO_SSH"
fi
git push -u origin main

echo "✅ Pushed main. Go to GitHub → Actions to watch the build."
