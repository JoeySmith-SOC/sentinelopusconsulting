#!/usr/bin/env bash
set -euo pipefail

# ===== CONFIG =====
REPO_ROOT="$(pwd)"
REQ_FILES="_config.yml"
NOW="$(date +%Y%m%d-%H%M%S)"

say() { printf "\n\033[1;32m▶ %s\033[0m\n" "$*"; }
warn() { printf "\n\033[1;33m⚠ %s\033[0m\n" "$*"; }
die() { printf "\n\033[1;31m✖ %s\033[0m\n" "$*"; exit 1; }

# ===== GUARDS =====
for f in $REQ_FILES; do
  [[ -f "$f" ]] || die "Run this from your Jekyll repo root. Missing: $f"
done

# Git backup branch
say "Creating backup branch goldenize-$NOW"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Not a git repo."
git checkout -b "goldenize-$NOW" || git checkout -B "goldenize-$NOW"

# ===== DIRECTORIES =====
say "Ensuring standard directories exist"
mkdir -p assets/img/projects assets/img posts _posts _layouts _includes _data tag assets/video assets/css

# ===== PLACEHOLDER IMAGES =====
say "Writing placeholder project images"
# Tiny PNG headers (just placeholders; replace later)
for name in placeholder-cf-zerotrust placeholder-okta-federation placeholder-scada-lab placeholder-operator-automation placeholder-smart-electric placeholder-identity-lab about-placeholder project-placeholder post-placeholder; do
  printf "\x89PNG\r\n\x1a\n" > "assets/img/projects/${name}.png"
done

# ===== CONFIG BASELINES =====
say "Updating _config.yml with sensible defaults (no destructive overwrite)"
if ! grep -q '^title:' _config.yml;          then echo "title: Sentinel Opus Consulting" >> _config.yml; fi
if ! grep -q '^description:' _config.yml;    then echo "description: Operator-grade identity, automation, and OT security." >> _config.yml; fi
if ! grep -q '^url:' _config.yml;            then echo "url: https://sentinelopusconsulting.com" >> _config.yml; fi
if ! grep -q '^timezone:' _config.yml;       then echo "timezone: America/Chicago" >> _config.yml; fi
if ! grep -q '^collections:' _config.yml;    then printf "collections:\n  projects:\n    output: true\n" >> _config.yml; fi
if ! grep -q '^markdown:' _config.yml;       then echo "markdown: kramdown" >> _config.yml; fi
if ! grep -q '^highlighter:' _config.yml;    then echo "highlighter: rouge" >> _config.yml; fi
if ! grep -q '^sass:' _config.yml;           then printf "sass:\n  style: compressed\n" >> _config.yml; fi
# analytics hook (optional)
if ! grep -q '^analytics_id:' _config.yml;   then echo "analytics_id: \"\"" >> _config.yml; fi

# ===== DATA: HERO MEDIA =====
say "Ensuring _data/media.yml has hero video mapping"
mkdir -p _data
if [[ ! -f _data/media.yml && ! -f _data/media.yaml ]]; then
  cat > _data/media.yml <<'YML'
hero:
  video: /assets/video/hero_video_background.mp4
  video_webm:
  poster:
  overlay: rgba(0,0,0,0.55)
YML
fi

# ===== SEO HEAD INCLUDE =====
say "Adding SEO head include with OG/Twitter/JSON-LD"
mkdir -p _includes
cat > _includes/head-seo.html <<'HTML'
{%- assign page_title = page.title | default: site.title -%}
{%- assign page_desc  = page.description | default: site.description -%}
{%- assign page_url   = page.url | absolute_url -%}
{%- assign page_img   = page.image | default: '/assets/img/projects/post-placeholder.png' | absolute_url -%}
{%- assign is_post    = page.date -%}

<title>{{ page_title }}</title>
<meta name="description" content="{{ page_desc | strip_newlines | truncate: 160 }}">
<link rel="canonical" href="{{ page_url }}">

<!-- OpenGraph -->
<meta property="og:type" content="{{ is_post | default: false | ternary: 'article','website' }}">
<meta property="og:title" content="{{ page_title }}">
<meta property="og:description" content="{{ page_desc | strip_newlines | truncate: 200 }}">
<meta property="og:url" content="{{ page_url }}">
<meta property="og:image" content="{{ page_img }}">

<!-- Twitter -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{{ page_title }}">
<meta name="twitter:description" content="{{ page_desc | strip_newlines | truncate: 200 }}">
<meta name="twitter:image" content="{{ page_img }}">

