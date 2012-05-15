---
layout: post
title: "Reparaturen nach <tt>push --force</tt> ohne Zugriff auf das Reflog"
description: "-"
category: 
tags: []
---
{% include JB/setup %}

Leider gibt es Situationen, in denen man
[reparieren möchte](/2012/04/28/oops-push-mit---force-in-git),
aber [ein Reflog fehlt](/2012/05/09/reflog-fuer-bare-repositorys-in-git-einrichten)
oder nicht erreichbar ist.

Erstmal sichern
---------------

Falls man direkten Zugriff auf den Server mit dem  Ziel-Repositorys 
des verunglückten `push` hat, sollte man das Repo sichern. 
So verhindert man, dass die abgeschnittenen Commits durch
ein `git gc` (oder ähnliches) doch noch gelöscht werden.
Am besten sichert man mit `cp`und nicht mit `git clone`
(weil `clone` abgeschnittene Commits nicht kopiert).

Rohe Gewalt oder Mutter der Porzellankiste
------------------------------------------

Falls ein Entwickler kurz vor dem unseeligen `push` ein `pull` ausgeführt hat,
kann man überlegen, ob man mit einem beherzten `push --force` einen
"besseren" Stand in das Repository bring, damit andere Entwickler erstmal 
weiter arbeiten können.

Sicherer ist, die anderen Entwickler aufzufordern, kein `push` durch-
zuführen, bis das Repo aufgeräumt ist. Ggf. kann man das gemeinsame
Repository sperren (bei einer ssh-basierten Einrichtung, genügt dazu
ein einfaches `mv` an einen Ort).

Wiederfinden abgeschnittener Commits
------------------------------------

Durch das `push --force` sind Commits abschnitten worden (*Dangling Commits*)
im Beispiel `F1` und `F2`.
Sie liegen zwar noch im Repository, aber es gibt keinen Branch mehr, in
dessen Historie diese Commits enthalten sind.

  <pre>
  --O---A---F1---F2  "Abgeschnitten!"
         \
          M1---M2  master, origin/master   
  </pre>

Es gibt mehrere Möglichkeiten, solche Commits wieder zu finden:

 * das Reflog

Hat man Zugriff auf das Reflog des Ziel-Repositorys, ist es leicht, den
vorherigen Stand zu finden, und das Problem zu beheben.
[Ohne Zugriff auf auf das Reflog](/2012/05/08/reparaturen-nach-push--force-ohne-zugriff-auf-das-reflog),
ist es schwerer.
  
	$ git log --walk-reflogs --date=iso master

	commit 03aacfa668b36bc0f5d03195aff2ae2a8bf917c7
	Reflog: HEAD@{2012-05-02 22:04:56 +0200} (bstachmann)
	Reflog message: push
	Author: bstachmann
	Date:   2012-05-02 22:04:44 +0200
	
	    M2
	
	commit 5276d1cc8e730043c73fbcf17b281518d6b93f10
	Reflog: HEAD@{2012-05-02 22:03:37 +0200} (bstachmann)
	Reflog message: push
	Author: bstachmann
	Date:   2012-05-02 22:03:26 +0200
	
	    F2

	...

Im Beispiel ist `5276d1cc` die Version, die "übergebügelt"
wurde. Wir merken uns diese Version unter dem Namen 
`old-master`.

    $ git branch old-master 5276d1cc

Die eigentliche Reparatur kann man dann in einem beliebigen
Klon des 
    
    $ git fetch origin master old-master
    $ git checkout master
	$ git merge old-master
	$ git push


 
 * git fsck
 
    <pre>
	$ git fsck --lost-found
	dangling commit 24503845dfa44353e5ebd64dc75183823538e85f
	dangling commit fdb36f69a12d16bf345d29c69057115ed19ac96a
    </pre>
 
 * Informationen aus Client-Repositorys
   * Das Reflog von Client-Repositorys
   * Branches und Tags

  [1]: http://stackoverflow.com/questions/3876206/how-do-i-view-a-git-repos-recieve-history "asfd"
  [2]: http://stackoverflow.com/questions/6140083/how-to-create-reflogs-information-in-an-existing-bare-repository
  [3]: http://sitaramc.github.com/concepts/reflog.html
  [4]: http://gitready.com/intermediate/2009/02/09/reflog-your-safety-net.html
  [5]: http://de.gitready.com/advanced/2009/01/17/restoring-lost-commits.html
