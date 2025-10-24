#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${HOME}/Projects/sentinelopusconsulting"
cd "$REPO_DIR"

echo "=== Brandify: steps #5 → #12 ==="

# ---------- 5) ABOUT ----------
echo "[5] Writing About page…"
cat > about.md <<'MD'
---
layout: page
title: About
permalink: /about/
description: About Joey — IAM × OT security specialist.
---

I’m an Identity & Access Management specialist who treats security like a leadership problem: if the outcome isn’t right, I own it until it is. I’ve supported and engineered IAM in live enterprise environments—standing up authentication policies, stabilizing SSO and provisioning, and pushing automation so access is fast, auditable, and safe.

I bridge cyber and the electrical/OT world. That means applying Zero Trust, segmentation, and monitoring where safety and uptime matter most. My north star is extreme accountability. There are no bad teams—only leaders who refuse to lead. If we work together, expect candid assessments, disciplined execution, and outcomes we can measure.

[Download my resume (PDF)](/assets/docs/Resume_Joseph_Smith_IAM.pdf)
MD
echo "✓ About page updated."

# ---------- 6) SERVICES ----------
echo "[6] Updating Services page…"
cat > services.md <<'MD'
---
layout: page
title: Services
permalink: /services/
---

## Freelance Services

- **IAM / Federation:** Okta, SAML/OIDC, lifecycle automation, fine-grained policies.
- **Zero Trust for SMB:** Cloudflare Access, device posture, MFA rollout, logging.
- **Linux & Automation:** Ansible/Terraform, hardened baselines, CI/CD for infra.
- **Cyber × Electrical (OT):** Secure smart installs, segmentation, monitoring, incident playbooks.
MD
echo "✓ Services updated."

# ---------- 7) PROJECTS ----------
echo "[7] Projects left as-is (edit _projects/*.md anytime)."
echo "✓ Projects unchanged."

# ---------- 8) BLOG: first post ----------
echo "[8] Creating first blog post from template…"
TODAY="$(date +%F)"
SLUG="the-sentinel-identity-manifesto"
POST_PATH="_posts/${TODAY}-${SLUG}.md"
if [[ -f "templates/blog-template.md" ]]; then
  cp -f templates/blog-template.md "$POST_PATH"
  sed -i "s|^title:.*$|title: The Sentinel Identity Manifesto|" "$POST_PATH"
  sed -i "s|^date:.*$|date: ${TODAY}|" "$POST_PATH"
  sed -i "s|<Compelling H1 Title Goes Here>|The Sentinel Identity Manifesto|" "$POST_PATH"
  sed -i "s|<YYYY-MM-DD>|${TODAY}|" "$POST_PATH"
  sed -i "s|<slug>|${SLUG}|" "$POST_PATH"
  # Add default TL;DR/description if blank
  awk '
    BEGIN{desc_set=0}
    /^tldr:/ {print; next}
    /^canonical_url:/ {print; next}
    /^---$/ && NR>1 && !desc_set {print "description: A field guide to identity work that reduces risk and friction."; desc_set=1; print; next}
    {print}
  ' "$POST_PATH" > "${POST_PATH}.tmp" && mv "${POST_PATH}.tmp" "$POST_PATH"
  echo "✓ Post created: $POST_PATH"
else
  echo "⚠ templates/blog-template.md not found — skipping post."
fi

# ---------- 9) Analytics snippet in footer ----------
echo "[9] Adding Cloudflare Web Analytics snippet…"
FOOTER="_includes/footer.html"
ANALYTIC_TAG='static.cloudflareinsights.com/beacon.min.js'
if ! grep -q "$ANALYTIC_TAG" "$FOOTER"; then
  sed -i "s|</footer>|<!-- Cloudflare Web Analytics --><script defer src='https://static.cloudflareinsights.com/beacon.min.js' data-cf-beacon='{\"token\":\"YOUR_TOKEN\"}'></script>\n</footer>|" "$FOOTER"
  echo "✓ Analytics snippet added (replace YOUR_TOKEN later)."
else
  echo "✓ Analytics snippet already present."
fi

