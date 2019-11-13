
<!-- .slide: data-background-image="06-refactoring/umformieren.png" data-background-opacity="1"  data-background-size="contain" -->


================================================================

<!-- .slide: data-background-image="06-refactoring/umformieren.png" data-background-opacity="0.4"  data-background-size="contain" -->


# Refactoring

Notes:

R: Refactorings müsssen doch für euch echt ein Problem sein.\
Wenn ein Refactoring kurz vor Sprint-Ende auf mehrere Tage alte Feature-Branches trifft,\
dann geht das nicht ohne Probleme ab, oder?

B: Was soll denn da passieren?

R: Wenn wir alle gemeinsam auf dem `master`arbeiten kann ich alle Stellen, wo eine 
Funktion oder Klasse benutzt wird sofort finden und bearbeiten.
Auf Feature-Branches können aber ohne weitere neue hinzugekommen sein, besonders wenn der
Branch länger dauert.

B: Okay das stimmt, bei Refactoring müssen wir etwas vorsichtiger sein.\
Oft hilft es schon sich darüber abzustimmen, wer wann was umbaut,\
und kurz vor Sprintende lassen wir das lieber.\
Und wenn wir ein Refactoring machen,\
fordern wir die Kollegen das schnell die Änderungen in Ihren Feature-Branch zu holen.


================================================================


### Fazit: Refactoring

 * Refactorings betreffen oft viele Dateien
 * Je länger die Branches, desto schwerer die Integration nach Refactorings
 * Bei Feature-Branching hilfreich:
   - Koordination
   - Kurzlebige Refactoring-Branches
   - Update-Merge-Aufrufe nach Integration des Refactorings

TBD erleichtertert Refactorings
   


