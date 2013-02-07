---
layout: page
title: "Errata"
description: ""
---
{% include JB/setup %}

Kapitel 2 Erste Schritte
-----------------

* **15 oben:** Der Pfad `/Users/rene/Temp/projekte/erste-schritte`  ist falsch, richtig ist `/projekte/erste-schritte`.


Kapitel 3 Was sind Commits?
--------------------

* **19 unten** "Posix" in Kleinbuchstaben ist falsch. Korrekt ist "POSIX". (Portable Operating System Interface)

* **25 unten** "... dürfen Commit-Hashes verkürzt angegeben werden ..." ergänzen wir um den Zusatz "sofern es nur ein einziges 
  Commit mit diesem Prefix gibt.".

Kapitel Commits zusammenstellen
--------------------------

* **27, 4-1** Leserfrage: Speichert der Stage-Bereich nun Änderungen Diffs oder Dateien?
  
  - Mit dem `add`-Befehl werde Änderungen (neue Dateien, geänderte Dateien der einzelne Abschnitte geänderter Dateien) zum Stage-Bereich hinzugefügt. Git speichert dann aber Snapshots der Dateien.


  

