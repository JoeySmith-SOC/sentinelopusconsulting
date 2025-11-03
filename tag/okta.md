---
layout: default
title: "Tag: okta"
permalink: /tag/okta/
---
<section class="container">
  <h1>Tag: okta</h1>
  <ul class="list">
    {% for post in site.posts %}
      {% if post.tags contains "okta" %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <span class="meta">— {{ post.date | date: "%b %d, %Y" }}</span></li>
      {% endif %}
    {% endfor %}
  </ul>
</section>
