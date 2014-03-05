# encoding: UTF-8

samplename = 'gitignore-positivliste'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

def gitignore content
	create ".gitignore", content
	text <<-__
<pre><code># .gitignore
#{content}</code></pre>
	__
end

@demo.section do

	text <<-__
---
layout: post
title: "Whitelists mit gitignore"
category: Git
tags: [Git, ignore, gitignore, whitelist]
author: bst
---

	__

	text <<-__
`.gitignore` als Whitelist, geht das?
=====================================

`.gitignore` ist eine Blacklist (Negativliste), d. h. sie gibt an,
welche Dateien man von der Versionierung *ausschließen* möchte. 
Wenn man aber nur wenige Verzeichnisse in einer großen
Verzeichnisbaum mit Git versionieren möchte, 
dann wäre eine Whitelist praktischer. Geht das auch?

	__
	hide_all do
		new_repo "repo"
		cd "repo"

		create "a1/file-a1"
		create "a1/a2/file-a2"

		create "b1/file-b1"
		create "b1/b2/file-b2"
		create "b1/b2/b3/file-b3"
		create "b1/b2/b3/b4/file-ab4"
		
		create "file-c1"
	end


	text <<-__
Kurze Antwort
-------------

**Ja**, aber es ist ein klein wenig umständlich.
Die folgende `.gitignore`-Datei zeigt, wie
es geht:
	__

	gitignore <<-__
# Erstmal alles ignorieren
*

# Verzeichnis /a1/ "un-ignorieren"
!/a1/
!/a1/**

# Verzeichnis /b1/b2/b3/ "un-ignorieren"
!/b1/
!/b1/b2/
!/b1/b2/b3/
!/b1/b2/b3/**
	__

	hide_all { shell 'git status --short --untracked-files=all' }

	text <<-__

Etwas längere Antwort
---------------------

Tatsächlich ist die Sache überraschend kompliziert.

Oft gibt es in einem Projekt Dateien oder Verzeichnisse, die man
nicht versionieren möchte, z. B. generierte Dateien, Editor-Backups
oder lokale Konfigurationen. 
Mit Hilfe der `.gitignore`-Datei kann solche Dateien ignorieren lassen. 
Diese werde dann mit `git status` nicht mehr angezeigt 
und bei `git add -all` nicht hinzugefügt.

Manchmal gibt es aber auch die Situation, dass man eine große Verzeichnisstruktur
vorliegen hat, davon aber nur einige wenige Dateien und Verzeichnisse
versionieren möchte. Zum Beispiel: Ein `/etc/`-Verzeichnis enthält Konfigurationen
für viele Tools. Einige davon sind für mein Projekt relevant und nur Diese
möchte ich versionieren. 
Mit Git ist das (natürlich) auch möglich.
Aber es gibt ein paar kleine Fallstricke dabei.

### Beispiel
	__

	hide_all { gitignore "" }
	show_all
	shell 'git status --short --untracked-files=all'

 	text <<-__
Wir wollen nur Dateien unterhalb von  `/a1/` und `/b1/b2/b3/` versionieren.
Man könnte jedes unerwünschte Verzeichnis in die `.gitignore` eintragen,
dann bliebe übrig, was man möchte.
Bei großen Projekten kann das aber mühsam sein und müsste auch ständig
nachgepflegt werden, wenn neue Verzeichnisse hinzukommen.

Stattdessen können einfach mit einem beherzten `*` erstmal alles ausschließen, 
um dann später Verzeichnisse, die man versioneren möchte, zu *un-ignorieren*.
 	__

gitignore <<-__
*
 	__
	text <<-__
Wenn wir wollen können einzelne Dateien
trotzdem in die Versionierung aufnehmen,
denn `git add -f` sticht `.gitignore`
 	__
	shell 'git add -f b1/b2/b3/file-b3'
	shell 'git status --short --untracked-files=all'
	hide_all do
		shell 'git reset -- b1/b2/b3/file-b3'
	end
	text <<-__
Der Nachteil dabei: 
Das Verzeichnis `/b1/b2/b3/`
bleibt weiterhin unbeobachtet. `git status` zeigt beispielsweise nicht, 
wenn dort noch neue unversionierte Dateien auftauchen.

Mit vorangestelltem `!` können ausgeblendete 
Dateien und Verzeichnisse laut Manual-Page *un-ignoriert* werden:
 	__
	gitignore <<-__
*
!/b1/b2/b3/
 	__
	shell 'git status --short --untracked-files=all'
 	text <<-__
WTF! Warum ist `/b1/b2/b3/` nicht wieder aktiv geworden?
Laut Dokumentation wirkt `!` auf Pfade,
die in vorigen Zeilen ausgeblendet wurden.
Das Verzeichnis `/b1/b2/b3/` wurde doch in der Zeile mit dem  `*` ausgeblendet, oder?
Warum ist sie dann jetzt nicht wieder sichtbar?
Tatsächlich wurde durch `*` das Verzeichnis `/b1/` ausgeschlossen.
Die darunter liegenden Verzeichnisse wurden nur implizit mit ausgeschlossen.

Was wir tun können, ist: Zuerst mit `/b1/` das Verzeichnis
wieder zurückholen. Und dann mit `/b1/**` dafür sorgen,
dass auch alle Dateien und Verzeichnisse darunter wieder sichtbar werden 
(diese waren ja ebenfalls durch `*` ausgeschlossen)
 	__
	gitignore <<-__
*
!/b1/
!/b1/**
 	__
	shell 'git status --short --untracked-files=all'
 	text <<-__
Jetzt sind alle Dateien unterhalb von `/b1/` wieder drin!
Und das kann man beliebig tief fortsetzen. 
Weil's so schön war ;-) gleich nochmal:
	__

	gitignore <<-__
*
!/b1/
!/b1/b2/
!/b1/b2/b3/
!/b1/b2/b3/**
			__
	shell 'git status --short --untracked-files=all'

	text <<-__
Ein wenig seltsam, aber es funktioniert. Typisch Git eben ;-)

### Wozu die vielen Slashes?

In unserem Beispiel würde es auch ohne Slashes am Anfang und Ende der Pfade gehen.
	__

	gitignore <<-__
*
!b1
!b1/b2
!b1/b2/b3
!b1/b2/b3/**
	__

	text <<-__
Ganz korrekt wäre das aber nicht, denn Slashes
am Anfang sorgen dafür, dass nur Pfade die so beginnen
*matchen*. Slashes am Ende sorgen dafür, dass nur
Verzeichnisse *matchen*.
	__
	create "b1/b1/b1/b1"
	shell 'git status --short --untracked-files=all'


 

end

