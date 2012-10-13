---
layout: post
title: "Git vs. Mercurial - Geschichtsfälschung (Teil 3)"
category: Git
tags: [Git, Mercurial]
# just to fix a highlightin problem]()
author: bst
---
{% include JB/setup %}

Auf den ersten Blick scheint alles einfach.
Eine Versionsverwaltung muß jeden Stand der Software sicher archivieren,
so dass er auch nach vielen Jahren exakt wieder hergestellt werden kann.

**Was einmal archivert wurde ist für immer und wird *nicht verändert*. Basta!**

Ganz so einfach ist es vielleicht doch nicht. Es gibt Situationen,
da möchte man im Repository aufräumen.

 * Es wurde versehentlich eine Datei mit Passwörten im Klartext eingechecked.
   Die Datei muss raus.

 * Es hat sich Müll angesammelt, z. B. alte experimentelle Branches und nicht fertig
   gestellte Features. Man wünscht sich ein schlankeres Repository, was nur das enthält,
   was heute noch von Interesse ist.

 * Das Repository ist groß geworden und wird immer langsamer, weil es sehr große Dateien
   enthält oder weil es .

 * Das Repository ist defekt. Einige Versionen lassen sich nicht mehr herstellen.

 * Jemand hat sich total "verbranched". Das Repository ist kaputtgespielt und
   muss wieder auf einen brauchbaren Stand gebracht werden.

Das alles eher administrative Probleme. Es gibt aber auch noch eine ganz andere Motivation: *Lesbare Historie*.



* Aufräumen
* Kürzen von Repositorys
* Gebrochenes Repository
* Dateien entfernen
* Fehlerbereinigung 
* 

Manipulation?!
--------------


