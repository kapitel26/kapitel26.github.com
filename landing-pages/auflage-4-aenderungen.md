---
layout: page
title: "Änderungen zur 4. Auflage"
author: bst
---



Abschnitte und Kapitel, die ins Blog verschoben wurden
------------------------------------------------------




{% for tag in site.tags %}
  {% if tag[0] ==  "Änderungen zur 4. Auflage" %}
<h2 id="{{ tag[0] }}-ref">{{ tag[0] }}</h2>
<table class="table table-striped">
      {% for page in tag[1] %}
        {% assign current_post = page %}
        {% include post_in_a_table_row %}
      {% endfor %}
</table>
  {% endif %}

{% endfor %}