<!-- JSON-LD -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "{{ is_post | default: false | ternary: 'Article', 'Person' }}",
  {{ is_post | default: false | ternary:
    '"headline": "' | append: page_title | append: '", "datePublished": "' | append: page.date | date: "%Y-%m-%d" | append: '", "image": "' | append: page_img | append: '", "author": {"@type": "Person", "name": "Joseph Smith"}'
    ,
    '"name": "Joseph Smith", "jobTitle": "Identity & Automation Engineer", "url": "' | append: site.url | append: '"' }}
}
</script>

{% if site.analytics_id and site.analytics_id != "" %}
<!-- Analytics (Plausible or GA4; swap snippet as needed) -->
<script defer data-domain="sentinelopusconsulting.com" src="https://plausible.io/js/script.js"></script>
{% endif %}
HTML

# ===== DEFAULT LAYOUT: inject SEO include =====
say "Ensuring _layouts/default.html includes head-seo.html"
mkdir -p _layouts
if [[ ! -f _layouts/default.html ]]; then
  cat > _layouts/default.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
  <head>
    {%- include head-seo.html -%}
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="{{ '/assets/css/main.css' | relative_url }}" rel="stylesheet">
  </head>
  <body class="{{ site.theme_mode | default: 'dark' }}">
    {% include header.html %}
    <main>{{ content }}</main>
    {% include footer.html %}
  </body>
</html>
HTML
else
  # Insert include if missing
  if ! grep -q 'include head-seo.html' _layouts/default.html; then
    sed -i '0,/<head>/! b; /<head>/a\    {%- include head-seo.html -%}' _layouts/default.html
  fi
fi

# ===== HOME LAYOUT: clean, single source of truth =====
say "Replacing _layouts/home.html with the consolidated, optimized version"
cat > _layouts/home.html <<'HTML'
---
layout: default
---
<!-- HERO (video background) -->
<section class="hero hero-video">
  <div class="hero-media">
    {% assign hero = site.data.media.hero %}
    <video class="hero-video-el" autoplay muted loop playsinline preload="metadata"
      {% if hero.poster %}poster="{{ hero.poster | relative_url }}"{% endif %} aria-hidden="true">
      {% if hero.video_webm %}<source src="{{ hero.video_webm | relative_url }}" type="video/webm">{% endif %}
      <source src="{{ hero.video | relative_url }}" type="video/mp4">
      Your browser does not support the video tag.
    </video>
    <div class="hero-overlay" style="background: {{ hero.overlay | default: 'rgba(0,0,0,0.55)' }}"></div>
  </div>

  <div class="container hero-inner">
    <div class="hero-grid">
      <div class="hero-left">
        <h1>Identity, Automation, and IT/OT <span class="accent-highlight">Security</span></h1>
        <p class="sub">I help teams secure what matters—reliably, transparently, and without slowing you down.</p>
        <div class="cta-row">
          <a class="btn primary" href="{{ '/contact/' | relative_url }}">Book a consult</a>
          <a class="btn" href="{{ '/projects/' | relative_url }}">See projects</a>
        </div>
        <ul class="cred cred-bar feature-list" aria-label="Key capabilities">
          <li><strong>Okta</strong> | SAML/OIDC | Lifecycle</li>
          <li><strong>Cloudflare</strong> | Zero Trust</li>
          <li><strong>Linux</strong> | Ansible | Terraform</li>
          <li><strong>OT/Electrical</strong> | Segmentation | Safety</li>
        </ul>
      </div>
      <div class="hero-right"></div>
    </div>
  </div>
</section>

