---
layout: post
title: "Reflog für Bare-Repositorys in Git"
description: ""
category: Git 
tags: []
author: bst
---

{% include JB/setup %}

Das *Reflog* ist dein Freund
----------------------------

Im Reflog wird jede einzelne Änderung an Branches aufgezeichnet
(und auch ein paar weitere Dinge). Was auch immer schiefgegangen ist,
z. B. ein [unglückliches `push`](../../../../2012/04/28/push-mit-force-in-git):
Fast immer lässt es sich mit 
[Hilfe des Reflogs der vorige Stand wiederherstellen.](../../../../2012/05/08/abgeschnittene-commits-zurueckholen)
Es ist also gut, ein Reflog zu haben, aber:

Bare-Repositorys führen oft kein Reflog!
------------------_---------------------

Für gewöhnliche Repositorys mit Workspace ist das Reflog in der Regel
aktiv. Für sogenannte *Bare Repositorys*, die zum Austausch zwischen
Entwicklern genutzt werden, ist Reflog per Default nicht aktiv.
Am besten schalten Sie es gleich ein:

	git config core.logAllRefUpdates true

Oder gleich als Default für die gesamte Installation.

	git config --system core.logAllRefUpdates true

Man kann es auch schon gleich beim Klonen aktivieren:

	git clone --bare --config core.logAllRefUpdates=true ~/work/kapitel26/	

Schutz vor Manipulation der Historie
------------------------------------

Git ermöglicht es, die Historie zu manipulieren. Vielleicht habe ich mich
beim Entwickeln verrannt und möchte die letzten beiden Commits verwerfen 
(`reset --hard head^^`), oder ich möchte eine versehentlich hinzugefügte
Datei mit den Klartextpasswörtern wieder loswerden. Kein Problem mit Git.
Ersteres erledigt ein `reset --hard head^^` erreichen, letzteres
ermöglicht der `filter-branch`-Befehl.

Manchmal möchte man aber genau das nicht. Manchmal möchte man
(oder muss man) die "offizielle" Historie aller Änderungen in einem
zentralen Repository dokumentieren. Man kann ein solches Repository 
durch `denyNonFastForward` schützen. Git akzeptiert neue Commits
dann nur, wenn sie Nachfahren der vorigen Commits sind. Dann kann nichts
verloren gehen (schützt auch vor `push -f`).

	git config receive.denyNonFastForwards true
	
Links
-----

* [Zu diesem Thema: Chris Johnsen auf Stackoverflow][1]

  [1]: http://stackoverflow.com/questions/3876206/how-do-i-view-a-git-repos-recieve-history

