
<!-- .slide: data-background-image="11-team-groesse/grosse-truppen.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="11-team-groesse/grosse-truppen.png"  data-background-opacity="0.4"  data-background-size="contain" -->


# Team Größe


Notes:

B: Und wie würdest du das machen,\
wenn ihr nicht ein Team wärt,\
sondern beispielsweise 25 Teams.\
Wenn die alle an einem Repo arbeiten,\
wieviele Änderungen und damit auch Builds bekomme ich dann,\
wenn jeder Entwickler jede halbe Stunde integriert?
  
R: Müssen die denn alle auf demselben Repo arbeiten?\
Die könnten doch auch separate Repos haben und \
ihre Module bzw. Services unabhängig versionieren.

B: Aber 
  - Refactoring über Repogrenzen hinweg werden dann schwierig
  - Wenn man ein monolithischen System hat, kann man nicht unabhängig versionieren.
  - Aber in Open Source Projekten kannman  ja nicht jeden auf den master lassen.


R: Dann spricht vieles für Feature-Branching.

  
================================================================


### Fazit

Bei vielen Entwicklern in mehreren Teams auf dem selben Repo, 
Monolithen und Open-Source-Projekten
ist der Overhead für Feature-Branching oft gerechtfertigt.  
  
