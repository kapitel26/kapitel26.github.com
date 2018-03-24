---
layout: post
title: "Andere Versionsverwaltungen parallel nutzen"
category: Git
tags: [CVS, Subversion, "Änderungen zur 4. Auflage"]
author: bst-rp
---

Im Unternehmen oder Team wird mit einer zentralen
Versionsverwaltung gearbeitet. Einzelne Entwickler arbeiten mit
Git und synchronisieren die Änderungen mit dem zentralen System.

In vielen Unternehmen und Organisationen ist das Werkzeug für
die Versionierung und die zugehörigen Prozesse zentral vorgegeben.
Einzelne Projekte und Teams können nicht einfach eine andere Versionsverwaltung, z. B. Git, benutzen.
Der unternehmensweite Umstieg auf Git erfordert Machbarkeitsstudien, strategische Entscheidungen, Migrationspläne etc. - also viel Zeit.

Trotz allem ist es möglich, einige Fähigkeiten von Git in der lokalen Entwicklungsumgebung zu nutzen und die Ergebnisse mit der zentralen Versionsverwaltung zu synchronisieren.

Bei einer lokalen Benutzung bietet Git die folgenden Vorteile:

 *  Auch wenn gerade kein Zugriff auf die zentrale Versionsverwaltung
	besteht, sind lokale Commits möglich.
 *  Feingranulare Commits, auch von Zwischenständen, können durchgeführt
	werden. Die Versionierung dient als Sicherheitsnetz während der Entwicklung.
 * Lokale Branches für Prototypen und Feature-basiertes Arbeiten sind möglich.
 *  Die gute Merge- und Rebasing-Unterstützung von Git kann genutzt werden.

Dieser Workflow zeigt, wie ein lokales Git-Repository und eine zentrale Versionsverwaltung so zusammenarbeiten können, dass

 * Änderungen in der zentralen Versionierung in das lokale Repository
	eingespielt werden und
 * lokale Änderungen in die zentrale Versionierung übertragen werden.

