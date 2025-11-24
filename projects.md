---
layout: default
title: Identity, Zero Trust, Linux & OT Security Projects | Sentinel Opus
permalink: /projects/
description: Selected builds and lab work showing identity, automation, and OT security in practice.
---
<section class="container">
  <h1>Projects</h1>
  <p class="lead">Built for engineering managers and security leads who want to see the patterns before we deploy them in your environment.</p>
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
          <p class="project-meta-label">Lab Environment / Reference Architecture</p>
          {%- if p.short -%}<p class="project-desc">{{ p.short }}</p>{%- endif -%}
          {%- if p.tags -%}
          <ul class="project-tags">
            {%- for t in p.tags -%}<li>{{ t }}</li>{%- endfor -%}
          </ul>
          {%- endif -%}
          <p class="project-helper">Want this pattern in your environment? See <a href="{{ '/services/' | relative_url }}">Services</a>.</p>
          <a class="btn project-link" href="{{ p.url | relative_url }}">View project</a>
        </div>
      </article>
    {%- endfor -%}
  </div>
</section>
