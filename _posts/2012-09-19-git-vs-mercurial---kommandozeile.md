---
layout: post
title: "Git vs. Mercurial - Kommandozeile (Teil 2)"
description: ""
category: Git
tags: [Git, Mercurial]
# just to fix a highlightin problem]()
author: bst
---

{% include_relative git-vs-hg.md %}

Und heute wird mal geschimpft. So sehr ich Git mag,
so sehr ärgere ich mich immer wieder über die Macken
der Git-Kommandozeile.

Warum Kommandozeile? Es gibt doch IDE's und GUI's
=================================================

Die Kommandozeile ist wichtig. Man kann vieles auch über die
IDE machen. Aber eben nicht alles:

 * Bei weitem nicht alle Features von Git und Mercurial sind
   über IDE-Plugins oder GUI-Tools verfügbar.

 * Automatisierungen, z. B. für Continuous Integration,
   lassen sich am besten über die Kommandozeilenschnittstelle
   umsetzen.

 * Beim Probeme lösen kommt an oft wesentlich schneller zum
   Ziel. Etwas Übung vorausgesetzt.

Es lohnt sich also einen Blick auf die Kommandozeilen-Interfaces
der beiden Systeme zu werfen.

Einstiegshürden
---------------

Ich neige dazu, meine Begeisterung für Git mit Anderen zu teilen.
Manche nennen das auch "Ohr abkauen". Manchmal ist das
erfolgreich, der Funke springt über, und die Leute probieren
Git aus. Nicht selten höre ich dann aber später sowas wie:
"Nee, das war mir alles zu umständlich. Ich mach wieder Subversion".

Auch wenn die später natürlich doch irgendwann wieder bei Git landen,
ist es ärgerlich, dass Git den Einsteigern so viele Steine in den Weg legt.

Git hat Macken? Welche Macken?
------------------------------

Wir stellen uns jetz mal vor ich wäre Git-Neuling und hätte gehört,
daß man in Git ganz phantastisch mit Feature-Branches arbeiten kann.
(Was ja auch stimmt.)
Munter lege ich mit einem `git branch my-feature` los
und fange an zu entwickeln.
Ein paar Commits später rufe ich `git status` auf und stelle fest,
dass ich die ganze Zeit auf dem Branch `master` entwickelt habe.
Wo ist `my-feature` geblieben? 	
Gut, ich schaue mir die Manual-Page für `git branch` an.
Langsam fange ich an zu verstehen, dass `git branch` den Branch zwar *anlegt*,
aber nicht *aktiviert*.
Zum Glück bin ich ein geduldiger Leser.
In Zeile 167 steht ein Hinweis, dass ich den Befehl `git checkout -b` verwenden soll,
wenn ich einen Branch nicht nur *erzeugen* sondern sogar  *benutzen* möchte.
Das verwundert mich zwar ein wenig, denn in Subversion bedeutet `checkout` etwas völlig anderes.
Besser ich gewöhne mich gleich daran, dass in Git vieles anders heißt als anderswo.
Überhaupt kann checkout so einiges bedeuten. Der Befehl ist so etwas wie ein Scheizer
Taschenmesser. Neben dem Erzeugen und Aktivieren von neuen Branches,
kann er auch

 * auf vorhandene Branches wechseln,
 * den Workspace auf ein beliebige Commit setzen, das gar nichts mit einem Branch zu tun hat,
 * nach einem Merge-Konflikt nur die eine von beiden Seiten (`--theirs` oder `--ours`) übernehmen,
 * lokale Änderungen im Workspace verwerfen,
 * oder einzelne Dateien im Workspace auf den Stand eines beliebigen Commits setzen.

Die Man-Page für `git checkout` ist 324 Zeilen lang.

Dass dies der Unix-Philosophie "Do one thing and do it well"
entspricht, erschließt sich wohl nur Vulkaniern,
die natürlich sofort durchschauen,
dass den Funktionen eine gemeinsame Implementierung zugrunde liegen muss.

Die vorletzte Funktion heißt in Subversion übrigens `revert`. Es gibt auch einen Git-Befehl
Namens `git revert` aber der macht etwas ganz anderes.

Die nächste Wunderwaffe von Git ist der `reset`-Befehl. Dieser Befehl kann gleichzeitig
den Branch-Zeiger, den sogenannten *Index* und den Workspace manipulieren.
Es gibt dafür 5 Modi: `--soft`, `--mixed`, `--hard`, `--merge` und `--keep`,
die bestimmen, was verändert wird und was nicht (Branch-Zeiger, Index und/oder Workspace).
Obwohl ich schon lange mit Git arbeite und ein [Buch](../../../../../git-buch) darüber geschrieben habe,
öffne ich auch heute noch oft die Man-Page, bevor ich ein `reset` durchführe.

Die Man-Page für `git reset` hat 369 Zeilen.

Die Man-Page für `git rebase` hat 752 Zeilen.

Die Man-Page für `git log` hat 1620 Zeilen.

Sie ahnen wohl schon, worauf ich hinaus will.
Es ist toll, dass Git Befehle und Optionen für jede Lebenslage hat,
und dass diese auch noch sorgfältig dokumentiert sind.
Aber: *Wer soll das alles lesen?*
Der Git-Einsteiger sieht oft den Wald vor lauter Bäumen nicht.
Die Bäume sind hier zahllose Optionen wie zum Beispiel `--left-right`,
`--simplify-by-decoration`, `--cherry-mark`, `--orphan`
oder `--committer-date-is-author-date`, für die es durchaus
Anwendungsfälle gibt, die aber nur selten verwendet werden.

Mercurial
---------

Dass es einfacher geht, zeigt Mercurial. Es wurde von Anfang
an dafür entwickelt, auch für Einsteiger verständlich zu sein.

 1. Anstatt neue *Begriffe* zu erfinden, hat man sich an Subversion
    orientiert. Das erleichtert den Umstieg.

 2. Die Kommandos haben nur *wenige Optionen*.

 3. Es sind auch immer wieder die gleichen Optionen, die bei den verschiedenen
    Kommandos auftauchen. Meist kann man raten,
    wie ein Befehl zu verwenden ist,
    ohne vorher in die Doku zu schauen.

 3. *Defaults* sind sinnvoll gesetzt. Selten muss man mehr als
    einen Parameter angeben. Oft braucht man gar keinen.
    Ein Beispiel: Haben zwei Entwickler auf dem
    selben Branch gearbeitet, genügt ein parameterloses
    `hg merge`, um die Änderungen zusammenzuführen.

 4. Auf *Schweizer-Taschenmesser-Befehle* wurde verzichtet.
    Jeder Befehl hat nur eine Aufgabe.

 5. Die Help-Pages sind kurz gehalten, meist nur 1-2 Bildschirmseiten.
    Man kann sie *mal eben schnell durchlesen*, wenn ein Problem hat.
    Sonderfälle und theoretische Erläuterungen findet man im
    [Mercurial-Wiki](http://mercurial.selenic.com/wiki/).
    Ich habe dies allerdings nur selten nutze müssen.

 6. Fortgeschrittenere Befehle und Optionen wurden in *Plugins*
    ausgelagert. Viele davon werden zwar mit ausgeliefert,
    sind aber noch nicht aktiviert. Selbst erfahrene
    Mercurial-User aktiviern meist nur einige davon.
    So bleibt das System übersichtlich. Der Nutzer
    kann selber entscheiden, welches Maß an Komplexität er
    sich zumuten möchte.

tl;dr
=====

Die Git-Kommandozeile ist nicht Einsteiger-freundlich. Mercurial macht's besser.
