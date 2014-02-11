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
`.gitignore` als Whitelist (Positivliste), geht das?
====================================================

Die `.gitignore` ist eine Blacklist (Negativliste), d. h. sie gibt an,
welche Dateien man von der Versionierung *ausschließen* möchte. 
Möchte man aber nur wenige Verzeichnisse in einer großen
Verzeichnisbaum mit Git versionieren möchte, 
wäre eine Whitelist praktischer. Geht das?

Kurze Antwort
-------------

**Ja**, aber es ist ein klein wenig umständlich.

Das Beispiel `.gitignore`-Datei, für ein Projekt,
das nur die Verzeichnisse `bob/` und `ada/sub/sub/`
versionieren möchte.

	# .gitignore

	# Erstmal alle Top-Level-Verzeichnisse ignorieren
	/*

	# Top-Level-Verzeichnis bob/ "un-ignorieren"
	!/bob/
	
	# Verzeichnis ada/sub/sub/ schrittweise "un-ignorieren"
	!/ada/
	/ada/*
	!/ada/sub/
	/ada/sub/*
	!/ada/sub/sub/

Etwas längere Antwort
---------------------

Tatsächlich ist die Sache überraschend kompliziert.
	__
	show

	new_repo "repo"
	cd "repo"

gitignore <<-__
	__

	create "ada/d1"
	create "ada/d2"
	create "ada/sub/ds1"
	create "ada/sub/ds2"
	create "ada/sub/sub/dss1"
	create "ada/sub/sub/dss2"
	create "ada/sub/sub/dss3"
	create "ada/sub/sub/sub/dsss1"
	create "bob/a1"
	create "bob/sub/as1"
	create "carl"

	text <<-__
Oft gibt es in einem Projekt Dateien oder Verzeichnisse, die man
nicht versionieren möchte, z. B. generierte Dateien, Editor-Backups
oder lokale Konfigurationen. 
Mit Hilfe der `.gitignore`-Datei kann Dateien ignorieren lassen. 
Diese werde dann bei `git status` nicht angezeigt 
und bei `git add -all` nicht hinzugefügt.

Manchmal gibt es aber auch die Situation, dass man eine große Verzeichnisstruktur
vorliegen hat, davon aber nur einige wenige Dateien und Verzeichnisse
versionieren möchte. Zum Beispiel: Ein `/etc`-Verzeichnis enthält Konfigurationen
für viele Tools. Einige davon sind für mein Projekt relevant und nur Diese
möchte ich versionieren. 
Mit Git ist das (natürlich) auch möglich.
Aber es gibt ein paar kleine Fallstricke dabei.
Wir betrachteh ein Beispiel:
	__

	show_all
	shell 'git status --short --untracked-files=all'

 	text <<-__
Wir wollen nur Dateien `ada/sub/sub` versionieren.
Man könnte für jedes unerwünschtes eine Zeile in
die `.gitignore` eintrage.
Bei großen Projekten könnte das aber mühsam werden. 
Stattdessen können einfach mit einem beherzten `/*/` erstmal 
alle Top-Level-Verzeichnisse aus:
 	__

gitignore <<-__
*/
 	__
	text <<-__
Jetzt großflächig alles ignoriert. 
Wenn wir wollen können wir aber einzelne Dateien
trotzdem in die Versionierung aufnehmen,
denn `git add -f` sticht `.gitignore`
 	__
	shell 'git add -f ada/sub/sub/dss1'
	shell 'git status --short --untracked-files=all'
	text <<-__
Der Nachteil dabei: Das Verzeichnis `ada/sub/sub`
bleib weiterhin unbeobachtet. `git status`zeigt
beispielsweise nicht, dass dorth noch zwei unversionierte
Dateien liegen.

Mit vorangestelltem `!` kann man Dateien oder Verzeichnisse
reaktivieren, die in einer vorigen Zeile der `.gitignore`
ausgeblendet wurden. Also:

 	__
	gitignore <<-__
/*
!/ada/sub/sub/
 	__
	shell 'git status --short --untracked-files=all'
 	text <<-__
WTF! War um ist `/ada/sub/sub/` nicht aktive geworden? 
Es wurde doch in der Zeile mit `/*/` ausgeblendet, oder?
`!`-Ausdrücke müssen sich auf Pfade beziehen, die
in vorigen Zeilen ausgeschlossen wurden.
Und mit `/*` schließt den Pfad `/ada/` 

Aber man kann `/ada/` wieder einblenden:
 	__
	gitignore <<-__
/*
!/ada/
 	__
	shell 'git status --short --untracked-files=all'
 	text <<-__
Das ist nun wieder zuviel. Und jetzt kommt der Trick: 
Wir nehmen mit `/ada/*` alles wieder weg und
fügen dann `!/ada/sub/` wieder hinzu:
	__
	gitignore <<-__
/*
!/ada/
/ada/*
!/ada/sub/
	__
 	text <<-__
Jetzt sind alle Dateien unterhalb von /ada/sub wieder drin!
	__
	shell 'git status --short --untracked-files=all'
 	text <<-__
Und das kann man beliebig tief fortsetzen. 
Weil's so schön war ;-) gleich nochmal:
	__

	gitignore <<-__
/*
!/ada/
/ada/*
!/ada/sub/
/ada/sub/*
!/ada/sub/sub/
	__
	shell 'git status --short --untracked-files=all'
 	text <<-__
Ein wenig seltsam, aber es funktioniert. Typisch Git eben ;-)
	__


end

