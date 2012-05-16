---
layout: post
title: "Unglücke mit <tt>push --force</tt> in Git"
description: "push --force"
category:
tags: [force, push, Trouble Shooting]
---
{% include JB/setup %}

Nach einem "*Vorfall*" in einem befreundeten Projekt wurde ich gefragt,
ob wir in unserem Buch denn auch vor "`push` mit `-f`" warnen.
Für einen kurzen Augenblick stieg der Puls:
Hatten wir das tatsächlich übersehen?
Ein kurzer Blick ins Inhaltsverzeichnis beruhigte mein Gewissen.
Auf Seite 79 (ganz unten) wird ordnungsgemäß vor `-f` gewarnt.
Für all jene, die Seite 79 vielleicht nicht mit der vollen Aufmerksamkeit
gelesen haben, gibt's hier ein paar Tipps, was man tun kann, falls 
man sich mal "*verpushed*".

Nach dem `push --f`: Was genau ist passiert?
--------------------------------------------

Wie viele andere Befehle auch hat der `push`-Befehl in Git eine Option `-f` 
bzw. `--force`. Es ist selten  gute Idee, diese zu nutzen. 

 * **Vorher**
   <pre>
   --O---A---F1---F2  origin/master
          \
           M1---M2  master   
   </pre>
   
 * **Push!**

   <pre>$ push -f               # Hoppla, das war nicht gewollt!</pre>

 * **Nachher**
   <pre>
   --O---A---F1---F2  "Abgeschnitten!"
          \
           M1---M2  master, origin/master   
   </pre>

Etwas unerfreuliches ist passiert:
Features, die in den Commits und `F1` und `F2`
implementiert wurden, sind plötzlich verschwunden.
Auf Überraschungen dürfen sich jetzt jene Entwickler gefasst machen,
die diese Features gebaut haben. Mit etwas Pech dürfen sie beim nächsten
`pull` Commits mergen, die sie schon längst abgeliefert haben.
Vollends verwirrt aber werden jene Entwickler sein,
die auf Basis von `F1` oder `F2` weitere andere Features entwickelt haben.
Ihnen kann es passieren, dass sie beim `pull` einen Merge-Konflikt erhalten,
bei dem Änderungen aus `F1` oder `F2` als *eigene Änderungen* angezeigt werden,
obwohl sie von jemand anderem implementiert wurden.

Trotz allem: *Don't Panic!*
---------------------------

Git wird mit Handtuch ausgeliefert. 
Es ist unwahrscheinlich, dass wirklich etwas verloren gegangen ist.
Zwar sind einige Commits im Hauptrepository nicht mehr sichtbar,
wenn man `git log` ausführt, aber

 * sie sind sehr wahrscheinlich immer noch im da 
   und bleiben es auch, mindestens bis Git das nächste 
   *Garbage Collect* durchführt.
   
 * Git ist dezentral. Sehr wahrscheinlich gibt es Kopien der Commits
   auf den Rechnern der Entwickler, die diese Commits erstellt oder
   bereits gepulled haben.
   
 * wenn das Repository
   [richtig konfiguriert ist](/2012/05/09/reflog-fuer-bare-repositorys-in-git-einrichten),
   führt Git Buch über alle Änderungen an Branches und Tags (genannt *Reflog*),
   so dass man Verlorenes leicht wieder finden kann.
   
Herausfinden welcher Zweig abgeschnitten wurde
----------------------------------------------

Die Meldung nach dem `push --force` zeigt mir, was ich übergebügelt habe.

	$ git push -f                      # Hoppla, das war nicht gewollt!
	
	Counting objects: 4, done.
	Delta compression using up to 2 threads.
	Compressing objects: 100% (2/2), done.
	Writing objects: 100% (3/3), 284 bytes, done.
	Total 3 (delta 1), reused 0 (delta 0)
	Unpacking objects: 100% (3/3), done.
	To /Users/stachi/tmp/blubber/kapitel26.git/
	 + 2450384...24ffa63 master -> master (forced update)

Jetzt sehe also, dass `master` vorher auf `2450384` gezeigt hat
und jetzt auf `24ffa63` verweist.

Commits holen
-------------

Das Problem ist nur, dass genau dieses Commit `2450384` in meinem lokalen
Repository vorhanden ist. Mit einem `fetch` (oder `pull`) 
kann ich es nicht holen, weil kein Branch mehr darauf zeigt.
Deshalb klone ich:

	$ git clone ich@woauchimmer.de:repo
	$ cd repo

Falls **mehrere Branches** betroffen sind (siehe unten), 
muss man die folgenden Schritte jeden Branch einmal durchführen.

Lösung 1: Änderungen zusammenführen
-----------------------------------

Im Beispiel ist das Commit `2450384` betroffen. Wir versuchen, die
Änderungen zusammenzuführen:

	$ git checkout master
	$ git merge 2450384

Falls Git dabei `Already up-to-date.` meldet, hat man Glück gehabt,
und muss es bleibt nichts weiter zu tun.
Anderenfalls muss den Konflikt ganz normal lösen.
Pech hat man, wenn Git
`fatal: '2450384' does not point to a commit` meldet, dann muss man
sich auf die Suche nach einem Repository begeben, in dem das Commit
noch vorhanden ist. Nach dem Merge kann man die Änderungen hochladen.

	$ git push origin master

Lösung 2: Den vorigen Stand wiederherstellen
--------------------------------------------

Falls die neuen Änderungen (bis `24ffa63`) verworfen werden sollen,
kann man auch den vorigen Stand wieder herstellen.

	$ git reset --hard 2450384
	$ git push --force origin master

Aber **Achtung!** `--force` hat seine Tücken ;-)
Wenn ein andere Entwickler in der Zwischenzeit Änderungen
auf diesem Branch hochgeladen haben, dann `goto 1`.
Man erkennt das, wenn die Push-Meldung zeigt, dass ein
anderes Commit ersetzt wurde, als das was man ersetzen wollte.

Lösung 3: Nochmal überbügeln
----------------------------

Falls ein anderer Entwickler kurz vor dem Unglück "gepulled"
hat, kann man dessen Stand nutzen:

	$ git push --force

Aber **Vorsicht!**: Das kann auch vom Regen in die Traufe führen.

Achtung: Es können viel Branches betroffen sein
-----------------------------------------------

Das Default-Verhalten, wenn man ein `push` ohne weitere Parameter
ausführt, ist wie folgt. Git führt ein "Matching" durch,
es führt das `push` für jeden lokalen Branch aus, 
dem ein gleich benannter Branch im entfernten Repository gegenüber steht.
Es können also viele Branches betroffen sein.

Wer das doof findet kann zweierlei tun: 

 1. `git config push.default upstream`
 2. Sich an der [Diskussion][push discussion]
    über das künftige Default-Verhalten von `push` beteiligen.

Links
-----

 * [Diskussion: Was soll Git beim Push ohne Parameter tun?][push discussion]

[push discussion]: http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694)
