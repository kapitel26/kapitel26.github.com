---
layout: post
title: "Die Option --mirror nutzen, um Branches in Git-Repositories aufzuräumen."
category: Git
tags: [Git, Branching, Feature-Branches, Mirror, Clone, Push]
author: bst
---

Ab und zu sollte man sein Repository entrümpeln
(siehe auch [Alte Branches archivieren](/git/2014/03/31/alte-branches-archivieren.rb/index.html)).
Lokal kann man Branches einfach, ändern oder umbenennen. 
Die Änderungen dann mit einzelnen `push`-Aufrufen in ein entferntes Repository 
zu übertragen ist aber umständlich.

Einfacher ist es mit der Option `clone --mirror`: 
Sie spiegelt den Zustand aller lokalen Branches in das Zielrepository. 
Dabei ist es egal, ob die Branches neu angelegt, geändert oder gelöscht wurden. 
Nach dem Aufruf hat das Zielrepository den gleichen Stand für alle Branches 
wie das lokale Repository. 
Man geht wie folgt vor:

 1. Mit `clone --mirror` eine Arbeitskopie erstellen und
 2. dort mit `branch -d` und `branch -m` die Branches bearbeiten und dann
 3. mit `push --mirror` alle Änderungen übertragen.

**Achtung:** Ein `push` von einem `mirror`-Repository ändert man Branches im Zielrepository,
dies hat dieselben Auswirkungen wie ein `push --force`.
Wegen Risiken und Nebenwirkungen lesen die [Packungsbeilage](/git/2012/04/28/push-mit-force-in-git/)
oder fragen sie einen [Experten](/rene/).

### Beispiel

Ein Repository enthält mehrere Branches.

<pre>
remoterepo $ <b>git branch</b>
  branch-a
  branch-b
  branch-c
* master
</pre>
Mit der Option `--mirror` des `push`-Befehls erstellen wir eine Arbeitskopie
des Repositorys.

<pre>
$ <b>git clone --mirror remoterepo localrepo</b>
</pre>
Alle Branches aus 'remoterepo' sind als hier als *tracking Branch* abgebildet.

<pre>
localrepo $ <b>git branch -v</b>
  branch-a 4a04fe3 create file-a
  branch-b b02c2eb create file-b
  branch-c c798950 create file-c
* master   0ec2d33 create file-master
</pre>
Diese Branches können wir jetzt nach Lust und Laune bearbeiten.

<pre>
localrepo $ <b>git branch -f branch-a master       # Zurücksetzen</b>
localrepo $ <b>git branch -D branch-b              # Löschen</b>
localrepo $ <b>git branch -M branch-c moved-c      # Umbenennen</b>
localrepo $ <b>git branch new-branch-d             # Neu anlegen</b>
</pre>
Ein einfaches `push` überträgt alles 
von `localrepo` in das Ursprungsrepository `remoterepo`.

<pre>
localrepo $ <b>git push</b>
</pre>
Die Branches in beiden Repositorys stimmen überein.

<pre>
localrepo $ <b>git branch -v</b>
  branch-a     0ec2d33 create file-master
* master       0ec2d33 create file-master
  moved-c      c798950 create file-c
  new-branch-d 0ec2d33 create file-master
remoterepo $ <b>git branch -v</b>
  branch-a     0ec2d33 create file-master
* master       0ec2d33 create file-master
  moved-c      c798950 create file-c
  new-branch-d 0ec2d33 create file-master
</pre>
