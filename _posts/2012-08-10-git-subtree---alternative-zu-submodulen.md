---
layout: post
title: "git-subtree - Eine Alternative zu Submodulen"
description: "Mit dem subtree-Befehl andere Repositories einbinden"
category: Git
tags: []
author: rp
# just to fix a highlightin problem]()
---
{% include JB/setup %}

Was sind nochmal Submodule ?
--------------------------------

Submodule wurden in Git eingeführt um Repositorys zu verknüpfen.
In einem Hauptrepository kann man unter einem Verzeichnis ein Subrepository einbinden.
Dabei wird in dem Verzeichnis ein normaler Klone des Subrepositorys erzeugt. 
Im Hauptrepository wird sich lediglich die URL zu dem Subrepository und das eingebundene Commit gemerkt.

Welche Probleme gibt es mit Submodulen ?
----------------------------------------
Die Arbeit mit Submodulen erscheint vielen Entwicklern sehr umständlich und fehleranfällig.

Das beginnt schon beim Klonen eines Repositorys mit Submodulen, 
da sind zusätzlich ein `git submodule init` und `git submodule update` notwendig.
Will man eine neue Version eines Submodules einbinden muss man erst innerhalb des Submodules
ein Wechsel des Commits durchführen und anschliessend im Hauptrepository ein neues Commit anlegen.

Wenn Änderungen direkt im eingebundenen Submodulen durchgeführt werden, müssen diese erst durch ein 
separates Commit abgeschlossen werden. Erst dann kann das Commit auf dem Hauptrepository durchgeführt werden. 

Beim `git push` müssen Submodule ebenso separat behandelt werden. Häufig wird das Push 
für ein Submodul vergessen. Beim nächsten Fetch auf dem Hauptrepository bekommen dann andere 
Entwickler eine Fehlermeldung, da das Submodule-Commit nicht gefunden wird.
 
 
Was ist jetzt der Subtree-Befehl ?
----------------------------------
Mit dem `subtree`-Befehl kann man auch ein Subrepository in ein Hauptrepository importieren
und den Inhalt des Subrepositorys unter einem beliebigen Verzeichnis (`--prefix`) einbinden. 

	$ cd my-repos
	$ git subtree add --prefix html5-boilerplate \
		--squash https://github.com/h5bp/html5-boilerplate.git v2.0
	$ git log --oneline --graph

	*   f4663b8 Merge commit '8c7ad50a1ff614f0af931e3819a1ed83c41d7ec7' as 'html5-..'
	|\  
	| * 8c7ad50 Squashed 'html5-boilerplate/' content from commit 8bfbd13
	* a5ade29 init

Im Gegensatz zu Submodulen befinden sich die Dateien komplett im Hauptrepository. 
Dadurch müssen beim Klonen und Arbeiten mit dem Hauptrepository keine besonderen Befehle benutzen werden.
	
Das Subrepository-Verzeichnis kann jederzeit auf eine andere Version des Subrepositorys 
aktualisiert werden.

	$ git subtree pull --prefix html5-boilerplate \
		--squash https://github.com/h5bp/html5-boilerplate.git master
	$ git log --oneline --graph

	*   e84d6e5 Merge commit '7547e36dab36201a5f27f2f5e56fe3412c820175'
	|\  
	| * 7547e36 Squashed 'html5-boilerplate/' changes from 8bfbd13..02bdaea
	* |   f4663b8 Merge commit '8c7ad50a1ff614f0af931e3819a1ed83c41d7ec7' as 'html5-..'
	|\ \  
	| |/  
	| * 8c7ad50 Squashed 'html5-boilerplate/' content from commit 8bfbd13
	* a5ade29 init

Werden Änderungen an den Dateien des Subrepositorys im Hauptrepository durchgeführt, 
können diese durch ein normales Commit festgeschrieben werden. 
 
	$ edit html5-boilerplate/404.html 
	$ git commit -am "typo" 
	$ git log --oneline --graph -3
	
	* 2bc032c typo
	*   e84d6e5 Merge commit '7547e36dab36201a5f27f2f5e56fe3412c820175'
	|\  
	| * 7547e36 Squashed 'html5-boilerplate/' changes from 8bfbd13..02bdaea
 
Anschliessend ist es möglich diese Änderungen in Commits des Subrepositorys zu überführen.

	$ git subtree split --prefix html5-boilerplate --branch html5-boilerplate/changes 

Dabei legt der `subtree`-Befehl für jedes Commit mit Änderungen 
der Subrepository-Dateien ein neues Commit auf Basis der Subrepositorys-Commits an.
Also fast wie beim normalen Rebasing, nur, dass die Verzeichnisstruktur angepasst wird und 
Commits die keine relevanten Änderungen enthalten ignoriert werden. 
Am Ende wird ein neuer Branch angelegt, der auf die neuen Commits zeigt.

	$ git log --oneline --graph -3 html5-boilerplate/changes
	
	* 6b061ad typo
	* 02bdaea Docs: add info about using Metro tiles
	* 5ed4dad Update CHANGELOG

Diesen Branch kann nun ganz normal mit dem originalen Subrepository zusammengeführt werden.
Es ist auch möglich die Änderungen gleich nach dem Split in ein anderes Repository zu übertragen: `subtree push`.

Wann ist der Einsatz des Subtree-Befehls sinnvoll ?
---------------------------------------------------

Wenn man Abhängigkeiten zwischen Modulen ausserhalb des Git-Repositorys 
zu verwalten kann, z.B. mit Maven oder Ivy, sollte man es auch ausserhalb tun. 
Weder Submodule noch Subtrees ersetzen eine einfache Abhängigkeitsverwaltung.

Wenn allerdings der Sourcecode in das eigene Projekt eingebunden werden muss oder häufig gleichzeitige 
Änderungen am eigenem Projekt und an einem Submodul vorgenommen werden muss, dann ist Subtree ein gutes Werkzeug.

Im Vergleich zu Submodulen, ist bei Subtrees das normale Arbeiten weniger umständlich und fehleranfällig:

* Beim Klonen eines Repositorys ist immer alles dabei. Selbst wenn das Submodul irgendwann 
  nicht mehr verfügbar ist, sind alle Sourcen im eigenen Projekt vorhanden.
* Das Aktualisieren auf eine neue Version eines Submodules ist nur ein simpler Befehl.
* Man kann erstmal unkompliziert Änderungen am eingebetteten Submodul vornehmen und später 
  die Änderungen an das Original zurückspielen.

**Tipp**: Man kann übrigens auch den `subtree split`-Befehl nutzen um erstmalig ein Submodul aus einem großen Repository
zu extrahieren. 

Achtung:
--------

Der `subtree`-Befehl ist erst seit dem Release 1.7.11 offizieller Bestandteil 
der Git-Distribution. Allerdings nur optional und nur im `contrib`-Verzeichnis zu finden. 
Für ältere Versionen kann man es als separates Shell-Skript von
[GitHub](https://github.com/apenwarr/git-subtree) laden.
Es gibt leider noch einen Bug mit Annotated-Tags. Dieser Bug wurde bisher nur 
in diesem [GitHub-Commit](https://github.com/amzz/git-subtree/commit/379ad64d3a2871f2331923f3d7969d79ed7b35ee) behoben.
