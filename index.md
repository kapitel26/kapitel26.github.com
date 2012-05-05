---
layout: page
title: Git - Das sechsundzwanzigste Kapitel
tagline: Dezentrale Versionsverwaltung mit Git (oder Mercurial)
---
{% include JB/setup %}


Here's a sample "posts list".

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>



