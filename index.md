---
layout: page
title: Git - Das sechsundzwanzigste Kapitel
tagline:
---
{% include JB/setup %}

Wenn man ein [Buch](git-buch) schreibt, muss man irgendwann aufhören. 
Schließlich soll das Ganze ja irgendwann gedruckt und verkauft werden. 
Bei unserem Git-Buch, war das nach 25 Kapiteln der Fall.
Mit 25 Kapiteln ist Git aber noch lange nicht erschöpfend behandelt,
es gäbe so viel mehr darüber zu schreiben. Und es gibt noch viel
mehr Themen, die uns beschäftigen, nicht nur Git.
Das **Sechsundzwanzigste Kapitel** steht also für all die Dinge,
über die wir immer schon mal etwas schreiben wollten.
Wir hoffen, dass für Euch (Ihr anonyme Masse da draußen im Internet), 
etwas Interessantes dabei ist:

**[René](/rene)**  & **[Bjørn](/bjoern)** 

Liste aller Beiträge
--------------------

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }} </span><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a> ({{post.author}})</li>
  {% endfor %}
</ul>




