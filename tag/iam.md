---
layout: default
title: "Tag: iam"
permalink: /tag/iam/
---
<section class="container">
  <h1>Tag: iam</h1>
  <ul class="list">
    {% for post in site.posts %}
      {% if post.tags contains "iam" %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <span class="meta">— {{ post.date | date: "%b %d, %Y" }}</span></li>
      {% endif %}
    {% endfor %}
  </ul>
</section>
