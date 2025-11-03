---
layout: default
title: "Tag: federation"
permalink: /tag/federation/
---
<section class="container">
  <h1>Tag: federation</h1>
  <ul class="list">
    {% for post in site.posts %}
      {% if post.tags contains "federation" %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <span class="meta">— {{ post.date | date: "%b %d, %Y" }}</span></li>
      {% endif %}
    {% endfor %}
  </ul>
</section>
