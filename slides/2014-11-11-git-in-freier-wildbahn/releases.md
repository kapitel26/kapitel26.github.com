___SECTION_______________________________


  <aside class="notes">
  Erläuterungen
  </aside>

# Releasen






_________________________________________


  <aside class="notes">
  Frage-Folie
  </aside>

Staging-Branches
================




_________________________________________


  <aside class="notes">
  </aside>

## Zum Beispiel, so wie es das Gitflow-Modell vorgibt

![Staging](staging-branches.png)



_________________________________________


  <aside class="notes">
  </aside>

### Je nach Anforderung

* Nachvollziehbarkeit von Auslieferungen
* Kontrollierte Hotfixes
* QA-Prozesse mit mehreren Staging-Umgebungen
* Systematische Reviews
* Genaue Kontrolle, wann was "rausgeht"
* Mehrere Versionen (Nachvollziehbarkeit, Backports)


### kann es auch ein klein wenig komplexer werden ...





_________________________________________


  <aside class="notes">
  Ergebnis-Folie
  </aside>

<table cellspacing="15">
  <tr bgcolor="yellow">
    <th>&nbsp;Staging Branches</th>
    <th>&nbsp;Nur der Master</th>
  </tr>
  <tr>
    <td>
      {% include_relative unternehmen/c.html %}<br/>
      {% include_relative unternehmen/d.html %}<br/>
      {% include_relative unternehmen/n.html %}
    </td>
    <td>
      {% include_relative unternehmen/a.html %}<br/>
      {% include_relative unternehmen/h.html %}<br/>
      {% include_relative unternehmen/l.html %}<br/>
      {% include_relative unternehmen/m.html %}
    </td>
</table>






_________________________________________


  <aside class="notes">
  </aside>

### Ein Branching-Modell kann einfach sein






_________________________________________


  <aside class="notes">
  Fallbeispiel

  Anmerkung: Selbst die haben inzwischen ein paar Projekte mit `test`- und `stable`-Branches.
  </aside>

### Unternehmen: {% include_relative unternehmen/a.html %}

{% include_relative unternehmen/a-details.html %}


## Nur `master`

Alle Projekte haben nur ein aktives Release. Erweiterungen und Bugfixes werden auf dem `master` erstellt und schnell ausgerollt.






_________________________________________


  <aside class="notes">
  Fallbeispiel

  Anmerkung: Selbst die haben inzwischen ein paar Projekte mit `test`- und `stable`-Branches.
  </aside>

### Unternehmen: {% include_relative unternehmen/d.html %}

{% include_relative unternehmen/d-details.html %}

## Branching-Modell

Je Modul wird parallel ein aktives Release gepflegt, das nächste Release vorbereitet, und für nachfolgende Release weiter entwickelt.

 * `master` teaminterne Integration
 * `dev` teamübergreifende Freigabe
 * `int` Vorbereitung für das nächste Release
 * `prod` for das aktive Release
 * `bugfix` geplante Bugfixes
 * `hotfix` schnelle Bugfixes




_________________________________________


  <aside class="notes">
  Frage-Folie

  Es wäre machbar für unterschiedliche Stages mit verschiedenen Repos zu arbeiten. Das scheint aber keiner zu machen. Wahrscheinlich genügen Branches und Tags.

  TODO wenn man github macht, könne Entwickler forken. machen die das auch in Unternehmen?
  </aside>

Repo per Stage?
===============

Ist uns bisher nicht über den Weg gelaufen.




_________________________________________


  <aside class="notes">
  Erläuterungen
  </aside>

Bauen?
======






_________________________________________


  <aside class="notes">
  Erläuterungen
  </aside>


Jenkins!
--------







_________________________________________
<!--

  <aside class="notes">
  Erläuterungen
  </aside>

Deployment
==========

Was wird released?

Wie wir es ausgerollt?


-->
