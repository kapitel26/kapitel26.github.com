___SECTION_______________________________


  <aside class="notes">
  Erläuterungen
  </aside>

Entwickeln
==========






_________________________________________


  <aside class="notes">
  Frage-Folie
  </aside>

To branch<br/>or<br/>not to branch?
==================================






_________________________________________


  <aside class="notes">
  Ergebnis-Folie
  </aside>

<table cellspacing="15">
  <tr bgcolor="yellow">
    <th colspan="2">&nbsp;Feature-Branches</th>
  </tr>
  <tr bgcolor="yellow">
    <th>&nbsp;immer</th>
    <th>&nbsp;nie</th>
  </tr>
  <tr>
    <td>
      {% include_relative unternehmen/c.html %}<br/>
      {% include_relative unternehmen/d.html %}<br/>
      {% include_relative unternehmen/f.html %}<br/>
      {% include_relative unternehmen/j.html %}<br/>
      {% include_relative unternehmen/l.html %}<br/>
      {% include_relative unternehmen/m.html %}<br/>
      {% include_relative unternehmen/n.html %}
    </td>
    <td>
      {% include_relative unternehmen/a.html %}<br/>
      {% include_relative unternehmen/k.html %}
    </td>
  </tr>
  <tr bgcolor="yellow">
    <th>&nbsp;manchmal</th>
  </tr>
  <tr>
    <td>
      {% include_relative unternehmen/b.html %}<br/>
      {% include_relative unternehmen/i.html %}
    </td>
  </tr>

</table>






_________________________________________


  <aside class="notes">
  Fallbeispiel
  </aside>

### Unternehmen: {% include_relative unternehmen/a.html %}

{% include_relative unternehmen/a-details.html %}

## Entscheidung: Entwickeln auf einem Branch

* Keine featureorientierte QA
* Kein Issue-Tracking
* Versionsverwaltung nur als Backup und zur Revision






_________________________________________


  <aside class="notes">
  Fallbeispiel
  </aside>

### Unternehmen: {% include_relative unternehmen/d.html %}

{% include_relative unternehmen/d-details.html %}

## Entscheidung: Feature-Branches

 * Eigenes komplexes Reporting ermöglicht Überblick, welche Änderungen für ein Release integriert wurden.
 * Statische Code-Analyse und Peer-Review vor dem Merge
 * Eclipse-basiertes Tooling erleichert Entwicklern den Feature-Workflow.




_________________________________________


  <aside class="notes">
  Fallbeispiel
  </aside>

### Unternehmen: {% include_relative unternehmen/f.html %}

{% include_relative unternehmen/f-details.html %}

## Entscheidung: Feature Branches

Rechtliche Vorgaben für Code-Reviews und Tracking der Änderungen, weil die Feature-Branches gut kontrollierbare Einheiten bilden.






_________________________________________


  <aside class="notes">
  Frage-Folie
  </aside>

Merge<br/>oder<br/>Rebase?
==========================


_________________________________________


  <aside class="notes">
  </aside>

Merge
=====

![Merge mit Branches](gemeinsamer-branch-merge.png)




_________________________________________


  <aside class="notes">
  </aside>

Rebase
=====

![Rebase mit Branches](gemeinsamer-branch-rebase.png)






_________________________________________


  <aside class="notes">
  Ergebnis-Folie
  </aside>

<table cellspacing="15">
  <tr bgcolor="yellow">
    <th>&nbsp;Merge</th>
    <th>&nbsp;Rebase</th>
  </tr>
  <tr>
    <td>
      {% include_relative unternehmen/d.html %}<br/>
      {% include_relative unternehmen/i.html %}<br/>
      {% include_relative unternehmen/j.html %}<br/>
      {% include_relative unternehmen/k.html %}<br/>
      {% include_relative unternehmen/l.html %}<br/>
      {% include_relative unternehmen/m.html %}<br/>
      {% include_relative unternehmen/n.html %}
    </td>
    <td>
      {% include_relative unternehmen/a.html %}<br/>
      {% include_relative unternehmen/c.html %}
    </td>
  </tr>
  <tr bgcolor="yellow">
    <th>&nbsp;Mal so, mal so</th>
  </tr>
  <tr>
    <td>
      {% include_relative unternehmen/b.html %}<br/>
      {% include_relative unternehmen/h.html %}
    </td>
  </tr>

</table>






_________________________________________


  <aside class="notes">
  Fallbeispiel
  </aside>

### Unternehmen: {% include_relative unternehmen/a.html %}

{% include_relative unternehmen/a-details.html %}

Entscheidung: Integration durchgängig per Rebase
------------------------------------------------

