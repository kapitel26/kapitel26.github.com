---
layout: post
title: "Süchtig nach Rebasing (Vortrag bei Lehmanns in Hamburg)"
category: Git
tags: [Git, Rebasing]
author: bst
---
{% include JB/setup %}

Gestern haben René und ich zwei kurze Vorträge 
in der Buchhandlung [Lehmanns](http://www.lehmanns.de/page/verlfb)
in Hamburg gehalten.

Da mein Vortrag ohne Folien und nur mit Live-Coding und Live-Gitting stattfand, habe ich hier mal ein kurzes Protokoll zur Rebasing-Session
von gestern zusammengestellt.

### Ausgangssituation

Ein Git-Repository `shared.git` mit einer Coding-Kata Namens "Hash-Collisions". Der initiale Stand befindet sich auf einem Branch `kata-hash-collisions-setup`. Er enthält:

 * Eine Datei voller Unit-Tests, die größtenteils auskommentiert sind und im Laufe der Kata nach und nach einkommentiert werden und so die Anforderungen an die Implementierung immer höher werden lassen.

 * Den Rumpf für eine Implementierungsklasse.

### Arbeitsumgebung aufsetzen

Repository klonen.

    git clone shared.git/ bjoern
    cd bjoern/

Neuen Branch erstellen und pushen.

    git checkout kata-hash-collisions-setup
    git checkout -b lehmanns 
    git push --set-upstream origin lehmanns

### Eine einfache Änderung durchführen und committen

Der Testfall wir ein wenig geändert.

    git commit -am "ersetze Rationals durch Doubles"

Danach wird ein Script gestartet, welches die Änderungen committed.

Die Berechnungsfunktion wird implementiert, die Tests werden grün. Ein Commit erfolgt automatisch.

    Automatisches Commit: Berechnung rekursiv implementieren

Danach wird ein weiter Test einkommentiert und wird sofort grün.

    Automatisches Commit: (test_klassisches_geburtstagsbeispiel)

### René: Eine anderer Entwickler macht einen Bugfix

Ein anderer Entwickler arbeitet am selben Projekt. Wir richten eine Umgebung für ihn ein:

    git clone shared.git/ rene
    cd rene/

Wechseln auf den Branch für die gemeinsame Kata.

    git checkout -b lehmanns 

René behebt einen Fehler und pushed die Lösung.

    git commit -am "fix: show right linenumber in assertion message"
    git push

### Merge durchführen (und rückgängig machen)

Bjørn holt die Änderungen von René mittels `pull`.

    git pull

es entsteht ein Merge-Commit. Die Historie sieht häßlich aus.

    git log --graph --all --oneline --decorate

Bjørn macht das Merge wieder rückgängig.

    git reset --hard head^

Schöner wäre es, wenn René seinen Bugfix zuerst gemacht hätte und Bjørn seine Implementierung erst danach begonnen hätte. Der `rebase` Befehl ermöglicht es, Bjørns Commits auf Renés Commit zu übertragen.


**Welche Commits werden verschoben?** Der `rebase`-Befehl erwartet einen Parameter `<upstream>`. Git verschiebt dann den `HEAD` mit allen Vorgängern, die *noch nicht* in der Historie von `<upstream>` enthalten sind.

**Wohin wird verschoben?** Normalerweise auf den `<upstream>` drauf.

    git rebase origin/lehmanns 

### Interactive Rebasing

    git rebase --interactive 

Mit den Befehlen `reword`, `fixup`, `squash`, ... kann man die Historie manipulieren. Man kann dabei auch Commits verschieben oder Zeilen weglassen.

Achtung: Es kann dabei zu Merge-Konflikten kommen, die man auflösen muss, bevor man mit `rebase --continue` weiter macht.

### Aus Eins mach Zwei

Mit `edit` kann man das Rebase unterbrechen lasse, um einzelne Commits manuell zu bearbeiten.

    git rebase --interactive 

Commit wieder aufmachen.

    git reset head^
    git diff

Jetzt kann man mit der Git GUI partiell Committen und so aus einem Commit zwei Commits machen.

    git gui

Dann darf `rebase` weitermachen.

    git rebase --continue 

Anmerkung: Wenn man sich verrannt hat, hilft ein `git rebase --abort` auf den vorigen Stand zurück zu kommen.

Tipp: Nicht zu viele Änderungen auf einmal machen. Besser mehrere Rebases hintereinander. Das gibt mehr Kontrolle.

### Commit auf einen anderen Branch verschieben

Im Rebase verschieben wir das gewünscht Commit ganz nach unten. Dann steht das Commit nachher ganz oben in der History.

    git rebase --interactive 

Bjørn einen Branch für den Hotfix.

    git checkout -b hotfix-repair-message

Wir setzen den Ursprünglichen Branch einen Schritt zurück, so dass der den Hotfix nicht mehr enthält. 

    git branch -f lehmanns head^

Dann Rebasen wir `--onto kata-hash-collisions-setup` 

    git rebase lehmanns --onto kata-hash-collisions-setup 

Sobald wir pushen steht der Branch für andere Entwickler zur Verfügung. Ganz unabhängig von unserer Feature-Entwiclung auf dem Branch `lehmanns`.

Wenn wir den Fix auch in `lehmanns` wollen, können wir ihn mit `merge` oder `cherry-pick` wieder reinholgen. Oder wir rebasen `lehmanns` `--onto hotfix-repair-message`. Oder ...

