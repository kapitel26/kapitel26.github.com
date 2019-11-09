

# Schöne Historie


================================================================


## schöne historie

P Aber bei uns sieht (anhand first-parent/merges) sehr schön, wer wann was integriert hat

TODO Bild

C Feature Branches (ohne Rebasing ) werden trotzdem hässlich. 
  Und mit Rebasing erforden noch mehr git-know-how und Abstimmung.

TODO Bild

C! Wer schaut sich die globale Historie denn wirklich an. 

 * Release Notes
 * eher auf File annotate blame, verstehen was passiert ist
 * Grob granulaer vs. fein: Welches comit gehÓr zu jedem FEator
   - git diff X^1...X^2
   - Jira issue in commit-message
 * Reverten (und Cherrypicken) eines Feature (schwierig, wenn auf mehre commits verteilt)
   - wie oft tritt das auf? Bis wann geht das überhaupt?
   - Alternative: Einzelreverts oder manuell ausbauen
   - Revert
     - Undo ist kompliziert
     - Ist ohne fachliches des Features müglich
   

C! Außerdem habe wir JIRA

P Wir könne aus der Historie die Release Notes ableiten

  - REverten kann sehr unübersichtlich werden

C Könnte man aber auch aus JIRA holen


### Fazit

 * Braucht man eine schöne Historie
 * First-Parent
   - Commit nach Features gruppiert
   - Release Historie ablesbare
