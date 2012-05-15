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
Ein kurzer Blick in Inhaltsverzeichnis beruhigte mein Gewissen. 
Auf Seite 79 (ganz unten) wird ordnungsgemäß vor `-f` gewarnt.
Für all jene, die Seite 79 vielleicht nicht mit der vollen Aufmerksamkeit
gelesen haben, gibt's hier ein paar Tipps, was man tun kann, falls 
man sich mal "*verpushed*" .

Nach dem `push --f`: Was genau ist passiert?
-----------------------------

Wie viele andere Befehle auch hat der `push`-Befehl in Git eine Option `-f` 
bzw. `--force`. Es ist selten  gute Idee, diese zu nutzen. 

 * Vorher 
   <pre>
   --O---A---F1---F2  origin/master
          \
           M1---M2  master   
   </pre>
   
 * Push!
 
   <pre>$ push -f               # Hoppla, das war nicht gewollt!</pre>

 * Nachher 
   <pre>
   --O---A---F1---F2  "Abgeschnitten!"
          \
           M1---M2  master, origin/master   
   </pre>

Etwas unerfreuliches ist passiert: Features, die mit `F1` und `F2`
implementiert wurden, sind plrözlich verschwunden.
Auf Überraschungen dürfen sich jetzt jene Entwickler gefasst machen,
die diese Features gebaut haben. Mit etwas Pech dürfen sie beim nächsten 
`pull` erneut mergen, was sie schon längst abgeliefert haben.
Vollends verwirrt aber werden jene Entwickler sein,
die auf Basis von `F1` oder `F2` ganz andere Features entwickelt haben.
Ihnen kann es passieren, dass sie beim `pull` einen Merge-Konflikt 
erhalten, bei dem Änderungen aus `F1` oder `F2`
als *eigene Änderungen* angezeigt werden, obwohl
sie von jemand anderem implementiert wurden.

Trotz allem: *Don't Panic!* 
---------------------------

Git wird mit Handtuch ausgeliefert. Es ist unwahrscheinlich, 
dass wirklich etwas verloren gegangen ist.
Zwar sind einige Commits im Hauptrepository nicht mehr sichtbar,
wenn man `git log` ausführt, aber

 * sie sind aber sehr wahrscheinlich immer noch im da 
   und bleiben es auch, mindestens bis Git das nächste 
   *Garbage Collect* durchführt.
   
 * Git ist dezentral. Sehr wahrscheinlich gibt es Kopien der Commits 
   auf den Rechnern der Entwickler, die diese Commits erstellt oder 
   bereits gepulled haben.
   
 * wenn das Repository
   [richtig konfiguriert ist](/2012/05/09/reflog-fuer-bare-repositorys-in-git-einrichten),
   führt Git Buch über alle Änderungen an Branches und Tags (genannt *Reflog*),
   so dass Verlorenes leicht wieder finden kann.
   
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

Jetzt weiß ich also, dass `master` vorher auf `2450384` gezeigt hat.

Commits holen
-------------

Das Problem ist nur, dass dieses Commit wahrscheinlich noch gar nicht
in meinem lokalen Repository vorhanden ist. Mit einem `fetch` (oder
`pull`) kann ich es nicht holen, weil kein Branch mehr darauf zeigt.
Deshalb

	$ git clone ich@woauchimmer.de:repo
	$ cd repo

Falls **mehrere Branches** betroffen sind, muss man die folgenden Schritte 
mehrfach durchführen.

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

	$ git push
	
Lösung 2: Vorigen Stand wieder herstellen
-----------------------------------------

Falls die neuen Änderungen (bis `24ffa63`) verworfen werden sollen,
kann man auch den vorigen Stand wieder herstellen.

	$ git reset --hard 2450384
	$ git push --force
		
Aber **Achtung!** Wenn andere Entwickler in der Zwischenzeit Änderungen
hochgeladen haben, dann `goto 1`



	
	
   In diesem Fall ist das 
   
 
Lösung 2: Ersetze Alt durch Neu
------------------------------- 
   
Brach ohne Merge zurücksetzen


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

 * [How do i view a git repos receive history][1]
 * wurstbrot
  
  [1]: http://stackoverflow.com/questions/3876206/how-do-i-view-a-git-repos-recieve-history "asfd"
  [2]: http://stackoverflow.com/questions/6140083/how-to-create-reflogs-information-in-an-existing-bare-repository
  [3]: http://sitaramc.github.com/concepts/reflog.html
  [4]: http://gitready.com/intermediate/2009/02/09/reflog-your-safety-net.html
  [5]: http://de.gitready.com/advanced/2009/01/17/restoring-lost-commits.html
  [push discussion]: http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694)
