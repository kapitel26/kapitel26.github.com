---
layout: post
title: "Git vs. Mercurial - Geschichtsfälschung (Teil 3)"
category: Git
tags: [Git, Mercurial, Commit-Hash, Rebasing, Staging, Stashing]
# just to fix a highlightin problem]()
author: bst
---
{% include JB/setup %}

{% include git-vs-hg.md %}

Auf den ersten Blick scheint alles einfach.
Eine Versionsverwaltung muß jeden Stand der Software sicher archivieren,
so dass er auch nach vielen Jahren exakt wieder hergestellt werden kann.

**Was einmal archivert wurde ist für immer und wird *nicht verändert*. Basta!**

Ganz so einfach ist es vielleicht doch nicht. 

Es gibt immer mal wieder Situationen,
wo man im Repository aufräumen möchte. Zum Beispiel weil jemand die Datei mit 
den Klartextpasswörtern eingechecked hat, oder weil sich mal jemand total
verbranched hat, oder weil sich im Laufe der Zeit Müll angesammelt hat, den
keiner mehr braucht.

Eigentlich geht es mir aber um etwas anderes, nämlich um die Frage,
wie man eine *Historie* erzeugt, in der die Änderungen so beschrieben werden, dass ein anderer Entwickler sie schnell verstehen kann, zum Beispiel für ein Review. Das ist schwieriger als es klingt. Gute Commit-Kommentare alleine genügen nicht. Das Problem ist, dass man beim Entwickeln eines Features oft die unterschiedlichsten Dinge tut. Man fügt Code hinzu, man refactored, man schreibt Tests, man korrigiert Whitespace, man schreibt Kommentare und schließlich baut man Dinge wieder um, die man gerade erst geschrieben hat.
In der Versionsverwaltung stellt sich das meist so dar:

 * Entweder man macht nach vielen Stunden, wenn alles fertig, getestet und 
   dokumentiert ist ein einzelnes abschließendes Commit, 
 * oder man macht nach jedem einzelnen kleinen Schritt ein Commit.

Im ersten Fall arbeitet man stundenlang ohne Netz und doppelten Boden. Man verzichtet solange faktisch auf Versionsverwaltung. Am Ende steht dann ein Monster-Commit. Im zweiten Fall entsteht eine Historie aus Einzelcommits, bei der man den Wald vor lauter Bäumen nicht erkennen kann.

Enter: Git
----------

An dieser Stelle betritt Git die Bühne. Es wurde geschaffen, um lesbare Historien zu ermöglichen.

 * **Staging:** Man kann bestimmen, welche Änderungen in das nächste Commit 
   kommen und welche nicht. Wenn es sein muss, kann ich einzelne Zeilen auswählen oder weglasse. Habe ich währende der Arbeit an einem Feature Whitespace korrigiert oder Kommentare ergänzt, dann kann ich diese Änderungen separat committen. (`git commit --interactive` oder über GUI)

 * **Stashing:** Mit `git stash`kann man Änderungen *parken*, um sie später an 
   anderer Stelle wieder hervorzuholen. Wenn ich ich einen Bug gefixed habe, der eigentlich zu einem anderen Feature gehört, dann kann ich genau diese Änderungen zwischenspeichern und später auf dem richtigen Branch committen. 

 * **Amending:** Mit `git commit --amend` kann ein vorangegangenes Commit 
   repariert werden.
 
 * **Rebasing:** `git rebase` verschiebt Änderungen im Repository. Die 
   wichtigste Anwendung: Ein anderer Entwickler und ich haben Änderungen
   durchgeführt. Der Andere war schneller. Ich könnte jetzt ein Merge druchführen und es gäbe eine häßliche Verzweigung in der Historie. Ein
   Rebase würde stattdessen meine Änderungen auf die des anderen Entwicklers oben drauf setzen, so dass die Historie linear bleibt.

 * **Interactive Rebasing:** Die Königsdisziplin. Man programmiert wie im 
   Rausch, committed wie ein Irrer und am Ende stehen dann ein paar Dutzend Commits unstrukturierte Commits. Dann hilft ein `git rebase --interactive`.
   Zuerst sieht man die liste der Commits durch, und versucht sich zu erinnern, was man da eigentlich gebaut hat. Dann fängt man an aufzuräumen.
   Zunächst ändert man die Reihenfolge, so dass inhaltlich zusammengehörende Commits nebeneinander stehen. Dann fasst mehrere solcher Commits zusammen,
   so dass ein Commit entsteht, dem man einen sinnvollen fachlichen Kommentartext geben kann. Überflüssige Commits sortiert man aus. Commits, die zwei verschiedene Aspekte bearbeiten bricht man auf.
   Am Ende steht für das Feature eine saubere strukturierte Historie aus wenigen Commits, die so aussieht, als hätte man von Anfang an gewusst, was man tut. Großartig, nicht wahr?

 * **Und mehr:** Mit Befehlen wie `git cherry-pick`, `git merge --squash` und `git filter-branch` kann man Repositorys kneten wie Fimo.


