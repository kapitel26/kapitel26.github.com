---
layout: post
title: "Git vs. Mercurial - Lieblingsfeatures: Cooler Workflow mit interactive Rebasing (Teil 5)"
category: Git
tags: [Git, Mercurial, Rebasing, "Interactive Rebasing"]
# just to fix a highlightin problem]()
author: bst
---

{% include_relative git-vs-hg.md %}

Ich kenne Entwickler die committen kaum öfter als zwei
oder drei Mal am Tag. Die überlegen sich, was sie tun
wollen, wie sie es tun wollen, implementieren genau das,
testen es, reparieren es und liefern es dann ab.
Falls Sie zu diesen Entwicklern gehören,
überspringen Sie diesen Post und warten auf den nächsten.
Der Heutige wird ihnen nicht gefallen.

Ich arbeite nach beim Entwickeln immer nach einer  
**strikten Methodik**:

 * Ich überlege, was ich tun möchte.
 * Dann lege ich los.
 * Einen Augenblick später erkenne ich, dass der
   Code hässlich wird.
 * Ich nehme ein paar Änderungen zurück.
 * Ich versuche es noch mal.
 * Immer noch Sch...
 * Ich fange an zu Googeln.
 * Vielleicht gibt es eine Library, die mir hilft.
 * Ich baue eine Library ein.
 * Wird ja immer schlimmer: Ausbauen!
 * Ich finde eine andere Library.
 * Hmm... nicht mehr ganz so schlimm. Aber noch nicht rund.
 * Ein wenig Refactoring am alten Code
   macht die Sache lesbarer.
 * Langsam wird's besser.
 * Ein paar Änderungen, die ich vorhin zurückgenommen
   habe waren eigentlich doch nicht so schlecht.
 * Ich baue sie wieder ein.
 * Brauchbar.
 * Noch ein paar Testfälle ergänzen.
 * Alle Änderungen noch mal in Ruhe durchgehen.
 * Ein paar überflüssige Änderungen entfernen.
 * Ein paar Namen für mehr Lesbarkeit anpassen.
 * Jetzt sieht es ganz OK aus
 * Endliche liefern!

Chaotisch? Zugegeben: Ist es. Trotzdem habe ich ein paar
Grundsätze dabei.

 * Die Annahme, dass ich die Lösung schon kenne,
   ist falsch (fast immer). Experimentieren lohnt sich.

 *  Vorher Denken ist nicht verkehrt.
    Den Commit-Kommentar schreibe ich im voraus.
    Ich überlege ich mir, was ich tue und warum.
    und fokussiere dabei auf diese eine Sache.
    Den Rest der gräßlichen Codebasis ignoriere
    ich vorerst.

 *  Software die nicht läuft, ist doof.
    Kurz vor Schluss zu testen ist noch viel doofer:
    Rote Tests sofort reparieren.

 *  Kleine Schritte. Sobald ich merke, dass ich nicht
    vorankomme, und die Tests nach ein paar Minuten immer
    noch nicht grün sind,
    breche ich ab und versuche es nochmal von vorne.
    Das gefällt mir besser, als das Herumstochern im
    Debugging-Nebel. Wenn der zweite Versuche auch nichts
    wird, versuche mit Refactoring die Ausgangssituation
    zu verbessern.

Ich merke gerade, ich schweife ein wenig ab.

... und was hat das jetzt alles mit Git zu tun?
-----------------------------------------------

Um so zu arbeiten, committe häufig. Ein paar Zeilen ändern,
die Tests sind grün: Schon wieder ein Commit. So kann ich

 * schnell auf einen _grünen_ Stand zurück,
   wenn ich mich mal verrant habe. (mit `git reset --hard`)
 * im Log schnell einen Überblick bekommen,
   was ich schon gemacht habe.
 * bei nachträglich entdeckten Fehlern die
   Ursache auf eine kleine Code-Änderung zurückführen.
   (mit `git bisect`)
 * jederzeit ein paar Commits zurückgehen,
   und einen anderen Lösungsansatz versuchen.
 * per Cherry-Pick einzelne Commits
   aus verworfenen Zweigen
   wieder herstellen.