<!-- WHAT I DO -->
<section class="what-i-do">
  <div class="container">
    <h2 class="section-title">What I Do</h2>
    <p class="section-sub">I engineer, automate, and secure digital and physical infrastructure — bridging cybersecurity, identity, and operational technology.</p>

    <div class="expertise-grid two-col">
      <article class="card">
        <div class="icon-top"><img src="/assets/icons/user-shield.svg" alt=""></div>
        <h3>Identity &amp; Access Management</h3>
        <p>Okta/AD federation, lifecycle automation, access governance, and auth workflows that integrate cleanly with infrastructure.</p>
        <a href="/projects/" class="card-link">Learn more →</a>
      </article>
      <article class="card">
        <div class="icon-top"><img src="/assets/icons/cloud-lock.svg" alt=""></div>
        <h3>Zero Trust Architecture</h3>
        <p>Cloudflare Access, device posture, certificate-based auth, and least-privilege policy — without user friction.</p>
        <a href="/projects/" class="card-link">Learn more →</a>
      </article>
      <article class="card">
        <div class="icon-top"><img src="/assets/icons/automation.svg" alt=""></div>
        <h3>Infrastructure &amp; Automation</h3>
        <p>Ansible/Terraform pipelines, hardened baselines, and versioned environments aligned to DevSecOps.</p>
        <a href="/projects/" class="card-link">Learn more →</a>
      </article>
      <article class="card">
        <div class="icon-top"><img src="/assets/icons/lock-bolt.svg" alt=""></div>
        <h3>Operational Technology &amp; Electrical</h3>
        <p>ICS segmentation, PLC/HMI security, monitoring, and safety-first designs bridging code and current.</p>
        <a href="/projects/" class="card-link">Learn more →</a>
      </article>
    </div>
  </div>
</section>

<!-- FLAGSHIP PROJECTS (2x3) -->
<section class="projects" aria-labelledby="projects-title">
  <div class="container">
    <h2 id="projects-title" class="section-title">Operator-Grade Engineering</h2>
    <p class="section-sub">From identity architecture to OT security, each build reflects disciplined execution — combining automation, Zero Trust, and hands-on infrastructure design.</p>

    <div class="project-grid">
      {%- assign picks = site.projects | where_exp: 'p','p.featured == true' -%}
      {%- assign ordered = picks | sort: 'date' | reverse -%}
      {%- assign displayed = ordered | slice: 0, 6 -%}
      {%- for p in displayed -%}
      <article class="project-card">
        <a href="{{ p.url | relative_url }}" class="project-media" aria-label="{{ p.title }}">
          {%- if p.image -%}
            <img src="{{ p.image | relative_url }}" alt="{{ p.title }}" loading="lazy" decoding="async">
          {%- else -%}
            <div class="project-placeholder" aria-hidden="true">Project</div>
          {%- endif -%}
        </a>
        <div class="project-body">
          <h3><a href="{{ p.url | relative_url }}">{{ p.title }}</a></h3>
          {%- if p.short -%}<p class="project-desc">{{ p.short }}</p>{%- elsif p.description -%}<p class="project-desc">{{ p.description }}</p>{%- endif -%}
          {%- if p.tags -%}
          <ul class="project-tags" aria-label="Project tags">
            {%- for t in p.tags -%}<li>{{ t }}</li>{%- endfor -%}
          </ul>
          {%- endif -%}
          <a class="btn project-link" href="{{ p.url | relative_url }}">View project</a>
        </div>
      </article>
      {%- endfor -%}
    </div>
  </div>
</section>
HTML

# ===== PROJECT & POST LAYOUTS =====
say "Ensuring post and project layouts support cover images + clean content"
cat > _layouts/post.html <<'HTML'
---
layout: default
---
<article class="post">
  <header class="container">
    <h1>{{ page.title }}</h1>
    <p class="muted">{{ page.date | date: "%B %d, %Y" }}{% if page.tags %} • {{ page.tags | join: ", " }}{% endif %}</p>
    {% if page.image %}<img class="cover" src="{{ page.image | relative_url }}" alt="">{% endif %}
  </header>
  <div class="container">
    {{ content }}
  </div>
</article>
HTML

cat > _layouts/project.html <<'HTML'
---
layout: default
---
<article class="project">
  <header class="container">
    <h1>{{ page.title }}</h1>
    {% if page.image %}<img class="project-cover" src="{{ page.image | relative_url }}" alt="">{% endif %}
    {% if page.short %}<p class="muted">{{ page.short }}</p>{% endif %}
  </header>
  <div class="container">
    {{ content }}
    {% if page.stack %}
      <h3>Tech Stack</h3>
      <p>{{ page.stack }}</p>
    {% endif %}
    {% if page.links and page.links.repo %}
      <p><a class="btn" href="{{ page.links.repo }}">View repository →</a></p>
    {% endif %}
  </div>
</article>
HTML

