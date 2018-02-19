---
layout: page
---

# Hier kommt er überblick hin

<table class="table table-striped">
  {% for post in site.posts %}
    {% assign current_post = post %}
    {% include post_in_a_table_row %}
  {% endfor %}
</table>
