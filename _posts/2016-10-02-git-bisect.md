---
layout: post
title: "Mit Bisection Fehler suchen"
category: Git
tags: [Bisect]
author: bst-rp
---

Während der Entwicklung passiert es häufig, dass plötzlich ein Fehler
in bereits erfolgreich getesteten Funktionalitäten auftaucht, der in früheren
Versionen nicht vorhanden war.
Eine Erfolg versprechende Strategie bei der Fehlersuche besteht darin, das
Commit zu suchen, in dem der Fehler zum ersten Mal beobachtet werden kann.
Da beim Arbeiten mit Git typischerweise kleine Commits entstehen, sind deren Änderungen  rasch
analysiert und somit wird die Fehlerursache schnell gefunden.

Git unterstützt einen solchen Suchprozess nach fehlerhaften Commits mittels
*Bisection*.

Bisection beruht auf einer binären Suche.
Ausgehend von einem bekannten fehlerfreien Commit und einem bekannten fehlerbehafteten Commit
wird die Historie "halbiert" und der
"mittlere" Commit im Workspace aktiviert. Das nun aktuelle Commit kann auf das
Vorhandensein des Fehlers untersucht werden.
Je nachdem, ob der Fehler darin vorhanden  ist oder nicht, wird der
verbliebene Bereich der Historie, in dem sich der Fehler verstecken muss,
wieder "halbiert" und das neue "mittlere" Commit ausgewählt.  Am Ende wird
es normalerweise ein Commit geben, in dem der Fehler zum ersten Mal beobachtet
werden kann.

Dieser Workflow zeigt,

* wie man Bisection nutzt, um effizient fehlerhafte Commits zu finden, und
*  man die Fehlersuche mit Bisection automatisieren kann.

## Voraussetzungen

* **Reproduzierbare Fehlererkennung:**  Der Fehler muss reproduzierbar
nachgewiesen werden können, d.h., es ist möglich, einen Versionsstand ganz
klar als fehlerfrei oder fehlerhaft zu erkennen. Um eine Automatisierung durchzuführen,
muss der Fehler durch einen Testcase bzw. ein Skript erkannt werden können.
* **Die Fehlererkennung darf nicht teuer sein:** Die Fehlererkennung
muss schnell gehen und darf keine großen Kosten verursachen. Mit Bisection
sind je nach Anzahl der zu untersuchenden Commits mehrere Fehlererkennungen
notwendig. Wenn die benötigte Zeit zu lang ist oder die
Kosten zu groß sind, ist eine analytische Suche der Fehlerursache effizienter.

## Überblick

In  TODO Abbildung~\ref{fig:bisection-ueberblick} ist eine Historie dargestellt, in
der ein Commit als fehlerfrei, in Bezug auf einen bestimmten Fehler, erkannt wurde und ein anderes Commit als fehlerhaft.
Die Historie muss nicht linear sein. Es muss jedoch ein Weg über die Parent-Beziehungen vom fehlerhaften zum
fehlerfreien Commit vorliegen.

Wenn der Bisection-Prozess gestartet wird, ermittelt Git ein geeignetes
Commit in der Mitte der Historie. Dieses Commit kann manuell oder per Skript
auf das Vorhandensein des Fehlers getestet werden und als "gut" oder
"schlecht" markiert werden. Danach ermittelt der Bisection-Prozess ein
weiteres mögliches Commit, und zwar so lange, bis ein Commit
übrig bleibt, das den Fehler aufweist und dessen Vorgänger fehlerfrei ist.

## Ablauf und Umsetzung

Für die folgenden Abläufe gehen wir von einem kleinen
Beispielprojekt aus, das verschiedene mathematische Funktionen
implementiert. Unter anderem berechnet es auch die Fakultät einer Zahl und gibt
eine Liste aller Fakultäten bis 5 aus.

```bash
$ java FakultaetMain
Fakultät von 1 = 1
Fakultät von 2 = 2
Fakultät von 3 = 6
Fakultät von 4 = 24
Fakultät von 5 = 120
```

