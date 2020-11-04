<!-- .slide: data-background-image="05/viele-leute.png" -->


## Viele Leute!<br/><br/>


================================================================


## Viele Leute - Probleme

 * Push-Reject
 * Ich will das Zeug nicht sehen
 * Unübersichtliche Historie
 * Branch Garbage



================================================================


### Viele Leute - Push-Reject


```
 ! [rejected]            master -> master (fetch first)
error: failed to push some refs to 'file:///Users/rene/temp/linux.shallow.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

Git macht keine serverseitigen Merges.

Push-Reject verhindert, dass durch Merges Versionsstände
im Server-Repo entstehen, die es nie in einem 
Entwickler-Repo gegeben hat.

notes:

Hier sollte man nicht vergessen, dass Push-Rejects  im Grunde erstmal richtig sind.


================================================================


#### Viele Leute - Push Reject

### Abhilfe: Branch oder Fork 
      
<img src="05/abb-feature-branches-ueberblick.png" width="55%">

note: 


================================================================

#### Viele Leute - Push Reject

### Abhilfe: Branch oder Fork 
      

* Ermöglicht, bis zur Integration unabhängig zu arbeiten
* Nachteile:
  - Probleme treten erst bei Integration auf
  - Langläufer machen CI/CD unmöglich


================================================================


#### Viele Leute - Push Reject

### Abhilfe: Pull-Requests

Integration über Pull-Requests

<img src="05/abb-feature-branches-pr-mergen.png" width="70%" style="background-color: black;">


notes:

Pull-Request bedeutet Server-Seitiges mergen.

Wenn man einfach willenlos auf "Mergen" klickt, umgeht man die Schutzwirkung die von Push-Rejects intendiert ist.

Pull-Request sollten mit Reviews und Buil-Pipeline-Integration genutzt werden.



================================================================


#### Viele Leute - Push Reject
### Abhilfe: Build-Server-Merge 

 1. Build-Server führt **Merge probeweise lokal** durch
 1. Build & Test
 1. *nur* bei Erfolg: Pushen des Merges ins Haupt-Repo
    
-> nur *grüne* Versionen im Haupt-Repo!

================================================================

### Viele Leute - Push Reject
#### Abhilfe: Build-Server-Merge

<img src="05/build-server-merge.png" width="60%" style="border: 0px; box-shadow: none;">

notes:

  - Mittels Server-Hook
  - Mittels Build-Server, z.B. Jenkins


Branch/Fork integrationsreif: 

 1. `checkout master`
 1. `merge <feature-pushed>`
 1. Build & Test
 1. *nur* bei Erfolg
    - `push master`
    - bei Push-Reject automat. Retry

* Das Git Plugin unterstützt diesen automatischen Retry

* Bei gescheitertem merge -> Notification an Entwickler
  - denn es müssen Merge-Konfliket aufgelöst werden
* Bei Build & Test -> Notification an Entwickler
* Bei push -> Automatische Retry


================================================================

#### Viele Leute - Ich will das Zeug nicht sehen
### Abhilfe: Sparse Checkout

> JavaScript kommt mir  
> nicht auf'n Rechner.  
> Ich bin Backend-Developer!

-> **Sparse Checkout**  [siehe oben](#/3/2)


================================================================

<!-- .slide: data-background-image="05/historie-unuebersichtlich.png" -->

### Viele Leute - Unübersichtliche Historie

 * Viele Branches
 * Viele Merges

und das meiste davon interessiert mich nicht.


notes: 

     # repo grails-core
     git log --oneline --graph --color | less -r --chop-long-lines
     # ab f46ba56cb



================================================================
<!-- .slide: data-background-image="05/historie-module.png" -->

#### Viele Leute - Unübersichtliche Historie

### Abhilfe: `log` filtern 

Historie auf Modul beschränken

```bash
git log --follow -- module-a/
```

notes:

Funktioniert idR. auch mit Umbenennungen,  
wenn die Dateien ursprünglich mal woanders lagen.

     # repo grails-core
     git log --oneline --graph --color -- grails-web-url-mappings  | less -r --chop-long-lines
     # ab f46ba56cb




================================================================
<!-- .slide: data-background-image="05/history-by-decoration.png" -->

#### Viele Leute - Unübersichtliche Historie

### Abhilfe: `log` filtern (2)

Nur Integrationen auf dem `master` zeigen:

```bash
git log --first-parent master
```

Nur Zusammenhänge zwischen Commits zeigen, die Tags oder Branches haben:

```bash
git log --simplify-by-decoration
```

notes:

Funktioniert idR. auch mit Umbenennungen,  
wenn die Dateien ursprünglich mal woanders lagen.

</div>


================================================================


#### Viele Leute - Unübersichtliche Historie

### Abhilfe: Squashen

Benutzen von Squash-Merge (o. Ä.) beim Pull-Request.


```bash
git merge --squash feature-a
```

```
  D---E---F       <- 3 Commits verschwinden
 /
A---B---C---M     <- M enthält die Änderungen von D,E,F
```
    


================================================================
<!-- .slide: data-background-image="05/branches.png" -->


#### Viele Leute - Unübersichtliche Historie

### **Hypothese**: Die gibt's nicht ...  
### ... so oft.

Anfangs, wird wild umher gebrancht.

Nach einer Weile etablieren sich pragmatische Workflows, und der Graph glättet sich.
 
notes:

Wenn man einen guten Workflow gefunden hat, erledigt sich dieses Problem manchmal von selbst.

Habe lange auf Github nach einem Projekt gesucht, welches einerseits well-known ist und andererseits eine häßlich verstrickte Historie hat.


================================================================

#### Viele Leute - Zu viele Branches

### Abhilfe: Ordnung schaffen

Präfixe je Module oder Team definieren:  
`/team-a/feature/4711`

```bash
git branch -r --list /teams/*
git branch -r --list */feature/*
```
  
================================================================


#### Viele Leute - Zu viele Branches

### Abhilfe: Nur selektiv Branches holen

Refspec für Fetch konfigurieren

```
[remote "origin"]
url = <repo-url>
fetch = +refs/heads/master:refs/remotes/origin/master
fetch = +refs/heads/team-a/*:refs/remotes/origin/team-a/*
```  
  
Achtung: `gitnamespaces` sind nicht geeignet


================================================================


#### Viele Leute - Zu viele Branches

### Abhilfe: Branches aufräumen

* Automatisches `fetch --prune`
  
```bash
git config fetch.prune true
```

  * Alte Branches finden

```bash
git branch -r --no-merged

git log --no-merges -n 1 --format="%ci" <branch>
```


================================================================
<img src="05/ueberblick-viele-leute.png" width="90%" style="border: 0px; box-shadow: none;">