Fü die Anbindung an [Subversion](http://subversion.apache.org/) gibt
	es den `git-svn`, sodass dieser Workflow nicht benötigt wird.

## Voraussetzungen

  * **Optimistisches Locking:**  Die zentrale
    Versionsverwaltung muss optimistische Zugriffe auf Dateien  unterstützen,
    d. h.,
    Dateien können ohne vorherige Sperren verändert werden.

  * **Ignorieren von Dateien und Verzeichnissen:** Die zentrale
    Versionsverwaltung kann Dateien und Verzeichnisse von der
    Versionierung ausschließen.

  * **Flexibilität des Projektverzeichnisses:** Die Entwicklungswerkzeuge
    (z. B. Build-Tools) erzwingen nicht,
    dass das Projekt an genau einem Ort im Dateisystem abgelegt wird.

## Überblick

Um die Zusammenarbeit von Git und einer zentralen Versionsverwaltung zu
beschreiben, nutzen wir [CVS](http://www.nongnu.org/cvs/).
Der prinzipielle Ablauf funktioniert in anderen zentralen Versionsverwaltungen genauso.

![Bisection Überblick](/assets/2016-10-02-parallel-mit-zentralem-vcs/abb-parallel-mit-zentralen-vcs-ueberblick.png)

In der Abbildung ist oben der
zentrale CVS-Server zu sehen und darunter sind die Repositorys auf dem Rechner des Entwicklers dargestellt.

Der Entwickler hat zwei lokale Git-Repositorys: ein *Sync-Repository*,
das nur zum Synchronisieren mit der zentralen Versionsverwaltung dient,
und ein *Arbeits-Repository*,
in dem die eigentliche Entwicklung stattfindet.

Das Sync-Repository ist mit der zentralen Versionsverwaltung (`CVS`-Verzeichnisse) verbunden und beinhaltet parallel die Git-Objekte (`.git`~Verzeichnis).
Die zentrale Versionsverwaltung ist so konfiguriert,
dass die Git-Objekte ignoriert werden (`.cvsignore`-Datei) und Git die Metadaten von CVS (`.gitignore`-Datei) ignoriert.

Veränderte Dateien der zentralen Versionsverwaltung werden als Erstes
in das Sync-Repository eingespielt (`cvs update`). Anschließend wird ein
neues Git-Commit im `cvs`-Branch angelegt. Dieses wird danach in das
Arbeits-Repository importiert (`fetch`) und anschließend durch einen Merge mit dem
`master`-Branch vereinigt.

Um die lokalen Änderungen des
`master`-Branch in die zentrale Versionsverwaltung einzuspielen,
werden die neuen Commits des `master`-Branch in das Sync-Repository übertragen (`push`).
Dort wird anschließend ein Merge des `cvs`-Branch mit dem `master`-Branch durchgeführt.
Danach werden die geänderten Dateien in die zentrale Versionsverwaltung
eingespielt (`cvs commit`).


## Ablauf und Umsetzung

Folgende Informationen benötigen Sie von Ihrer zentralen Versionsverwaltung:

 * Wie werden die Quellen aus Ihrer Versionsverwaltung initial geholt? -  `cvs checkout`
 * Wo und wie werden die Metainformationen im Dateisystem abgelegt? -  `CVS`-Verzeichnisse
 * Wie kann man Dateien von der Versionierung ausschließen? -  `.cvsignore`-Datei
 * Wie werden Aktualisierungen von der zentralen Versionierung geholt? -  `cvs update`
 * Wie werden neue Dateien zu Ihrer Versionsverwaltung hinzugefügt? -  `cvs add`
 * Wie werden Änderungen in die zentrale Versionierung übertragen? -  `cvs commit`

### Initiales Einrichten der Repositorys

Die folgenden Schritte zeigen, wie das Sync-Repository und das
Arbeits-Repository initial eingerichtet werden. Der Ausgangspunkt ist ein lokal
vorhandenes CVS-Projekt (`cvsprojekt`), das mit `cvs checkout`
angelegt wurde.


#### 1. Neues Sync-Repository anlegen

Als Erstes wird im CVS-Projektverzeichnis ein neues Git-Repository initialisiert:

```bash
cd cvsprojekt
git init
```

#### 2. `.gitignore`-Datei konfigurieren

In das Sync-Repository sollen alle Dateien -  bis auf die CVS-Meta\-daten -
importiert werden.
Deswegen  müssen die `CVS`-Verzeichnisse
in der Datei `.gitignore` ausgeschlossen werden:

```bash
echo CVS/ > .gitignore
```

Der `echo`-Befehl erzeugt eine neue Datei `.gitignore` mit dem Inhalt
`CVS/``.

#### 3. `.cvsignore`-Datei konfigurieren

Auch die zentrale Versionsverwaltung soll nicht die Metainformationen von Git
versionieren. Deswegen muss man das `.git`-Verzeichnis und die
`.gitignore`-Datei ausschließen. In CVS funktioniert das, indem man zu der
Datei `.cvsignore` die Einträge `.git` und `.gitignore` hinzufügt
bzw. eine neue Datei anlegt:

```bash
echo .git >> .cvsignore
echo .gitignore >> .cvsignore
```

Falls die `.cvsignore`-Datei bisher nicht existierte,
wird sie automatisch angelegt und muss dann mit `cvs add` zum
CVS-Repository hinzugefügt werden:

```bash
cvs add .cvsignore
```

Anschließend überträgt man die Änderungen mit `cvs commit` zum CVS-Server:

```bash
cvs commit
```

#### 4. Dateien zum Sync-Repository hinzufügen}

Nachdem nun alle Vorbereitungen abgeschlossen sind, können die
Projektdateien zu dem Sync-Repository hinzugefügt werden:

```bash
git add .
```
**Achtung**: Versionsverwaltungen haben die Angewohnheit, das
Zeile-endezeichen von Textdateien (LF oder CRLF) anzupassen -  so auch Git.
Wenn die zentrale Versionsverwaltung und Git unterschiedlich mit Zeilenenden umgehen, kann man das Ändern der Zeilenenden in Git deaktivieren: `git config core.autocrlf false`.

Einige ztrale Versionsverwaltungen haben eine globale Revisionsnummer, z. B.
Subversion.
In diesem Fall ist es sinnvoll, diese Revisionsnummer in den
Git-Commit-Kommentar aufzunehmen.
Mit dieser Revisionsnummer kann man
sehr einfach nachvollziehen, welcher Stand importiert worden
ist.
CVS hat leider keine solche Revisionsnummer.

```bash
git commit -m "Initialer Import von CVS"
```

#### 5. `cvs`-Branch im Sync-Repository anlegen`

Das  Sync-Repository wird zukünftig auf einem eigenen `cvs`-Branch
arbeiten.
Dieser muss noch angelegt und aktiviert werden:

```bash
git checkout -b cvs
```

#### 6. Arbeits-Repository anlegen

Das Arbeits-Repository wird als Klon des Sync-Repositorys angelegt.
Beim Klonen
wird automatisch der `master`-Branch als aktiver Branch gesetzt:

```bash
cd ..
git clone cvsproject gitproject
```

Damit sind die initialen Vorbereitungen abgeschlossen.


### Änderungen von der zentralen Versionsverwaltung holen

Dieser Abschnitt beschreibt, wie Neuerungen aus der zentralen Versionsverwaltung
über das Sync-Repository ins Arbeits-Repository geholt werden.

#### 1. Geänderte Dateien ins Sync-Repository übertragen

Der Workspace des Sync-Repositorys enthält die notwendigen Metainformationen für
den Abgleich mit der zentralen Versionsverwaltung. Deswegen können über diesen
Workspace die Änderungen vom CVS-Server geholt werden:

```****ash
cd cvsprojekt
cvs update
```

Es kann bei diesem `update` niemals zu CVS-Konflikten kommen.
Im `cvs`-Branch des Sync-Repositorys befindet sich immer ein *sauberer* alter Versionsstand der zentralen Versionsverwaltung.

Anschließend werden die Änderungen, die durch CVS im Sync-Workspace
vorgenommen wurden, mit dem `add` zu einem
Git-Commit zusammengestellt.
Dann wird das Commit
abgeschlossen:

```bash
git add --all .
```

 * **`--all`**: Dieser Parameter fügt neue und geänderte
	Dateien zum Commit hinzu und entfernt gleichzeitig die gelöschten Dateien.

```bash
git commit -m "Änderungen aus CVS"
```

#### 2. Änderungen ins Arbeits-Repository übertragen

Bisher befindet sich das Commit mit den CVS-Änderungen nur im Sync-Repository.
Da das Arbeits-Repository ein Klon des Sync-Repositorys ist, existiert
automatisch der Remote-Eintrag (`origin`). Mit dem `fetch` kann
das neue Commit mit den CVS-Änderungen in das Arbeits-Repository importiert
werden:

```bash
cd gitprojekt
git fetch origin
```

#### 3. Änderungen in den `master`-Branch übernehmen

Die Änderungen sind zu diesem Zeitpunkt nur im `cvs`-Branch vorhanden und noch
nicht im `master`-Branch. Der letzte Schritt besteht aus einem
`merge`. Dabei kann es zu Konflikten
kommen, wenn es parallele Änderungen an denselben Dateien in CVS und im lokalen Git gegeben hat. Die
normalen Git-Werkzeuge können genutzt werden, um die Konflikte zu bereinigen

![Bisection Überblick](/assets/2016-10-02-parallel-mit-zentralem-vcs/abb-parallel-mit-zentralen-vcs-cvs-update.png)
```bash
git merge origin/cvs
```

Nach diesen Schritten befindet sich im Arbeits-Repository der aktuelle Stand aus
der zentralen Versionsverwaltung, zusammengeführt mit den lokalen
Änderungen.

### Änderungen in die zentrale Versionsverwaltung übertragen

In diesem Abschnitt werden die Änderungen aus dem Arbeits-Repository über das
Sync-Repository in die zentrale Versionsverwaltung übertragen.


#### 1. Aktuellen Stand aus zentraler Versionsverwaltung holen

Bevor die lokalen Änderungen in die zentrale Versionsverwaltung übertragen
werden, sollten immer die neuesten Änderungen aus der Zentrale geholt werden.
Dazu folgen Sie den Schritten aus dem vorherigen Abschnitt.

Durch das Aktualisieren wird die Konfliktwahrscheinlichkeit beim
späteren Übertragen der eigenen Änderungen in die zentrale
Versionsverwaltung minimiert. Des Weiteren kann nochmals getestet werden, ob die
eigenen Änderungen mit dem aktuellen zentralen Stand zusammenarbeiten.

#### 2. Änderungen in das Sync-Repository übertragen

Die lokalen Änderungen im `master`-Branch müssen in das Sync-Repository
übertragen werden. Da das Sync-Repository als `origin`-Remote beim Klonen
registriert wurde, reicht ein einfacher
`push`:

```bash
cd gitproject
git push
```

#### 3. Änderungen in den `cvs`-Branch übernehmen

Die neuen Commits und die geänderten Dateien befinden sich im Sync-Repository im
`master`-Branch. Um diese Änderungen in die zentrale Versionsverwaltung zu
übernehmen, ist noch ein Merge in den `cvs`-Branch notwendig. Hierbei
kann es zu keinen Konflikten kommen, da im `cvs`-Branch keine Änderungen
stattfinden.

![Bisection Überblick](/assets/2016-10-02-parallel-mit-zentralem-vcs/abb-parallel-mit-zentralen-vcs-cvs-commit.png)


```bash
cd cvsproject
git merge --no-commit --no-ff master
```

 * **`no-commit`**:  Da es beim nachfolgenden CVS-Commit
	noch zu Konflikten kommen kann, wird der Git-Merge zunächst ohne abschließendes
	Commit durchgeführt.
 * **`no-ff`**:  Die zusätzliche Option lässt Git keinen
Fast-Forward-Merge durchführen. Damit erhält
man im `cvs`-Branch auf der First-Parent-History nur Commits, die einem
reproduzierbaren Stand der zentralen Versionsverwaltung entsprechen.

#### 4. Änderungen in die zentrale Versionsverwaltung übertragen

Die lokalen Änderungen können jetzt in die zentrale Versionsverwaltung
übertragen werden. Je nachdem, ob es neue Dateien, gelöschte Dateien oder
geänderte Dateien gibt, sind jeweils die notwendigen Befehle der zentralen
Versionsverwaltung auszuführen, z. B. `cvs commit`n, wenn es nur geänderte Dateien gab:


```bash
cvs commit
```

Kommt es bei dem `cvs commit` zu Konflikten, dann gab es seit dem letzten
`cvs update` Änderungen, die mit lokalen Änderungen konkurrieren.
Dann löscht man den aktuellen Merge-Versuch -  das offene Commit:

```bash
git reset --hard HEAD
```

Anschließend beginnt man wieder bei Schritt 1 dieses Ablaufes, d. h., die letzten
konkurrierenden Änderungen werden von der zentralen Versionsverwaltung geholt
und mit dem `master`-Branch zusammengeführt.

Wenn das Übertragen in die zentrale Versionsverwaltung erfolgreich war, geht es
mit dem nächsten Schritt weiter.

#### 5. Aktualisierungen aus der zentralen Versionsverwaltung holen

Einige Versionsverwaltungen verändern Dateien beim Commit bzw. beim ersten
Aktualisieren nach einem Commit. So kann man z. B. CVS dazu bringen, im Kopf
einer Datei die aktuelle Versionsnummer oder die Historie der Änderungen
einzusetzen (Keyword-Substitution).
Deswegen ist es wichtig, nach dem erfolgreichen CVS-Commit nochmals die Dateien
aus der zentralen Versionsverwaltung zu holen:

```bash
cvs update
```

#### 6. Commit auf dem `cvs`-Branch durchführen

Jetzt ist es Zeit, den bisher noch offenen Merge-Commit
abzuschließen. Vorher werden die möglichen CVS-Ersetzungen mit
dem `add} noch in das Merge-Commit übernommen:

```bash
git add .
git commit -m "Änderungen aus Git eingespielt"
```

#### 7. `master`-Branch im Arbeits-Repository aktualisieren

Durch den vorhergehenden Schritt gibt es ein neues Commit auf dem
`cvs`-Branch im Sync-Repository. Der `cvs`-Branch muss vor dem
Weiter\-arbeiten mit dem `master}-Branch im Arbeits-Repository zusammengeführt werden. Dazu wird als
Erstes das Commit in das Arbeits-Repository übertragen:

```bash
cd gitprojekt
git fetch origin
```

Anschließend wird ein Merge durchgeführt. Dieser Merge ist immer ein
Fast-Forward-Merge, da es keine zwischenzeitlichen Änderungen auf dem
`master`-Branch geben sollte.

```bash
git merge origin/cvs
````

Nach diesen Schritten sind alle lokalen Änderungen in der zentralen
Versionsverwaltung enthalten. Im Arbeits-Repository befindet sich eine Version,
die dem aktuellen Stand der zentralen Versionsverwaltung entspricht. In der Abbildung sind alle Commits und
Branches dargestellt, die durch den beschriebenen Ablauf entstanden sind.

![Bisection Überblick](/assets/2016-10-02-parallel-mit-zentralem-vcs/abb-parallel-mit-zentralen-vcs-cvs-post-commit.png)

##  Warum nicht anders?

### Warum nicht mit nur einem Repository?

Der Ablauf dieses Workflows funktioniert auch mit nur einem Git-Repository,
d. h.,
im Sync-Repository findet auch die lokale Entwicklung statt. Dazu wird zwischen
dem `cvs`-Branch und dem `master`-Branch gewechselt, je nachdem,
ob gerade synchronisiert oder entwickelt wird.

Die Erfahrung hat jedoch gezeigt, dass es schwerfällt, den Überblick zu
behalten, wo welche Aktionen durchgeführt werden müssen.
Insbesondere beim Synchronisieren passiert es häufig, dass Aktionen im falschen
Branch ausgeführt werden.

Ein weiteres Problem kann entstehen, wenn aus Versehen bei der Entwicklung die
Metainformationen der zentralen Versionsverwaltung gelöscht werden, zum
Beispiel wenn bei einem Refactoring ein ganzes Verzeichnis gelöscht wird und
damit auch das zugehörige CVS-Unterverzeichnis.

<form method="POST" action="https://api.staticman.net/v2/entry/bstachmann/kapitel26-comments/master/comments">
  <input name="options[redirect]" type="hidden" value="{{ page.url | absolute_url }}">
  <!-- e.g. "2016-01-02-this-is-a-post" -->
  <input name="options[slug]" type="hidden" value="{{ page.id | remove_first: "/" }}">
  <label><input name="fields[name]" type="text">Name</label>
  <label><input name="fields[email]" type="email">E-mail</label>
  <label><textarea name="fields[message]"></textarea>Message</label>

  <button type="submit">Go!</button>
</form>
