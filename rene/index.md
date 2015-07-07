---
layout: page
title: "René"
description: ""
group: navigation
weight: 9
---

![René Preißel](rene-preissel.jpg)

**René Preißel** arbeitet als freiberuflicher Softwarearchitekt,
Entwickler und Trainer.
Er beschäftigt sich seit vielen Jahren mit der Entwicklung
objektorientierter Anwendungen und Frameworks.
Seine Schwerpunkte liegen im Bereich Architektur, Java EE
und Konfigurationsmanagement.
Mehr Informationen gibt es auf [eToSquare.de](http://www.eToSquare.de)

Meine Beiträge
--------------

<ul class="posts">
  {% for post in site.posts %}
  	{% if post.author == "rp" %}
	    <li><span>{{ post.date | date_to_string }} </span><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a> ({{post.author}})</li>
	{% endif %}
  {% endfor %}
</ul>
