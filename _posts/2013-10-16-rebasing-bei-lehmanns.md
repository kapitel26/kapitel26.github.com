### Ausgangssituation

Ein Git-Repository `shared.git` mit einer Coding-Kata Namens "Hash-Collisions". Der initiale Stand befindet sich auf einem Branch `kata-hash-collisions-setup`. Er entält:

 * Eine Datei voller Unit-Tests, die größtenteils auskommentiert sind und im Laufe der Kata nach und nach einkommentiert werden und so die Anforderungen an die Implementierung immer höher werden lassen.

 * Den Rumpf für eine Implementierungsklasse.

### Arbeitsumgebung aufsetzen

Repository klonen

    git clone shared.git/ bjoern
    cd bjoern/

Neuen Branch erstellen und pushen

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

Wechseln auf den Branch für die gemeinsame Kata

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

`reword`, `fixup`

### Aus Eins mach Zwei

`edit`

    git rebase --interactive 

Commit wieder aufmachen.

    git reset head^
    git diff

Dann partiell committen

    git gui

Dann darf `rebase` weitermachen

    git rebase --continue 

Anmerkung: Wenn man sich verrannt hat, hilft ein `rebase --abort`

Tipp: Nicht zu viele Änderungen auf einmal machen. Lieber mehrere Rebases hintereinander.

### Commit auf einen anderen Branch verschieben

Im Rebase verschieben wir das gewünscht Commit ganz nach unten. Dann steht das Commit nachher ganz oben in der History

    git rebase --interactive 

Wir erstellen einen Branch für den Hotfix

    git checkout -b hotfix-repair-message

Wir setzen den Ursprünglichen Branch einen Schritt zurück, so dass der den Hotfix nicht mehr enthält. 

    git branch -f lehmanns head^

Dann Rebasen wir `--onto kata-hash-collisions-setup` 

    git rebase lehmanns --onto kata-hash-collisions-setup 

Sobald wir pushen steht der Branch für andere Entwickler zur Verfügung. Ganz unabhängig von unserer Feature-Entwiclung auf dem Branch `lehmanns` .

Wenn wir den Fix auch in `lehmanns` wollen, können wir ihn mit `merge` oder `cherry-pick` wieder reinholgen. Oder wir rebasen `lehmanns` `--onto hotfix-repair-message`. Oder ...