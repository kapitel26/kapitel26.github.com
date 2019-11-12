
<!-- .slide: data-background-image="07-schoene-historie/schriftrolle.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="07-schoene-historie/schriftrolle.png"  data-background-opacity="0.4"  data-background-size="contain" -->

# Schöne Historie


Notes:

TODO Bild mit first-parent-history


B: Also bei uns sieht man, wenn man die Merges betrachtet,
sehr schön, wann welche Stories integriert wurden.
Man sieht dann grob granular die Merges auf develop,
feingranular die Commits auf den Branches.

R: Der Commit-Graph wird aber trotzdem häßlich, 
weil sich die Features mehrfach überlappen.

B: Wir Rebasen die Feature Branches vor dem Merge,
dann sieht alles hübsch und ordentlich aus. 

R: Das Rebasing erfordert aber weiteres Git-Know-How und Koordination zwischen den Entwicklern auf dem Branch.

B: Wir können sogar die Release-Notes daraus generieren.

R: Für die Release Notes haben wir JIRA.
  Und überhaupt: Wer schaut sich die globale Historie denn wirklich an?


### Fazit

 * Die Historie für einzelne Dateien oder Zeile ist notwendig für Merges und Fehlersuche.
 * Schön muss sie dazu aber nicht sein
 * Bei Feature-Branching kann man die Historie nutzen, um die Integration der Features darzustellen.

   