
<!-- .slide: data-background-image="10-feature-picking/feature-picking.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="10-feature-picking/feature-picking.png"  data-background-opacity="0.4"  data-background-size="contain" -->


# Feature Picking

Notes:


B:  Vor dem Release, kann Der PO bei FB entscheiden, welche Features reif sind

R: Das ist brenzlig, weil die Integration dann\
fast vollständig ans Ende des Sprints verschoben werden

B: Immerhin kann der PO entscheiden, welches Feature aufgenommen wird.

R: Und was, wenn die Feature-Branches von einander Abhängig sind.

B: Wir verbieten zwischen Feature-Branches hin- und herzumergen

R: Dann dauert es ja ewig, ein neue Feature zu beginnen, 
  das einem andern Feauture basiert.
  
B: Manchmal Integrieren wir Zwischenergebnisse.

B: Aber der PO kann immer entscheiden, was fachlich integert.
  - trunk-based müsste er ja jedes einzelne Commit fachlich prüfen.
   
R: Bei uns ist das Feature im Code schon längst draußen.\
Der muss lediglich entscheiden,\
wann das Feature-Toggle gelöst wird.

Notizen 
 * Lang laufende Branches
   - geparkte Feauter Branches
   - Migrationsbranche

### Fazit

 * FB gibt direktere Kontrolle über die Integration von Features.
 * Mehrfachintegration kurz vor schluss ist auch bei FB nicht empfehlenswert.
 * In FB sollte man Cross-Merges vermeiden.
 * Das Teilen von zwischenergebnissen in FB ist umständlich.
 * In TB akzeptiert man, dass der Code unvollständiger Features\
   ausgeliefert wird (weggetoggled natürlich).
 * in TB geben Feature-Toggles dem PO die Kontroller über Features
