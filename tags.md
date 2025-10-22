---
layout: page
title: Tags
permalink: /tags/
---
<h2>All Tags</h2>
<ul>
{% assign tags = site.tags | sort %}
{% for tag in tags %}
  <li id="{{ tag[0] | slugize }}"><strong>{{ tag[0] }}</strong> ({{ tag[1].size }})</li>
{% endfor %}
</ul>
