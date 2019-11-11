
<!-- .slide: data-background-image="07-schoene-historie/schriftrolle.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="07-schoene-historie/schriftrolle.png"  data-background-opacity="0.4"  data-background-size="contain" -->

# Schöne Historie


Notes:

TODO Bild mit first-parent-history


B: Also bei uns sieht man, wenn man die Merges betrachtet,
sehr schön, wann welche Stories integriert worden.
Man kann sogar die Release 


R: Der Commit-Graph wird aber trotzdem häßlich, 
weil sich die Features mehrfach überlappen.

B: Wir Rebasen die Feature Branches vor dem Merge,
dann sieht alles hübsch und ordentlich aus. 

R: Das Rebasing erfordert aber Git-Know-How und Koordination.

R: Und überhaupt: Wer schaut sich die globale Historie denn wirklich an?

R: Und für die Release Notes haben wir JIRA.



### Fazit

 * Wozu braucht man die Historie Überhaupt?
 * Bei Feature-Branching 
   - Commit nach Features gruppiert
   - Release Historie ablesbare (First-Parent-History)