Und Mercurial?
--------------

Ursprünglich war Mercurial nicht dafür konzipiert, dass Historien verändert werden. Im Laufe der Zeit wurden diese Features dann in Form von Plugins nachgereicht.

  * **Staging**: RecordExtension (mitgeliefert)

  * **Stashing**: ShelveExtension, AtticExtension (extern)
  
  * **Amending**: `hg rollback`
  
  * **Interative Rebasing**: HisteditExtension (mitgeliefert)
  
  * **Cherry-Picking**: `hg graft` oder TransplantExtension (mitgeliefert)
  
  * **Sonstiges**: MqExtension

Die Wunderwaffe von Mercurial ist die MqExtension. Sie ermöglicht es, eine Folge von Commits in eine Queue von Patches umzuwandeln. Mit dieser Queue kann man dann allerlei wundersame Dinge tun. Das ganze ist sehr mächtig, aber schwer zu verstehen und nicht gerade übersichtlich. Ich habe mich jedenfalls nicht so recht damit anfreunden können. 

Bei einigen der Plugins ist es schon eine Weile her (so ca. Mercurial 1.7), dass ich sie zum letzten Mal verwendet habe. Damals waren sie noch nicht ausgereift. Inzwischen sind sie recht brauchbar, wenn auch noch nicht ganz so ausgefeilt wie die entsprechenden Git-Kommandos. 

Ein interessantes Feature bietet Mercurial seit Version 2.1: Phases. Mercurial merkt sich, ob man es schon mit anderen geteilt hat (z. B. durch ein Push). Mercurial schützt Commits, die bereits veröffentlicht wurden, vor versehentlicher Manipulation.

Ist das nicht alles böse Manipulation?
--------------------------------------

Eine Versionsverwaltung muß archivierte Versionen exakt wieder herstellen können. 

 * Zur *Fehlerbehebung* möchte man genau wissen, auf welchem Code-Stand das
   Problem aufgetreten ist.

 * Aus *rechtlichen Gründen* sind Unternehmen dazu verpflichtet, nachweisen zu
   können, welche Version einer Software zu welchem Zeitpunkt eingesetzt wurde
   und wann daran Veränderungen vorgenommen wurden.

 * Zur *Nachvollziehbarkeit*: In Open-Source-Projekten möchten man oft genau 
   wissen, wer was zur Software beigetragen hat.

Lokale Änderungen auf Commits, die noch nicht gepushed wurden, stellen natürlich kein großes Problem dar. Interessant wird es, wenn Commits manipuliert werden, die bereits im Projektrepository enthalten sind.

Beispiel: Die Commits `C'` und `D'` wurden durch ein `rebase` neu erstellt. Die Version `D` wurde ausgeliefert und in Produktion genommen.

               1.0
                |
                V
    A---B---C---D
         \
          C'---D'

Sowohl für Git als auch für Mercurial gilt:

 * `D` hat einen anderen Commit-Hash als `D'`. Dieser Hash ist Prüfsumme 
   über alle Dateien, Commit-Daten und das Vorgänger-Commit.

 * Der Hash von `D` passt also nur auf genau diesen Softwarestand mit der
   Historie aus `A`, `B` und `C`.

 * Das Tag "1.0" zeigt weiterhin auf das Commit `D` nicht auf `D'`

 * In Mercurial kann man Tags verschieben. In Git ist das schwierig, 
   aber nicht unmöglich. Deshalb sollte man neben dem Tagnamen immer
   auch den Commit-Hash ausgelieferter Versionen dokumentieren.

 * Es ist empfehlenswert, im Build-Prozess den Commit-Hash in die
   ausgelieferten Pakete schreiben zu lassen.

 * Solange das Commit `D` nicht aus dem Repository gelöscht wird, bleibt 
   die Historie also nachvollziehbar.

 * Git schützt Commits, die mit einem Tag versehen sind vor dem *Garbage
   Collector*. In Mercurial verschwinden Commits nur, wenn sie explizit gelöscht werden.

 * Falls man veröffentlichte Geschichte neu schreibt, muss man sich im Team
   darauf einigen auf dem neuen Strang weiter zu arbeiten (im Beispiel `D'`). Anderenfalls würde es Probleme geben, weil Git/Mercurial versuchen würden, die duplizierten Commits doppelt anzuwenden.

Kurz: Solange man den Commit-Hash einer Version kennt, kann man die Entstehungshistorie nachvollziehen. Manipulationen sind zwar möglich, aber sie erzeugen immer andere Commit-Hashes, so dass die neuen Versionen immer von den alten unterschieden werden können.

Fazit
-----

Die (lokale) Geschichte zu verändern, ist sehr nützlich, um *Historie* lesbar zu machen. Gelegentlich muss man es auch tun, um im Repository aufzuräumen.

Git bietet ein starkes Tooling hierfür an. Über Plugins kann Ähnliches auch in Mercurial bekommen. 

