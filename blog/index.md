---
layout: page
title: Blog
permalink: /blog/
---

<ul class="posts">
{% for post in site.posts %}
  <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    <span class="meta"> — {{ post.date | date: "%b %d, %Y" }}</span></li>
{% endfor %}
</ul>