In einer späteren Version hat sich ein Fehler eingeschlichen, und die
Ausgabe sieht nun folgendermaßen aus:

```bash
Fakultät von 1 = 1
Fakultät von 2 = 1
Fakultät von 3 = 2
Fakultät von 4 = 6
Fakultät von 5 = 24
```

### Manuelle Fehlersuche mit Bisection

Der erste Ablauf beschreibt das prinzipielle Vorgehen mit Bisection,
wobei der Test auf das Vorhandensein des Fehlers manuell durchgeführt wird.

#### Fehlerindikator definieren

Typischerweise wird ein Fehler von Entwicklern, Testern oder Anwendern durch ein
Fehlverhalten der Anwendung erkannt.

Im ersten Schritt geht es darum, analytisch die Fehlersituation zu verstehen und
einen Indikator zu finden, an dem man das Vorhandensein des Fehlers erkennt.

Folgende Punkte sind Beispiele für Fehlerindikatoren:

 * Eine Aktion bzw. ein Funktionsaufruf führt zu einer Exception, einem
 Programmabbruch bzw. einer Fehlermeldung.
 * Eine Funktion liefert bei bestimmten Eingaben ein fehlerhaftes Ergebnis.
 * Ein Testcase schlägt fehl.

In unserem Beispiel ist an der falschen Ausgabe der Fakultät von 3 zu
erkennen, dass ein Fehler vorhanden ist.

In vielen Fällen führt allein diese Analyse schon zum Finden der Fehlerursache
und es ist gar kein Bisection mehr notwendig.

#### Fehlerfreies und fehlerbehaftetes Commit finden

Der Bisection-Prozess benötigt ein fehlerfreies und ein fehlerbehaftetes Commit.
Gute Kandidaten für ein fehlerfreies Commit sind das letzte Release oder der
letzte Meilenstein.

Stellt man auf der Suche nach einem fehlerfreien Commit fest, dass der mögliche
Kandidat den Fehler auch noch beinhaltet, geht man weiter in der
Historie zurück.

Ein fehlerbehaftetes Commit zu finden ist nicht schwer, da der Fehler ja bereits
gemeldet wurde. Wenn jedoch auf der Suche nach fehlerfreien Commits weitere
fehlerbehaftete Commits gefunden werden, ist es sinnvoll, das älteste bekannte
fehlerbehaftete Commit auszuwählen.
Nachfolgend ist für unser Beispiel eine Log-Ausgabe der
Historie zu sehen:

```bash
$ git log --oneline
202d25d modulo fertig
e36fead multiply fertig
918ed2f sub fertig
ebe741d add fertig
87ac59e Fakultätsrechner fertig
39cbdc0 init
```

Eine Analyse zeigt, dass das Commit `87ac59e
Fakultätsrechner fertig` fehlerfrei und das Commit `202d25d modulo
fertig` fehlerhaft ist.

#### Fehlersuche mit Bisection

Nachdem nun der Bereich der Historie mit der Fehlerursache eingegrenzt ist, kann
das eigentliche Suchen des Fehlers mit Bisection beginnen.

Bisection wird mit dem `bisect start`-Befehl gestartet. Dabei ist als erster
Parameter das fehlerhafte Commit und als zweiter Parameter das fehlerfreie
Commit anzugeben:

```bash
$ git bisect start 202d25d 87ac59e
Bisecting: 1 revision left to test after this (roughly 1 step)
[918ed2f29a44e468d690fb770aab1ad2dbae1a5a] sub fertig
```

Der `bisect start`-Befehl markiert das erste übergebene Commit als `bad`
und das zweite als `good`. Anschließend wird  das Commit aktiviert, das sich
in der Mitte zwischen den beiden Commits befindet- in diesem Fall das Commit `918ed2f sub fertig`.

Im Workspace befinden sich jetzt die Dateien eines Commits, bei dem
noch nicht klar ist, ob es fehlerhaft oder fehlerfrei ist. Durch den gefundenen
Fehlerindikator kann der Versionsstand nun getestet werden.