# ===== PROJECTS INDEX (fix /projects/ 404) =====
say "Creating /projects/ index page"
cat > projects.md <<'MD'
---
layout: default
title: Projects
permalink: /projects/
description: Selected builds and lab work showing identity, automation, and OT security in practice.
---
<section class="container">
  <h1>Projects</h1>
  <div class="project-grid">
    {%- assign picks = site.projects | sort: 'date' | reverse -%}
    {%- for p in picks -%}
      <article class="project-card">
        <a href="{{ p.url | relative_url }}" class="project-media" aria-label="{{ p.title }}">
          {%- if p.image -%}
            <img src="{{ p.image | relative_url }}" alt="{{ p.title }}" loading="lazy" decoding="async">
          {%- else -%}
            <div class="project-placeholder" aria-hidden="true">Project</div>
          {%- endif -%}
        </a>
        <div class="project-body">
          <h3><a href="{{ p.url | relative_url }}">{{ p.title }}</a></h3>
          {%- if p.short -%}<p class="project-desc">{{ p.short }}</p>{%- endif -%}
          {%- if p.tags -%}
          <ul class="project-tags">
            {%- for t in p.tags -%}<li>{{ t }}</li>{%- endfor -%}
          </ul>
          {%- endif -%}
          <a class="btn project-link" href="{{ p.url | relative_url }}">View project</a>
        </div>
      </article>
    {%- endfor -%}
  </div>
</section>
MD

# ===== CONTACT PAGE (working form placeholder) =====
say "Overwriting contact page with a working HTML form (replace endpoint later)"
mkdir -p contact
cat > contact/index.md <<'MD'
---
layout: default
title: Contact
permalink: /contact/
description: Start a secure implementation, advisory sprint, or retainer — let’s talk.
---
<section class="container">
  <h1>Contact</h1>
  <p class="muted">Prefer email? <a href="mailto:joeysmith@sentinelopusconsulting.com">joeysmith@sentinelopusconsulting.com</a></p>

  <form class="contact-form" method="POST" action="https://api.formspree.io/f/YOUR_ID_HERE">
    <input type="hidden" name="_subject" value="New inquiry from sentinelopusconsulting.com">
    <div class="row">
      <label>Name <input type="text" name="name" required></label>
      <label>Email <input type="email" name="email" required></label>
    </div>
    <label>Company <input type="text" name="company"></label>
    <label>Message <textarea name="message" rows="6" required placeholder="Tell me what you’re trying to achieve…"></textarea></label>
    <input type="text" name="_gotcha" style="display:none">
    <button class="btn primary" type="submit">Send</button>
  </form>
</section>
MD

