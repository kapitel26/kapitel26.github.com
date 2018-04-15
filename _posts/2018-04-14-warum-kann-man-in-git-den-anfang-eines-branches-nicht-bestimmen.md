---
layout: post
title: "Wie findet man den Anfang eines Branches in Git?"
category: Git
tags: [Branches]
author: bst
---

## Antwort 1: Gar nicht!

> Im Allgemeinen gar nicht!

Sie können hier aufhören zu lesen.
Außer es interessiert Sie,
warum das so ist,
und wie man Git dennoch ein paar nützliche Informationen entlocken kann.

## Warum ist das so?

Für Git sind Branches lediglich Hilfsmittel,
um auf einander folgende Commits zu erstellen.
Jeder Branch hat einen Zeiger auf ein Commit.
und der `commit`-Befehl setzt,
für den aktiven Branch,
diesen Zeiger auf das neu erstellte Commit.
Das Commit selber *"weiss nicht"*,
auf welchem Branch es erstellt wurde.
Im Commit-Graphen findet man den Branchanfang also nicht.

Branches in Git sind *lokal und temporär*.
Beim `push` in Klone des Repositorys werden nur momentane Zeigerstände übermittelt.
Was vor oder zwischen `push`-Befehlen mit den Branches passiert ist,
erfahren die Klone nicht.

## Antwort 2: Mit dem dem lokalen Reflog!

Für lokale Branches speichert Git ein sogenanntes *Reflog*, in dem alle Änderungen verzeichnet sind.
Falls Sie den Branch in ihrem lokalen Repository angelegt haben,
finden sie den Branchanfang normalerwiese mit dem `reflog`-Befehl (oder der `-g`-Option des `log`-Befehls):

    $ git reflog add-staticman | tail -1
    9afca6d add-staticman@{8}: branch: Created from HEAD

Aber Achtung: Falls der Branch irgendwann durch  `rebase` oder `reset` umgesetzt wurde, kann diese Information irreführend sein.

## Antwort 3: Mit Strukturinformationen!

Im Allgemeinen kann man einem Git-Commit-Graphen nicht ansehen wo abgezweigt und wo integriert wurde.



2. Es braucht nicht mal Branches um zu Verzweigen.
3. Eregebnisse könne auf sehr unterschiedliche weise integriert werden
