---
layout: default
title: "Tag: freelancing"
permalink: /tag/freelancing/
---
<section class="container">
  <h1>Tag: freelancing</h1>
  <ul class="list">
    {% for post in site.posts %}
      {% if post.tags contains "freelancing" %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <span class="meta">— {{ post.date | date: "%b %d, %Y" }}</span></li>
      {% endif %}
    {% endfor %}
  </ul>
</section>
