---
layout: default
title: "Tag: ot"
permalink: /tag/ot/
---
<section class="container">
  <h1>Tag: ot</h1>
  <ul class="list">
    {% for post in site.posts %}
      {% if post.tags contains "ot" %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <span class="meta">— {{ post.date | date: "%b %d, %Y" }}</span></li>
      {% endif %}
    {% endfor %}
  </ul>
</section>
