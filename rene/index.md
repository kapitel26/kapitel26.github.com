---
layout: page
title: "René"
author: rp
background: '/assets/decoration/sea3.jpg'
---

René Preißel
------------

![René Preißel](rene.jpg)

**René Preißel** arbeitet als freiberuflicher Softwarearchitekt,
Entwickler und Trainer.
Er beschäftigt sich seit vielen Jahren mit der Entwicklung
objektorientierter Anwendungen und Frameworks.
Seine Schwerpunkte liegen im Bereich Architektur, Java EE
und Konfigurationsmanagement.
Mehr Informationen gibt es auf [eToSquare.de](http://www.eToSquare.de)

Meine Beiträge
--------------

<table class="table table-striped">
  {% for post in site.posts %}
    {% if post.author == "rp" %}
      {% assign current_post = post %}
      {% include post_in_a_table_row %}
    {% endif %}
  {% endfor %}
</table>