Historie wird nur als Backup und zum Auditing genutzt (Wer hat wann was geändert).
Die einfache lineare Historie genügt.





_________________________________________


  <aside class="notes">
  Fallbeispiel
  </aside>

### Unternehmen: {% include_relative unternehmen/d.html %}

{% include_relative unternehmen/d-details.html %}

Entscheidung: Merge
---------------------------

 * Weniger initialer Schulungsaufwand
 * Eclipse-Tooling ist einfacher.
 * Komplexe Historie wird nur als Auditing benutzt.






_________________________________________


  <aside class="notes">
  Ergänzung zu Frage-Folie
  </aside>

Böse Merge-Konflikte?
=====================







_________________________________________


  <aside class="notes">
  Ergänzung zu Frage-Folie
  </aside>

### kaum






_________________________________________


  <aside class="notes">
  Fallbeispiel
  </aside>

### Unternehmen: {% include_relative unternehmen/k.html %}

{% include_relative unternehmen/k-details.html %}

## Merge-Konflikte

Länger lebende Branches mit regionalen Anpassungen führen häufiger zu arbeitsintensiven Merges.






_________________________________________


  <aside class="notes">
  Ergänzung zu Frage-Folie
  </aside>

Und was ist mit dem Task-Tracker?
=================================







_________________________________________


  <aside class="notes">
  Fallbeispiel
  </aside>

### Unternehmen: {% include_relative unternehmen/f.html %}

{% include_relative unternehmen/f-details.html %}

Entscheidung: Issue-ID in jeder Commit-Message
-----------------------------------------

Nachvollziehbarkeit von Änderungen ist aufgrund rechtlicher Vorgaben erforderlich.






_________________________________________


  <aside class="notes">
  Frage-Folie
  </aside>

Macht ihr Code-Reviews? Ehrlich?
--------------------------------

Diff to master<br/>oder<br/>Commit by Commit?
=============================================








_________________________________________


  <aside class="notes">
  Ergebnis-Folie
  </aside>

<table cellspacing="15">
  <tr bgcolor="yellow">
    <th>&nbsp;Diff 2 master</th>
    <th>&nbsp;Commit by Commit</th>
  </tr>
  <tr>
    <td>
      {% include_relative unternehmen/c.html %}<br/>
      {% include_relative unternehmen/d.html %}<br/>
      {% include_relative unternehmen/j.html %}<br/>
      {% include_relative unternehmen/l.html %}
    </td>
    <td>
      {% include_relative unternehmen/h.html %}
    </td>
</table>







_________________________________________


  <aside class="notes">
  Fallbeispiel
  </aside>

### Unternehmen: {% include_relative unternehmen/h.html %}

{% include_relative unternehmen/h-details.html %}

Entscheidung: Commit by Commit
-------------------------------

Per Receive-Hook wird im Jenkins ein Build angestossen und eine Mail mit Aufforderung zum Review verschickt. Vorteil: Es sind meist kleine überschaubare Einheiten zu reviewen.







_________________________________________


  <aside class="notes">
  Fallbeispiel
  </aside>

### Unternehmen: {% include_relative unternehmen/l.html %}

{% include_relative unternehmen/l-details.html %}

Entscheidung: Diff to master
----------------------------

Für ein Open-Source-Projekt sind Code-Reviews essenziell.
Eintreffende Pull-Requests haben mitunter lange und verschlungene Commit-Historien. Meist ist es übersichtlicher, das Endergebnis zu betrachten.

Das Projekt hat früher mit Subversion gearbeitet. Der Github-Pull-Request macht es leichter zum Projekt beizutragen. Das Projekt erhält mehr Contributions als vorher.






_________________________________________


  <aside class="notes">
  Ergänzung zur Frage-Folie
  </aside>

Habt ihr die History schön?
===========================






_________________________________________


  <aside class="notes">
  Ergänzung zur Frage-Folie
  </aside>

Git bietet mächtige Möglichkeiten Historie aufzubereiten und (ggf. auch nachträglich) schön zu machen, z. B. `rebase --interacte`, `rebase --onto`, `filter-branch`, `notes`.

### Genutzt wird das kaum.





_________________________________________


  <aside class="notes">
  Ergänzung zur Frage-Folie
  </aside>

Und was ist mit Gerrit?
=======================








_________________________________________


  <aside class="notes">
  Ergänzung zur Frage-Folie
  </aside>

Gerrit
=======================

Einige Unternehmen haben Gerrit ausprobiert.

 * Hohe Komplexität (Doppelte Ids, Amend-Workflow)
 * Nutzen Gerrit nur noch als Git-SSH-Server.
 * Umstieg auf Pull-Requests
