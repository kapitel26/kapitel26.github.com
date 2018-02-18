---
layout: page
title: "Änderungen zur 4. Auflage"
author: bst
---

## Neues in der 4. Auflage

Viele Projekte nutzen Git heute auf Plattformen wie **GitHub** oder **Bitbucket**, auf denen mit sogenannten **Pull-Requests** gearbeitet wird.
Dies wird jetzt auch in den beschriebenen Workflows berücksichtigt.
Ein neuer Workflow **»Mit Forks entwickeln«**, der das **Arbeiten in Open-Source-Projekten** wiederspiegelt, wurden hinzugefügt.
Ebenfalls neu ist ein Workflow über **die  LFS-Erweiterung** zur Versionierung großer Binärdateien.

## Abschnitte, die vom Buch ins Blog verschoben wurden

Einige Abschnitte über seltener genutzte Features von Git haben wir aus dem Buch entfernt. Wer sich dennoch für diese Features interessiert findet die Abschnitte jetzt hier im Blog:


{% for tag in site.tags %}
  {% if tag[0] ==  "Änderungen zur 4. Auflage" %}
<table class="table table-striped">
      {% for page in tag[1] %}
        {% assign current_post = page %}
        {% include post_in_a_table_row %}
      {% endfor %}
</table>
  {% endif %}

{% endfor %}
