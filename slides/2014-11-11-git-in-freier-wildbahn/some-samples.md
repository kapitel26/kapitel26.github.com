___SECTION_______________________________


  <aside class="notes">
  Nichts sagen.
  </aside>

MOIN MOIN!
---------







_________________________________________


  <aside class="notes">
  Vorlesen als Denkanstoss. Warten. Der Begriff Versionsverwaltung stammt aus einer Zeit als Bürokraten das gemacht haben. Oft gab es eigene Abteilungen dafür.
  </aside>

### Ob wohl Versionsverwaltungen <br/> Versionen verwalten ?

![Aktenarchiv](img/istock-aktenarchiv.jpg)






_________________________________________


  <aside class="notes">
Git kann Änderungen aufzeichnen, Daten sichern, Protokolle erstellen, alte Versionen herstellen, Unterschiede aufzeigen.
  </aside>

Doch, schon
-----------

```bash
commit 686158a5bb83ef701c71f54b95eb04f9f0732144
Author: Bjørn Stachmann
Date:   Wed Oct 30 21:51:38 2013 +0100

speakernotes ausprobiert

material/ContinuousLifecycle-2013/warum-wir-git-lieben.html | 6 +++++-
1 file changed, 5 insertions(+), 1 deletion(-)
```

aber ...
--------





_________________________________________


  <aside class="notes">
Ohne Worte. Warten. Nächste Folie.
  </aside>

... darum geht es nicht
-----------------------







_________________________________________


  <aside class="notes">
    Git wurde für den Linux-Kernel entwickelt. Verwaltung war da nicht das, worum es geht.
  </aside>

### Wollen viele <br/> ein gemeinsames Ziel erreichen, <br/> zählt nur eines:

<!-- TODO Bild: Weltkugel, Pinguin -->





_________________________________________


  <aside class="notes">
  </aside>

Zusammenarbeit!
===============







_________________________________________


  <aside class="notes">
    Einige Entwickler arbeiten am Kern. Andere fixen Bugs. Weitere internationalisieren. Wieder andere erproben Neues. Alle haben unterschiedliche Arbeitsweisen und Releasezyklen. Trotzdem müssen sie ständig Informationen und Code austauschen.
  </aside>

![Dezentrale Zusammenarbeit](img/dezentrale-zusammenarbeit.png)







_________________________________________


  <aside class="notes">
Ein paar Kernbegriffe. Klon - vollwertige Kopie eines Repositories. Fork - unabhängige Weiterentwicklung. Push/Pull - Übertragen von Commits. Merge - 3-Wege (Basis: Commit-Graph).<p>
  </aside>

Dezentral arbeiten,

* Klon
* Fork

sich mit anderen austauschen

* Push
* Push

und Ergebnisse zusammenführen

* Merge








_________________________________________


  <aside class="notes">
    Meine Definition von Git.
    Denkanstoss: Wikipedia dezentral? Wäre das möglich? Wäre das Cool?<p>
    Im nächsten Abschnitt folgt der Pull-Request, das "Killer-Feature" zur Kollaboration.
  </aside>

Git
===

ist ein Werkzeug, <br/> mit dem Entwickler <br/> dezentral zusammenarbeiten.
-------------------------------------------------------------------------------