```bash
$ java FakultaetMain
Fakultät von 1 = 1
Fakultät von 2 = 1
Fakultät von 3 = 2
Fakultät von 4 = 6
Fakultät von 5 = 24
```

In unserem Beispiel ist der Fehler immer noch zu beobachten, d.h., dieses
Commit ist fehlerhaft.

Je nach Ergebnis muss das aktuelle Commit jetzt mit dem `bisect`-Befehl
als gut oder als schlecht markiert werden.

 * **bisect good:** Der Fehler war nicht zu beobachten; das Commit ist
fehlerfrei.
 * **bisect bad:** Der Fehler war zu beobachten; das Commit ist fehlerhaft.
 * **bisect skip:** Das aktuelle Commit kann nicht getestet werden.
Typischerweise ist es nicht kompilierbar oder es fehlen Dateien. Bisection
aktiviert ein anderes Commit für den Test.

In unserem Beispiel ist der Fehler noch vorhanden und das Commit wird als
`bad` markiert:

```bash
$ git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[ebe741de3366a3fc08fbedfdfa408517dd172ca3] add fertig
```

Als Antwort teilt Git mit, dass jetzt das Commit `ebe741d add fertig`
aktiviert wurde. Git teilt weiterhin mit, das dieses Commit das letzte ist, das
getestet werden muss.

Der erneute Test unseres Fakultätsrechners zeigt, dass dieses Commit
fehlerfrei ist, und das Commit wird als `good` markiert:

```bash
$ git bisect good
commit 918ed2f29a44e468d690fb770aab1ad2dbae1a5a
Author: Rene Preissel <rp@eToSquare.de>
Date:   Fri Jun 24 08:04:43 2011 +0200

    sub fertig

:040000 040000 0e5bfb07e859072a564eaca073461e4a12a0ed61 \
 329e7f864bac874c69be4531452c753cf56be794 M      src
```

Git informiert jetzt, dass  das
Commit `918ed2f sub fertig` das erste Commit ist, in dem der Fehler
auftritt. Jetzt können mit den bekannten Git-Befehlen (z.B. `git show
918ed2f`) die Änderungen des fehlerbehafteten Commits analysiert werden.

In unserem Beispiel zeigte sich, dass durch eine Refaktorisierung
die Fakultät nur bis zu `n-1` berechnet wurde.

**Achtung!** Vor der Fehlerbehebung muss der Workspace wieder auf den HEAD des
aktuellen Branch gesetzt werden. Dies wird im nächsten Schritt beschrieben.

#### Bisection beenden bzw. abbrechen

Nach erfolgreicher Ursachenforschung mit Bisection oder wenn der
Bisection-Vorgang abgebrochen werden soll, muss der Workspace mit dem
`bisect reset`-Befehl wieder in den normalen Entwicklungszustand
zurückgesetzt werden:

```bash
$ git bisect reset
Previous HEAD position was ebe741d... add fertig
Switched to branch 'master'
```

### Automatisierte Fehlersuche mit Bisection}

Im vorigen Ablauf wurde der Test, ob ein Commit einen Fehler beinhaltet, manuell
durchgeführt. Wenn der zu überprüfende Bereich der Historie sehr lang ist
oder der Test manuell sehr aufwendig ist, dann kann man den Test auch
automatisieren und Bisection per Skript arbeiten lassen.


#### Fehlerindikator definieren

Der Fehlerindikator wird genauso wie bei der manuellen Fehlersuche mit Bisection
definiert.
Es ist nur darauf zu achten, dass der gefundene Indikator per Skript automatisiert überprüft werden kann.

#### Testskript bereitstellen
Will man die Fehlersuche mit Bisection automatisieren, muss man ein Shell-Skript
bereitstellen, das den Fehlerindikator automatisch erkennt.
Das Shell-Skript muss je nach Vorhandensein
des Fehlers einen anderen Exitcode liefern.

