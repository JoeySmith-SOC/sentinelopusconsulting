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