# ---------- 10) Favicon + OG image meta in <head> ----------
echo "[10] Adding favicon + OpenGraph meta in <head>…"
DEFAULT="_layouts/default.html"
# insert only if not present
if ! grep -q 'rel="icon"' "$DEFAULT"; then
  sed -i "s|<script defer src=\"{{ '/assets/js/theme-toggle.js' | relative_url }}\"></script>|<script defer src=\"{{ '/assets/js/theme-toggle.js' | relative_url }}\"></script>\n    <link rel=\"icon\" href=\"{{ '/assets/img/favicon.png' | relative_url }}\" sizes=\"32x32\">\n    <meta property=\"og:image\" content=\"{{ '/assets/img/og-default.png' | absolute_url }}\">\n    <meta name=\"twitter:card\" content=\"summary_large_image\">|" "$DEFAULT"
  echo "✓ Meta tags inserted."
else
  echo "✓ Meta tags already present."
fi

# create tiny placeholder images (1x1 PNGs) so links work
mkdir -p assets/img
# transparent 1x1 PNG (base64)
cat > assets/img/favicon.png <<'B64'
�PNG

���
IHDR����������S���sBIT|d����	pHYs�����������
IDATx�������=�����IEND�B`�
B64
cat > assets/img/og-default.png <<'B64'
�PNG

���
IHDR����������S���sBIT|d����	pHYs�����������
IDATx�������=�����IEND�B`�
B64
echo "✓ Placeholder images created at assets/img/ (replace with your real files anytime)."

# ---------- 11) Hire Me CTA on Home ----------
echo "[11] Injecting Hire Me CTA into home layout…"
HOME_LAYOUT="_layouts/home.html"
if ! grep -q "Work with me" "$HOME_LAYOUT"; then
  cat >> "$HOME_LAYOUT" <<'HTML'

<section class="split">
  <div>
    <h2>Work with me</h2>
    <p>I design IAM and OT security that measurably reduces risk without slowing teams down.</p>
    <a class="btn primary" href="{{ '/contact/' | relative_url }}">Book a consult</a>
  </div>
  <div>
    <h2>What I deliver</h2>
    <ul class="list">
      <li>Okta federation done right (SAML/OIDC)</li>
      <li>Cloudflare Zero Trust for small teams</li>
      <li>Linux/Ansible/Terraform automation kits</li>
      <li>Secure smart installs (OT/Electrical)</li>
    </ul>
  </div>
</section>
HTML
  echo "✓ CTA block added."
else
  echo "✓ CTA block already present."
fi

# ---------- 12) SEO: ensure description exists in posts ----------
echo "[12] Adding description front matter to posts that lack it…"
changed=0
for p in _posts/*.md; do
  # skip if not a file
  [[ -f "$p" ]] || continue
  if ! awk 'f&&/^---/{exit} /^description:/{f=1} END{exit !f}' "$p"; then
    # Insert 'description:' after first 'tldr:' if possible, else before closing '---'
    awk '
      BEGIN{inserted=0}
      /^tldr:/ && !inserted { print; print "description: See how to reduce risk and friction with practical IAM."; inserted=1; next }
      /^---$/ && NR>1 && !inserted { print "description: See how to reduce risk and friction with practical IAM."; inserted=1; print; next }
      { print }
    ' "$p" > "${p}.tmp" && mv "${p}.tmp" "$p"
    echo "  • added description to $p"
    changed=1
  fi
done
[[ $changed -eq 0 ]] && echo "✓ All posts had descriptions."

# ---------- Commit & show summary ----------
echo "Committing changes…"
git add -A
git commit -m "Brandify: About, Services, first post, analytics, favicon/OG, CTA, SEO descriptions" || echo "Nothing to commit."
git push || echo "Nothing to push."

echo "=== Done ==="
echo "Next manual steps:"
echo "  • Replace assets/img/favicon.png and assets/img/og-default.png with your real images."
echo "  • Replace YOUR_TOKEN in _includes/footer.html with your Cloudflare Analytics token."
echo "  • Edit the new blog post content in ${POST_PATH}."
