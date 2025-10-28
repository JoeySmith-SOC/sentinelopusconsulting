set -euo pipefail

echo "▶ Creating asset folders…"
mkdir -p assets/img assets/icons

echo "▶ Adding placeholder hero image (replace later with a real photo at assets/img/hero.jpg)…"
# ultra-small placeholder; swap with your own 1920x1080 photo later
printf "\x89PNG\r\n\x1a\n" > assets/img/hero.png

echo "▶ Writing service SVG icons…"
cat > assets/icons/iam.svg <<'SVG'
<svg width="64" height="64" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="2"/><path d="M4 20c0-4 4-6 8-6s8 2 8 6" stroke="currentColor" stroke-width="2" fill="none"/></svg>
SVG
cat > assets/icons/zerotrust.svg <<'SVG'
<svg width="64" height="64" viewBox="0 0 24 24" fill="none"><rect x="3" y="7" width="18" height="10" rx="2" stroke="currentColor" stroke-width="2"/><path d="M7 7V5a5 5 0 0 1 10 0v2" stroke="currentColor" stroke-width="2"/></svg>
SVG
cat > assets/icons/automation.svg <<'SVG'
<svg width="64" height="64" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="2"/><path d="M12 2v3M12 19v3M4.22 4.22l2.12 2.12M17.66 17.66l2.12 2.12M2 12h3M19 12h3M4.22 19.78l2.12-2.12M17.66 6.34l2.12-2.12" stroke="currentColor" stroke-width="2"/></svg>
SVG
cat > assets/icons/ot.svg <<'SVG'
<svg width="64" height="64" viewBox="0 0 24 24" fill="none"><rect x="3" y="4" width="18" height="14" rx="2" stroke="currentColor" stroke-width="2"/><path d="M7 20h10" stroke="currentColor" stroke-width="2"/></svg>
SVG

echo "▶ Enabling cover images in post layout…"
POST_LAYOUT="_layouts/post.html"
if ! grep -q 'page.image' "$POST_LAYOUT"; then
  awk 'NR==1{print; next} NR==2{print; print "{% if page.image %}<img class=\"cover\" src=\"{{ page.image | relative_url }}\" alt=\"\"/>{% endif %}"; next} {print}' "$POST_LAYOUT" > "${POST_LAYOUT}.tmp" && mv "${POST_LAYOUT}.tmp" "$POST_LAYOUT"
fi

echo "▶ Enabling images in project layout…"
PROJ_LAYOUT="_layouts/project.html"
if ! grep -q 'page.image' "$PROJ_LAYOUT"; then
  awk 'NR==1{print; next} NR==2{print; print "{% if page.image %}<img class=\"project-cover\" src=\"{{ page.image | relative_url }}\" alt=\"\"/>{% endif %}"; next} {print}' "$PROJ_LAYOUT" > "${PROJ_LAYOUT}.tmp" && mv "${PROJ_LAYOUT}.tmp" "$PROJ_LAYOUT"
fi

echo "▶ Adding hero background + icons + image styles to CSS…"
cat >> assets/css/main.css <<'CSS'

/* === Visual upgrade === */
.hero {
  position: relative;
  padding: 4.5rem 0 3rem;
  background:
    linear-gradient(180deg, rgba(0,0,0,.55), rgba(0,0,0,.55)),
    url('/assets/img/hero.jpg') center/cover no-repeat;
}
.hero .sub { max-width: 780px; }

.card .icon {
  display:inline-flex; align-items:center; justify-content:center;
  width:56px; height:56px; border-radius:12px;
  background: rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.06);
  margin-bottom:.6rem;
}
.card .icon img, .card .icon svg { width:28px; height:28px; color: var(--accent); }

.cover, .project-cover {
  width:100%; height: 260px; object-fit: cover;
  border-radius: 12px; margin: .6rem 0 1rem;
  border:1px solid rgba(255,255,255,.06); background: var(--card);
}

/* Subtle hover polish */
.card { transition: transform .15s ease, box-shadow .15s ease; }
.card:hover { transform: translateY(-2px); box-shadow: 0 6px 22px rgba(0,0,0,.25); }
CSS

echo "▶ Wiring service icons into home layout cards…"
HOME="_layouts/home.html"
# Insert icon spans at the top of each service card if not present
# IAM / Federation
if ! grep -q "assets/icons/iam.svg" "$HOME"; then
  perl -0777 -i -pe 's#<h3>IAM / Federation</h3>#<span class="icon"><img src="{{ '\''/assets/icons/iam.svg'\'' | relative_url }}" alt=""></span>\n        <h3>IAM / Federation</h3>#s' "$HOME"
fi

# Zero Trust for SMB
if ! grep -q "assets/icons/zerotrust.svg" "$HOME"; then
  perl -0777 -i -pe 's#<h3>Zero Trust for SMB</h3>#<span class="icon"><img src="{{ '\''/assets/icons/zerotrust.svg'\'' | relative_url }}" alt=""></span>\n        <h3>Zero Trust for SMB</h3>#s' "$HOME"
fi

# Linux Automation
if ! grep -q "assets/icons/automation.svg" "$HOME"; then
  perl -0777 -i -pe 's#<h3>Linux Automation</h3>#<span class="icon"><img src="{{ '\''/assets/icons/automation.svg'\'' | relative_url }}" alt=""></span>\n        <h3>Linux Automation</h3>#s' "$HOME"
fi

# Cyber × Electrical
if ! grep -q "assets/icons/ot.svg" "$HOME"; then
  perl -0777 -i -pe 's#<h3>Cyber × Electrical</h3>#<span class="icon"><img src="{{ '\''/assets/icons/ot.svg'\'' | relative_url }}" alt=""></span>\n        <h3>Cyber × Electrical</h3>#s' "$HOME"
fi

echo "▶ Add default image fields to featured projects if missing…"
for f in _projects/*.md; do
  [[ -f "$f" ]] || continue
  if ! grep -q '^image:' "$f"; then
    awk '
      BEGIN{infm=0; done=0}
      /^---$/ {print; if(++count==1){infm=1}; next}
      infm==1 && /^title:/ && !done {print; print "image: /assets/img/project-placeholder.jpg"; done=1; next}
      {print}
    ' "$f" > "${f}.tmp" && mv "${f}.tmp" "$f"
  fi
done

echo "▶ Create a generic project/blog placeholder image…"
printf "\x89PNG\r\n\x1a\n" > assets/img/project-placeholder.jpg
printf "\x89PNG\r\n\x1a\n" > assets/img/post-placeholder.jpg

echo "▶ Add placeholder image to latest post if none set…"
latest=$(ls -1 _posts/*.md 2>/dev/null | sort | tail -n1 || true)
if [[ -n "${latest}" ]] && ! grep -q '^image:' "${latest}"; then
  awk '
    BEGIN{in=0; done=0}
    /^---$/ {print; if(++c==1){in=1}; else in=0; next}
    in==1 && !done && /^date:/ {print; print "image: /assets/img/post-placeholder.jpg"; done=1; next}
    {print}
  ' "${latest}" > "${latest}.tmp" && mv "${latest}.tmp" "${latest}"
fi

echo "▶ Git commit…"
git add -A
git commit -m "Visual upgrade: hero background, service icons, cover images for posts/projects, CSS polish" || true
git push || true

echo "✅ Visual upgrade applied."
echo "Next:"
echo "  • Replace assets/img/hero.jpg with a real 1920x1080 photo (keep filename)."
echo "  • Replace project/blog placeholders with real images as you create contenet."