# ===== BLOG INDEX (clean, no filename leaks) =====
say "Adding simple blog index page"
cat > blog.md <<'MD'
---
layout: default
title: Blog
permalink: /blog/
description: Notes on identity, Zero Trust, automation, and OT security.
---
<section class="container">
  <h1>Blog</h1>
  <ul class="list">
    {% for post in site.posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span class="meta"> — {{ post.date | date: "%b %d, %Y" }}</span>
      {% if post.tags %}<span class="meta"> • {{ post.tags | join: ", " }}</span>{% endif %}
    </li>
    {% endfor %}
  </ul>
</section>
MD

# ===== TAG PAGES (no plugins) =====
say "Generating static tag pages from existing posts"
TAGS_DIR="tag"
mkdir -p "$TAGS_DIR"
# collect tags
TAGS=$(grep -hr '^tags:' _posts 2>/dev/null | sed 's/^tags: *//g' | tr -d '[],' | tr ' ' '\n' | sed '/^$/d' | sort -u || true)
if [[ -n "${TAGS}" ]]; then
  for t in $TAGS; do
    slug="$(echo "$t" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')"
    cat > "$TAGS_DIR/${slug}.md" <<EOF
---
layout: default
title: "Tag: ${t}"
permalink: /tag/${slug}/
---
<section class="container">
  <h1>Tag: ${t}</h1>
  <ul class="list">
    {% for post in site.posts %}
      {% if post.tags contains "${t}" %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <span class="meta">— {{ post.date | date: "%b %d, %Y" }}</span></li>
      {% endif %}
    {% endfor %}
  </ul>
</section>
EOF
  done
fi

# ===== SITEMAP & ROBOTS =====
say "Adding sitemap.xml and robots.txt"
cat > sitemap.xml <<'XML'
---
layout: null
permalink: /sitemap.xml
---
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  {% for page in site.pages %}
    {% unless page.sitemap == false or page.url contains 'assets' %}
      <url><loc>{{ page.url | absolute_url }}</loc></url>
    {% endunless %}
  {% endfor %}
  {% for post in site.posts %}
    <url><loc>{{ post.url | absolute_url }}</loc></url>
  {% endfor %}
</urlset>
XML

cat > robots.txt <<'TXT'
User-agent: *
Allow: /
Sitemap: {{ "/sitemap.xml" | absolute_url }}
TXT

# ===== CSS (cleaned & patched) =====
say "Patching/creating assets/css/main.css"
mkdir -p assets/css
cat > assets/css/main.css <<'CSS'
/* Core tokens */
:root{--bg:#0b0e10;--text:#e6e6e6;--muted:#9aa3ab;--card:#12161a;--accent:#f0b400;--accent-2:#394c3f;}
:root.light{--bg:#fff;--text:#222;--muted:#5b6b73;--card:#f7f7f9;--accent:#bf8a00;--accent-2:#2f5d3f;}
html,body{margin:0;padding:0;background:var(--bg);color:var(--text);font-family:'Open Sans',system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;}
.container{max-width:1200px;margin:0 auto;padding:1.25rem;} @media(min-width:1400px){.container{max-width:1400px;}}

/* Buttons */
.btn{display:inline-block;border:1px solid var(--muted);padding:.65rem 1rem;border-radius:15px;text-decoration:none;color:var(--text);margin-right:.6rem;}
.btn.primary{border-color:var(--accent);background:var(--accent);color:#000;font-weight:700;}

/* HERO (video) */
.hero-video{position:relative;width:100vw;left:50%;margin-left:-50vw;margin-right:-50vw;overflow:hidden;min-height:100vh;padding:0;}
.hero-video .hero-media{position:absolute;inset:0;z-index:0;}
.hero-video .hero-video-el{position:absolute;top:50%;left:50%;min-width:100%;min-height:100%;transform:translate(-50%,-50%);object-fit:cover;filter:saturate(1.05) contrast(1.05);}
.hero-video .hero-overlay{position:absolute;inset:0;pointer-events:none;}
.hero .container.hero-inner{max-width:1400px;padding:0 3rem;min-height:80vh;display:flex;align-items:center;}
.hero-grid{display:grid;grid-template-columns:1.3fr .7fr;gap:2.5rem;align-items:center;} @media(max-width:980px){.hero-grid{grid-template-columns:1fr;gap:1.5rem;}.hero .container.hero-inner{padding:0 1.25rem;min-height:70vh;}}
.hero-left h1{font-family:Oswald,Impact,system-ui,sans-serif;font-size:clamp(3rem,6vw,5.25rem);line-height:1.04;letter-spacing:-.02em;font-weight:800;margin:0 0 1rem;}
.accent-highlight{position:relative;color:var(--accent);white-space:nowrap;display:inline-block;z-index:1;}
.accent-highlight::after{content:"";position:absolute;left:-6%;right:-6%;bottom:-.1em;height:.45em;background:radial-gradient(ellipse at center,rgba(240,180,0,.35),rgba(240,180,0,.15));border-radius:999px;z-index:-1;filter:blur(1px);}
.hero .sub,.hero h1,.hero h2,.hero p,.hero a,.hero li{color:#fff!important;}

/* WHAT I DO */
.what-i-do{background:linear-gradient(180deg,#101216 0%,#181b20 100%);padding:7rem 0;position:relative;z-index:2;}
:root.light .what-i-do{background:linear-gradient(180deg,#f9f9fb 0%,#eceef1 100%);}
.section-title{text-align:center;font-size:2.2rem;font-weight:800;color:var(--accent);margin:0 0 1rem;}
.section-sub{text-align:center;color:#cfcfcf;font-size:1.05rem;max-width:780px;margin:0 auto 3.2rem;line-height:1.6;}
.expertise-grid.two-col{display:grid;grid-template-columns:repeat(2,minmax(280px,1fr));gap:2rem;max-width:1100px;margin:0 auto;}
@media(max-width:860px){.expertise-grid.two-col{grid-template-columns:1fr;}}
.expertise-grid .card{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.08);border-radius:16px;padding:2rem;text-align:center;transition:transform .25s ease,box-shadow .25s ease,border-color .25s ease;box-shadow:0 0 12px rgba(0,0,0,.18);}
.expertise-grid .card:hover{transform:translateY(-6px);border-color:var(--accent);box-shadow:0 12px 28px rgba(240,180,0,.14);}
.icon-top{width:64px;height:64px;margin:0 auto 1rem;border-radius:14px;display:grid;place-items:center;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.10);}
.icon-top img{width:40px;height:40px;filter:brightness(1.2);opacity:.9;}
.expertise-grid h3{margin:.5rem 0 .75rem;color:var(--accent);font-weight:700;font-size:1.2rem;}
.expertise-grid p{color:#d8d8d8;line-height:1.6;font-size:1.04rem;}
:root.light .expertise-grid .card{background:#fff;border:1px solid rgba(0,0,0,.08);box-shadow:0 2px 12px rgba(0,0,0,.08);}
:root.light .expertise-grid p{color:#333;}

/* PROJECTS grid (2x3 desktop) */
.projects{background:linear-gradient(180deg,#0f1013 0%,#121419 100%);padding:7rem 0;position:relative;z-index:2;}
.projects .section-title,.projects .section-sub,.projects .project-card,.projects .project-card h3 a,.projects .project-card p,.projects .project-card li,.projects .btn.project-link{color:#fff;}
.project-grid{display:grid;grid-template-columns:repeat(3,1fr);grid-template-rows:repeat(2,auto);gap:2rem;margin-top:2rem;}
@media(max-width:1024px){.project-grid{grid-template-columns:repeat(2,1fr);}}
@media(max-width:700px){.project-grid{grid-template-columns:1fr;}}
.project-card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.08);border-radius:16px;overflow:hidden;display:flex;flex-direction:column;transition:transform .25s ease,box-shadow .25s ease,border-color .25s ease;box-shadow:0 0 14px rgba(0,0,0,.18);}
.project-card:hover{transform:translateY(-6px);border-color:var(--accent);box-shadow:0 12px 28px rgba(240,180,0,.14);}
.project-media img,.project-placeholder{display:block;width:100%;height:220px;object-fit:cover;background:#0f0f12;}
.project-body{padding:1.25rem 1.25rem 1.5rem;display:flex;flex-direction:column;gap:.6rem;}
.project-desc{color:#eaeaea;line-height:1.6;}
.project-tags{list-style:none;padding:0;margin:.25rem 0 .5rem;display:flex;flex-wrap:wrap;gap:.4rem;}
.project-tags li{font-size:.85rem;color:#fff;background:rgba(240,180,0,.12);border:1px solid rgba(240,180,0,.25);padding:.2rem .5rem;border-radius:999px;}
.projects .btn.project-link{border:1px solid #fff;background:transparent;color:#fff;font-weight:600;letter-spacing:.02em;transition:all .25s ease;}
.projects .btn.project-link:hover{background:var(--accent);border-color:var(--accent);color:#000;box-shadow:0 0 15px rgba(240,180,0,.4);}

/* Post/Project cover images */
.cover,.project-cover{width:100%;height:260px;object-fit:cover;border-radius:12px;margin:.6rem 0 1rem;border:1px solid rgba(255,255,255,.06);background:var(--card);}

/* Contact form */
.contact-form{max-width:780px;margin-top:1rem;}
.contact-form .row{display:grid;grid-template-columns:1fr 1fr;gap:1rem;}
@media(max-width:720px){.contact-form .row{grid-template-columns:1fr;}}
.contact-form label{display:block;margin:.4rem 0 .8rem;}
.contact-form input,.contact-form textarea{width:100%;padding:.7rem .8rem;border-radius:12px;border:1px solid rgba(255,255,255,.12);background:rgba(255,255,255,.04);color:var(--text);}
:root.light .contact-form input,:root.light .contact-form textarea{border-color:rgba(0,0,0,.15);background:#fff;color:#222;}
CSS

# ===== CLEAN DUPLICATE "Flagship Projects" SECTIONS IN HOME PAGES =====
# We replaced _layouts/home.html above, but if some sites use index.md with home content, ensure it points to layout: home
say "Ensuring homepage front matter uses home layout (if index.md exists)"
if [[ -f index.md ]]; then
  if ! grep -q '^layout: home' index.md; then
    sed -i '0,/^layout: .*/s//layout: home/' index.md || true
  fi
fi

# ===== GIT COMMIT =====
say "Committing changes"
git add -A
git commit -m "Gold-standard pass: layouts, SEO, projects index, tags, contact form, CSS, sitemap, robots, placeholders" || true

say "All set. Next steps:"
echo "1) Replace the form endpoint in contact/index.md (Formspree/Formspark/Cloudflare)."
echo "2) Place your real hero video at assets/video/hero_video_background.mp4 (or update _data/media.yml)."
echo "3) Swap placeholder images in assets/img/projects/*.png with your real art."
echo "4) Ensure your 6 flagship _projects/*.md have: featured: true and proper 'image:' paths."
echo "5) Push: git push --set-upstream origin goldenize-$NOW  (PR → main)."
