---
layout: post
title: "Patches & Bundles - Git-Commits per Mail oder USB-Stick übertragen."
category: Git
tags: [Bundles]
author: bst
---

## Patches per Mail versenden

Git stellt auch einen Mechanismus bereit, um Commits als Patch-Mails zu		
versenden und in ein anderes Repository wieder einzuspielen. Das ist dann ein		
Ersatz für Pull und Push. Die Informationen aus den ursprünglichen Commits, wie		
Autor und Zeitpunkt, bleiben erhalten, Commit-Hashes aber nicht.		

Der `format-patch`-Befehl  erzeugt für jedes Commit im spezifizierten Bereich		
eine eigene Patch-Datei im mbox-Format. Das mbox-Format ist eine Textdatei für		
E-Mails.		

```bash
$ git format-patch rel-1.0.0..HEAD		
0001-a7.patch		
0002-a8.patch		
0003-a9.patch		
0004-a9.patch		
```

Die Dateien kann man jetzt selbst verschicken oder das Ganze durch den		
`send-email`-Befehl von Git erledigen lassen:		

```bash
$ git send-email-to "rp@etosquare.de" *.patch		
```

Der Empfänger kann die E-Mails mit dem `am`-Befehl in sein Repository		
einspielen. Dabei kann man die Patches einzeln auswählen oder per Wildcard alle		
angeben:		

```bash
$ git am 0*.patch		
```

## Bundles - Pull im Offline-Modus

Die beiden vorherigen Abschnitte haben Patches von einem Repository in ein		
anderes übertragen. Möchte man Commits übertragen, dann nutzt man normalerweise		
den `pull`- oder `push`-Befehl. Falls es aber keine direkte		
Verbindung zwischen den Rechnern der beiden Repositorys gibt, kann man		
*Bundles* erzeugen. Bundles enthalten Commits, und auf Bundles kann		
der `fetch`- bzw. `pull`-Befehl angewendet werden.		

Als ersten Schritt erzeugt man mit`bundle create` ein Bundle, das		
alle zu übertragenden Commits enthält:		

```bash
$ git bundle create local.bundle rel-1.0.0..HEAD		
```

Die erzeugte Datei transferiert man zu dem anderen Rechner (z.\,B. per E-Mail		
oder USB-Stick). Dort kann man von dem Bundle, wie von einem anderen		
Repository, Commits importieren.  Hierbei bleiben die Commit-Hashes erhalten.		

```bash
$ git pull local.bundle HEAD		
```