Die Sache hat aber einen Haken. Nach ein paar Stunden
Programmierung steht eine unübersichtliche Folge von
135 unsortierten Commits im Repository.
Hier betritt mein Lieblingsfeature von Git die Bühne:
`git rebase --interactive`. Man kann damit

 * Kommentare ändern und ergänzen,
 * mehrere Commits zusammenfassen,
 * Reihenfolgen ändern
 * und Commits weglassen.

Das geht recht einfach. Die letzten 4 Commits
überarbeitet man mit:

    git rebase --interactive HEAD~4

Es öffnet sich ein Editor mit einer Liste von Commits.

    pick 1f23222 HTML-Darstellung verbessern
    pick 1d87986 Bugfix: Falsche Klammerung in Ausdruck
    pick 2d1936d Library "blabla" hinzufügen
    pick 6b6114a HTML-Darstellung verbessern

Am Anfang jeder Zeile kann ich ein Kommando angeben, das sagt, was
mit der Zeile gemacht weren soll (Der Default ist `pick` und bedeutet, dass das Commit unverändert übernommen werden soll).
Ich kann die Commits aber auch umsortieren oder  
ganz weglassen.

    pick   1f23222 HTML-Darstellung verbessern
    squash 6b6114a HTML-Darstellung verbessern
    edit   1d87986 Bugfix: Falsche Klammerung in Ausdruck

Ein Commit habe ich weggelassen. Zwei Commits zum Thema
"HTML-Darstellung" fasse ich zu Einem zusammen (Befehl `squash`).
Das Commit mit dem Bugfix habe ich nach hinten geschoben.
Mit dem `edit`-Befehl zeige ich an, dass das Commit
noch einmal manuell überarbeiten möchte.

Sobald ich die Änderungen speichere führt Git alle Commits
entsprechend den Befehlen in der angegebenen Reihenfolge
noch mal neu aus. Dabei entstehen frische Commits mit
anderen Commit-Hashes aber gleichem Inhalt. Aus den 4
alten Commits werden 3 Neue.

Auf diese Weise kann seine Commits verdichten, sinnvoll
kommentiern und strukturieren, bevor man sie mit
seiner Mitwelt teilt.

Tipps
-----

Keine Angst! Wenn man sich mal vertan hat, kann man
das Rebasing leicht wieder rückgängig machen: Mit
`git log --walk-reflogs` nachsehen, welches die letzte
"gute" Version war und dann z. B. mit
`git reset --hard HEAD@{2}` wieder zurücksetzen.

Es empfiehlt sich nur solche Commits zu überarbeiten,
die man lokal erstellt und noch nicht mit anderen
geteilt hat (per `git push`).

Unterbrochene Rebasings könne mit `git rebase --abort`
abgebrochen werden.

Nützlich ist die Option `--autosquash`, die
Commits mit gleichem Kommentar automatisch
zusammenfasst.

Die Rebasing-Befehle dürfen abgekürzt werden,
um noch schneller rebasen zu können.

    p 1f23222 HTML-Darstellung verbessern
    s 6b6114a HTML-Darstellung verbessern
    e 1d87986 Bugfix: Falsche Klammerung in Ausdruck
... und Mercurial
-----------------

Mercurial bietet ein Plugin `histedit`, das Ähnliches
verspricht. Ich habe es aber bisher noch nicht gründlich
getestet.

Fazit
-----

Klassische Versionverwaltung dient vor allem der
Archivierung von Softwareversionen.

An Features wie dem Rebasing merkt man, dass Git
mehr will (und kann) als das. Es unterstützt den
Entwickler dabei seine Änderungen so zu sortieren,
zu kommentieren, zusammenzufassen und zusammenzustellen
dass sie für andere andere Entwickler
leichter verständlich werden.
