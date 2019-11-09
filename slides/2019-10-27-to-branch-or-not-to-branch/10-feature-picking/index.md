

# Feature Picking


================================================================



##  feature management, feature picking

P Vor dem Release, kann Der PO entscheiden, welche Features reif sind

C Das ist brenzlig, weil die Integration dann fast vollständig ans Ende des Sprints verschoben werden

P Immerhin kann der PO entscheiden, welches Feature aufgenommen wird.

C Abhängigkeit zwischen Feature-Branches

P Wir verbieten zwischen Feature-Branches hin- und herzumergen

C Dann dauert es ja ewig, ein neue Feature zu beginnen, 
  das einem andern Feauture basiert.
  
P Ggf. Zwischenmerges auf den Master/dev. Oder aufteilen. 
  In jedem organisatorischer Overhead.

P Aber der PO kann immer entscheiden, was fachlich integert.
  - trunk-based müsste er ja jedes einzelne Commit fachlich prüfen.
   
C Natürlich würde PO erst prúfen, wenn das Feature fachlich abgeschlossen (JITA zu)
 
P Aber denn sind fachlich unvollständig Zwiechenversionen auf dem angeblich stabilen master?

C Das Könnte man aber Feature-Togglen

 * Lang laufende Branches
   - geparkte Feauter Branches
   - Migrationsbranche

### Fazit

 * FB gibt direktere Kontroller über die Integration von Features
 * Mehrfachintegration kurz vor schluss ist auch bei FB nicht empfehlenswert
 * In FB soll man Cross-Mergen meiden
 * Das Teilen von zwischenergebnissen in FB zieht organisatorischen overhead nach sich
   und erroder mehr git skill.
 * In TB akzeptiert man, dass unvollständige Features (aber immer grün)
 * in TB geben Feature-Toggles dem PO die Kontroller über Features
