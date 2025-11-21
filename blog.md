---
layout: default
title: Blog
permalink: /blog/
description: Notes on identity, Zero Trust, automation, and OT security.
styles:
  - /assets/css/blog.css
---

<main class="blog-page-main">

  <!-- BLOG HERO -->
  <section class="blog-hero">
    <div class="container blog-hero-inner">
      <p class="eyebrow">Blog</p>
      <h1>Deep dives on identity, automation, and OT security</h1>
      <p class="blog-hero-sub">
        Field notes from real-world IAM, Zero Trust, Linux, and SCADA work. No fluff — just patterns,
        postmortems, and guides you can actually use.
      </p>
    </div>
  </section>

  <!-- BLOG LIST -->
  <section class="blog-listing">
    <div class="container">
      <div class="blog-grid">
        {% for post in site.posts %}
        <article class="blog-card">
          <a class="blog-card-link" href="{{ post.url | relative_url }}">
            <div class="blog-card-meta">
              <span class="blog-card-date">
                {{ post.date | date: "%b %-d, %Y" }}
              </span>

              {% if post.tags %}
              <span class="blog-card-tag">
                {{ post.tags | join: ", " }}
              </span>
              {% endif %}
            </div>

            <h3 class="blog-card-title">
              {{ post.title }}
            </h3>

            {% if post.excerpt %}
            <p class="blog-card-excerpt">
              {{ post.excerpt | strip_html | truncate: 180 }}
            </p>
            {% endif %}

            <div class="blog-card-footer">
              <span class="blog-read-more">Read article</span>
              <span class="blog-card-arrow" aria-hidden="true">→</span>
            </div>
          </a>
        </article>
        {% endfor %}
      </div>

      {% if site.posts == empty %}
      <p class="blog-empty">
        No posts yet. I’m probably busy breaking and rebuilding something in a lab.
      </p>
      {% endif %}
    </div>
  </section>

</main>
