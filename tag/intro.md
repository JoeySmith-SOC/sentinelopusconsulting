---
layout: default
title: "Tag: intro"
permalink: /tag/intro/
---
<section class="container">
  <h1>Tag: intro</h1>
  <ul class="list">
    {% for post in site.posts %}
      {% if post.tags contains "intro" %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <span class="meta">— {{ post.date | date: "%b %d, %Y" }}</span></li>
      {% endif %}
    {% endfor %}
  </ul>
</section>