* **Exitcode 0:**  Der Fehler wurde nicht gefunden. Bisection soll das Commit
als `good` markieren.
* **Exitcode 1–124, 126, 127:** Der Fehler wurde gefunden. Bisection soll das
Commit als `bad` markieren.
* **Exitcode 125:** Der Test konnte nicht durchgeführt werden, weil die
Anwendung nicht funktioniert. Typischerweise ist diese Version nicht
kompilierbar. Bisection soll das Commit überspringen.

Unsere Rechneranwendung ist in Java implementiert. Als Beispiel zeigen wir,
wie in diesem Umfeld die Fehlersuche mit Bisection automatisiert werden kann. Bei
anderen Entwicklungsumgebungen müssen die einzelnen Skripte entsprechend angepasst
werden.

Die eigentliche automatische Überprüfung des Fehlers wird durch einen
[JUnit](http://www.junit.org/)-Test durchgeführt. Dabei wird einfach
geprüft, ob die Fakultät von 3 auch wirklich 6 ergibt. Wenn das Ergebnis falsch
ist, dann wird der Test fehlschlagen.

```bash
public class FakultaetsBisectTest {
    @Test
    public void testFakultaet3() {
        long result = Rechner.fakultaet(3);
        Assert.assertEquals(6, result);
    }
}
```

**Achtung!** Dabei ist es wichtig, diesen Test in einer neuen Datei zu implementieren. Diese
Datei darf nicht in Git  versioniert werden.  Beim
Bisection-Prozess werden im Workspace nacheinander verschiedene Commits aktiviert.
Wenn die Testdatei unter Git-Kontrolle steht, würde beim Aktivieren eines alten
Commits diese Datei nicht mehr vorhanden sein. Nicht versionierte Dateien
werden dagegen beim Wechsel des Commits einfach im Workspace belassen.

Der automatisierte Bisection-Prozess benötigt ein Shell-Skript.
Dieses Shell-Skript muss für unser Java-Beispiel als Erstes die
Quelldateien kompilieren und anschließend den Test starten.

Als Build-System wird in unserem Beispiel [Ant](http://ant.apache.org/)
benutzt. Im Rechnerprojekt gibt es eine Build-Datei `build.xml`, die
bereits in der Lage ist, einen sauberen Build  durchzuführen (`ant clean compile`).
Für die Ausführung des Bisection-Tests wird eine neue Build-Datei `bisect-build.xml` angelegt, die nur ein Target zum Starten des Tests beinhaltet.
Auch diese Datei darf nicht mit Git versioniert werden.

```bash
<target name="test">
    <junit>
        <classpath refid="build.classpath" />
        <test name="FakultaetsBisectTest"
                 haltonerror="true"
                 haltonfailure="true"/>
    </junit>
</target>
```

Um die verschiedenen Ant-Targets aufzurufen, wird noch das
Shell-Skript `bisect-test.sh` angelegt. Auch dieses wird wieder nicht mit
Git versioniert.

```bash
#!/bin/bash

ant clean compile
if [ $? -ne 0 ];then
    exit 125;
fi
\end{onlyantwort}
\newpage
\begin{onlyantwort}
ant -f bisect-build.xml
if [ $? -ne 0 ];then
    exit 1;
else
    exit 0;
fi
```

Dieses Skript ruft die einzelnen Build-Targets auf und überprüft den Exitcode
von Ant. Ant gibt bei einem Fehler einen Exitcode ungleich 0 zurück. Dieser muss
noch in die von dem Bisection-Prozess gewünschten Codes umgewandelt werden:

 * Falls der Build fehlschlägt, wird der Exitcode 125 zurückgeliefert.
 * Falls der Test erfolgreich ist, wird der Exitcode 0
 zurückgeliefert.
 * Falls der Test fehlschlägt, wird der Exitcode 1 geliefert.

#### Fehlerfreies und fehlerbehaftetes Commit finden

Die Suche nach fehlerfreien und fehlerbehafteten Commits unterscheidet sich
nicht vom manuellen Ablauf. Man kann jedoch auch dabei bereits den JUnit-Test
nutzen, um auf den Fehler zu prüfen.
Als Beispiel aktivieren wir das Commit `87ac59e
Fakultätsrechner fertig` und prüfen, ob es fehlerfrei ist:

```bash
$ git checkout 87ac59e
$ ant -f bisect-build.xml
Buildfile: bisect-build.xml

test:

BUILD SUCCESSFUL
Total time: 0 seconds
```

**Achtung!** Vergessen Sie am Ende nicht, den
`master`-Branch wieder zu aktivieren:


```bash
$ git checkout master
```

#### Automatisierte Fehlersuche mit Bisection

Auch bei der automatisierten Fehlersuche mit Bisection wird als Erstes der
Bisection-Prozess mit dem `bisect start`-Befehl gestartet. Auch hier wird als
erster Parameter das fehlerhafte Commit und als zweiter Parameter das
fehlerfreie Commit übergeben:

```bash
$ git bisect start 202d25d 87ac59e
Bisecting: 1 revision left to test after this (roughly 1 step)
[918ed2f29a44e468d690fb770aab1ad2dbae1a5a] sub fertig
```

Anschließend wird der `bisect run`-Befehl benutzt, um das
erzeugte Shell-Skript `bisect-test.sh` auszuführen:

```bash
$ git bisect run ./bisect-test.sh
```

Die folgende Ausgabe wurde gekürzt und zeigt nur die letzten Zeilen des
`bisect run`. Es ist gut zu erkennen, dass das Commit
`918ed2f sub fertig` als das erste fehlerhafte Commit gefunden wurde.

```bash
Buildfile: bisect-build.xml

test:

BUILD SUCCESSFUL
Total time: 0 seconds
918ed2f29a44e468d690fb770aab1ad2dbae1a5a is the first bad commit
commit 918ed2f29a44e468d690fb770aab1ad2dbae1a5a
Author: Rene Preissel <rp@eToSquare.de>
Date:   Fri Jun 24 08:04:43 2011 +0200

    sub fertig

:040000 040000 0e5bfb07e859072a564eaca073461e4a12a0ed61 \
 329e7f864bac874c69be4531452c753cf56be794 M      src
bisect run success
```

#### Bisection beenden

Nach erfolgreicher Fehlersuche muss der Bisection-Prozess mit dem
`bisect reset`-Befehl beendet werden:

```bash
$ git bisect reset
Previous HEAD position was ebe741d... add fertig
Switched to branch 'master'
```

### Warum nicht anders?

#### Warum nicht mit Merge die Testskripte in alte Commits einfügen?

Der beschriebene Ablauf nutzt die Fähigkeit von Git aus, dass
nicht versionierte Dateien beim Wechseln der Commits im Workspace verbleiben.
Dadurch ist es möglich, die neuen Testskripte auch in alten Commits
auszuführen.

Eine alternative Lösung besteht darin, die Testskripte in einen neuen Branch
einzubauen (siehe den `bisect-test`-Branch in TODO Abbildung~\ref{fig:bisection-test-branch}).

TODO \abbildung{bisection}{test-branch}{\branch{bisect-test}-Branch benutzen}

Im Bisection-Shell-Skript wird nun vor jedem Testlauf ein Merge des
`bisect-test`-Branch in das aktuell von Bisection ausgewählte Commit
durchgeführt.
Dabei wird die Option `--no-commit` benutzt, um
ein dauerhaftes Commit zu verhindern.

Nachdem der Test durchgeführt wurde, werden die Änderungen des Merge mit dem
`reset`-Befehl wieder zurückgenommen.

Dieser Ablauf und ein Beispielskript ist in der Onlinedokumentation des
`bisect`-Befehls im Example-Abschnitt zu finden.

Die Lösung mit dem `bisect-test`-Branch kann dann sinnvoll sein, wenn
nicht nur ein Testcase und Testskripte neu hinzukommen, sondern wenn auch
vorhandener Code für den Test angepasst werden muss, zum Beispiel weil die
Überprüfung auf Daten zugreifen muss, die in alten Commits nicht sichtbar sind.

Der von uns beschriebene Ablauf mit unversionierten Dateien ist
jedoch in den meisten Fällen ausreichend und einfacher umzusetzen.
