---
layout: post
title: "Credential Helper - Passwörter verwalten"
author: rp
category: 
tags: [Git,"credential helper"]
---
{% include JB/setup %}

Wenn man auf Remote-Repositories mit Benutzer und Passwort zugreift, kann man sich mit dem Credential Helper von Git das Leben einfacher machen.
Der Credential Helper merkt sich die Benutzerdaten und unterdrückt die jeweilige Abfrage beim Remote-Zugriff.

Unix-Systeme
------------

Der **cache**-Credential Helper ist auf Unix-Betriebssystem einsetzbar und merkt sich die Daten für eine gewisse Zeit im Speicher. Zum Aktivieren muss folgender Befehl verwendet werden:

	git config --global credential.helper 'cache --timeout=300'

Windows-Systeme
---------------

Für Windows gibt es einen eigenen Credential Helper: **wincred**. Dieser nutzt die Credential-Verwaltung die seit Windows Vista enthalten ist (Der Internet Explorer nutzt den gleichen Storage um Passwörter für Webseiten abzulegen.).

Leider ist der **wincred** Credential Helper noch nicht automatisch bei der msysgit-Installation enthalten.
Man muss diesen separat herunterladen: [git-credential-wincred.zip](https://github.com/downloads/msysgit/git/git-credential-wincred.zip)
 * Die Zip-Datei muss entpackt werden.
 * Die Datei "git-credential-wincred.exe" muss nach GIT_HOME/libexec/git-core kopiert werden
 * Abschliessend muss der Helper nur aktiviert werden:

		git config --global credential.helper wincred

MacOS - Systeme
----------------

Auch für MacOS gibt es einen eigenen Credential Helper: **osxkeychain**. Dieser nutzt die Schlüsselbundverwaltung von MacOS. Auch dieser Credential Helper ist nicht standardmässig installiert und muss separat geladen werden: [git-credential-osxkeychain](http://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain)
 * Die Datei muss nach GIT_HOME/bin kopiert werden. Typischerweise nach */usr/local/git/bin*.
 * Die Datei muss mit Ausführungsrechten versehen werden: 
  		
  		chmod a+x git-credential-osxkeychain

 * Abschliessend muss der Helper wieder aktiviert werden:

		git config --global credential.helper oxskeychain