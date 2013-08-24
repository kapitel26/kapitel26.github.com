---
layout: page
title: "Errata"
description: ""
---
{% include JB/setup %}

Verbesserungsvorschläge und Feedback bitte an git@eToSquare.de

Schreibfehler korrigieren wir direkt im Masterdokument für die nächste Auflage. Inhaltliche Fehler listen wir hier auf:

Kapitel 2 Erste Schritte
------------------------

* **15 oben:** Der Pfad `/Users/rene/Temp/projekte/erste-schritte`  ist falsch, richtig ist `/projekte/erste-schritte`.

Kapitel 3 Was sind Commits?
---------------------------

* **19 unten** "Posix" in Kleinbuchstaben ist falsch. Korrekt ist "POSIX". (Portable Operating System Interface)

* **25 unten** "... dürfen Commit-Hashes verkürzt angegeben werden ..." wird ergänzt um den Zusatz "sofern es nur ein einziges 
  Commit mit diesem Prefix gibt.".

Kapitel 4 Commits zusammenstellen
---------------------------------

* **27, Abb. 4-1** Leserfrage: Werden im Staging-Bereich Änderungen Diffs oder Dateiinhalts gespeichert?
  
  Abb. 4-1 suggeriert, dass im Staging-Bereich Änderungen gespeichert werden. Das ist nicht so.

  - Der Staging-Bereich hält für jede von Git verwaltete Datei
    *einen Snapshot des Dateiinhalts*.

  - Mit dem `add`-Befehl werde Änderungen, z. B. neue Dateien, geänderte Dateien oder auch einzelne Abschnitte geänderter Dateien, zum Stage-Bereich hinzugefügt. Gespeichert werden aber Snapshots der geänderten Inhalte.
  


  


  

