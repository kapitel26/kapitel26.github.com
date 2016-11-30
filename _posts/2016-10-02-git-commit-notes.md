---
layout: post
title: "Git Notes Notizen an Commits"
category: Git
tags: [Bundles, "Änderungen zur 4. Auflage"]
author: bst-rp
---

Commits sind in Git unveränderbar. Man kann zwar Commits kopieren und dabei ändern, doch dann entsteht ein neues Commit. Möchte man Commits nachträglich mitKommentaren versehen, stehen \stichwort{Notes} zur Verfügung. Notes werden	meistens von Entwicklungswerkzeugen genutzt, um Commits zu markieren.		

Der `notes add`-Befehl erzeugt einen neuen Kommentar an einem Commit:		

```bash
$ git notes add "Mein Kommentar" HEAD		
```

Mit dem `notes show`-Befehl kann der Kommentar wieder angezeigt werden:		

```bash
$ git notes show HEAD		
```

**Achtung:** Notes werden nicht automatisch beim Push oder Pull zwischen Repositorys übertragen. Es gibt auch leider keinen einfachen Parameter,
um das zu erreichen. Die folgenden beiden Kommandos	zeigen beispielhaft, wie Notes übertragen werden:

```bash
$ git push origin refs/notes/*:refs/notes/*		
```

```bash
$ git fetch origin refs/notes/*:refs/notes/*		
```
