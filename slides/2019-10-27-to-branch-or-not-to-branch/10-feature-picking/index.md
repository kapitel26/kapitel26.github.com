
<!-- .slide: data-background-image="10-feature-picking/feature-picking.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="10-feature-picking/feature-picking.png"  data-background-opacity="0.4"  data-background-size="contain" -->


# Feature Picking

Notes:

B:  Vor dem Release, kann Der PO bei FB entscheiden, welche Features reif sind.

R: Das ist brenzlig, weil die Integration dann\
fast vollständig ans Ende des Sprints verschoben wird.

B: Immerhin kann der PO entscheiden, welches Feature aufgenommen wird. Und bei Euch gehen Features unkontrolliert live?

R: Die Entwickler bei uns handeln eigenverantwortlich, und stimmen sich mit dem PO ab.
   Wenn etwas schief geht, können die kleinen Änderungen schnell wieder ausgebaut werden.
   Bei komplexeren und unsicheren Features verwenden wir Toggles.

R: Und was macht ihr, wenn die Feature-Branches voneinander abhängig sind?

B: Wir verbieten zwischen Feature-Branches hin- und herzumergen

R: Dann dauert es ja ewig, ein neues Feature zu beginnen, 
  das auf einem anderen Feature-Branch basiert.
  
B: Manchmal teilen wir Features auf und integrieren Zwischenergebnisse.

R: Wer räumt bei Euch eigentlich die Branches auf und habt ihr nicht viele Branch-Zombies herumliegen?

B: Beim Abschluss des Features löschen wir den Branch. Die Liste der nicht abgeschlossenen Branches gehen wir alle 2 Monate durch.



================================================================



### Fazit

 * Feature-Branches geben direktere Kontrolle über die Integration
   * Integration kurz vor Schluss ist nicht empfehlenswert.
   * Zwischen Feature-Branches sollte nicht gemerged werden.
   * Das Teilen von Zwischenergebnissen ist umständlich.
 * In TBD akzeptiert man, dass der Code von unvollständigen Features\
   ausgeliefert wird (weggetoggled natürlich).
   * Ggf. geben Feature-Toggles dem PO die Kontrolle über Features.

Ein echtes wahlfreies Feature-Picking funktioniert auch in FB nicht wirklich gut.
