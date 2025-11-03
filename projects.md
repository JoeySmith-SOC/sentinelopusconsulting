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
