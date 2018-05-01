---
layout: post
title: "Können Tests sprechen? Und wenn ja, worüber?"
category: Testing
tags: [Integrationstest, Modultest, Refactoring, Noise]
author: bst
---

![unit test](/assets/sprechende-tests/unit-test.png)


```ruby
class ArchiverChecks < Checks

  def declaration
    action_under_test { synchArchive }

    check "Top-level files will be synched."
    prepare { in_directory(workDir) { create_file(named('test'), "AAAA") } }
    post { in_directory(archiveDir) { assert_equal "AAAA", read_file(named('test')) } }

    check "Files in inactive directories will be synched."
    prepare { in_directory(workDir, named("inactive-dir")) { create_file(named(), "BBBB") } }
    post { in_directory(workDir, named("inactive-dir")) { assert_equal "BBBB", read_file(named()) } }
  end

end
```

#### Die Zeiten haben sich geändert.

Noch vor wenigen Jahren musste man sich den Mund fusselig reden, um Entwickler und Manager zu überreden, es doch wenigstens mal zu versuchen mit *automatisierten Tests*.
Inzwischen pflegt vom hemdsärmligen Startup bis zum fortschrittsresistenten Bankkonzern fast jedes Unternehmen umfassende Test-Suiten.

#### Heute hat doch jeder eine Test-Suite. Also alles in Butter, oder?

Da könnte ich doch mal zufrieden sein, und mich an grün leuchtenden Jenkins-Dashboard erfreuen.
Bin ich aber nicht und tue ich.
Warum ich unzufrieden bin, erläutere ich an einem *häßlichen Stückchen Code*:

{% include_relative sprechende-tests/vorher.md %}

Der Code ist übrigens von mir.
Unzufrieden damit bin ich trotzdem.
Einige Zeit nachdem ich ihn geschrieben hatte, wollte ich das System ein klein wenig erweitern und dazu musste ich den Test anpassen.
Und dazu wiederum musste ich wiederum erstmal verstehen, was dieser Code tut.
Obwohl ich in ja mal selber geschrieben habe, musste ich ziemlich lange auf den Code starren, um herauszufinden, was ich mit dem Test eigentlich überprüfen wollte.

#### Wie würde ich meinem Kollegen erklären, was der Test macht?

Dabei ist der Test gar nicht komplex.
Einem Kollegen würde ich das ungefähr so erklären:

> Es geht um die Methode `synchArchive`.
> Ich schreibe eine Datei ins `workDir` und prüfe, ob sie an der richtige Stelle im `archiveDir` auftaucht.
> Dann schreibe ich eine Datei in ein Unterverzeichnis und prüfe, ob auch diese an der richtige Stelle erscheint.

Aber das ist schwer aus dem Code herauszulesen.

#### Der Wald vor lauter Bäumen, oder wo liegt das Problem?

![wald](/assets/sprechende-tests/wald.png)

Das Problem ist *NOISE*. Mit *NOISE* meine ich technischen Code, der zwar notwendig ist, um den Code auszuführen, aber wenig über den fachlichen Inhalt des Tests erzählt. In unserem Fall sind dies:

 * Technische Includes, etwa: `Minitest::Assertions`, `FileUtils`
 * Ein Zähler für Minitest-Assertions, hier: `@assertions`
 * Das Erzeugen von Verzeichnissen: `mkdir_p "__#{check_name}"`
 * Parameter in Blöcken, etwa: `|check_name, archiver|`
 * Unübersichtliche Stringsubstitutionen, etwa: `"__#{check_name}_file"`

Im Einzelnen ist nichts davon schlimm. In der Summe verschleiert es die fachliche Bedeutung der Tests.

#### Warum stört *NOISE*?

Der Test unterstützt die *Korrektheit*, indem er prüft, dass die Archivierung so funktioniert, wie von mir ursprünglich vorgesehen.
Außerdem unterstützt er die *Wartbarkeit*, indem er Seiteneffekte aufdeckt, wenn durch Änderungen an anderen Aspekten Software, versehentlich das Verhalten der Archivierung ändert.

Weniger gut steht es um die *Flexibilität* für Änderungen oder Erweiterungen.
Denn dazu muss man den Test so ändern oder erweitern, dass er gegen das neue erwartete Verhalten prüft.
Und dazu muss man erstmal verstehen, welches Verhalten der Test bisher erwartet.
Und genau das erschwert der viele *NOISE* im Code.

#### Sprechende Tests durch Noise Reduction

*NOISE* kann man durch Refactoring leicht reduzieren. Technischen Code und unübersichtliche Stringsubstitutionen kann man in Hilfsmethoden auslagern.
Includes können in Oberklassen verlagert werden. Parameterübergaben können durch Bereitstellung von Feldern im jeweiligen Kontext vermieden werden.
Das sind alles einfache Refactorings, die sich schnell  und ohne viel Nachdenden durchführen lassen.
Der Aufwand dafür hält sich in Grenzen.
Was übrig bleibt ist erheblich kompakter und läßt sich schneller erfassen.
Es ist viel näher an der informellen mündlichen Beschreibung, so wie ich es einem Kollen erklären würde (siehe oben).

<ul id = "myTab" class = "nav nav-tabs">
  <li class="active"><a href = "#nachher" data-toggle = "tab">Nachher</a></li>
  <li><a href = "#vorher" data-toggle = "tab">Vorher</a></li>
</ul>

<div id = "myTabContent" class = "tab-content">

  <div class = "tab-pane fade in active" id = "nachher" style="max-height: 350px;overflow-y:scroll;">
  {% include_relative sprechende-tests/nachher.md %}
  </div>

  <div class = "tab-pane fade" id = "vorher" style="max-height: 350px;overflow-y:scroll;" >
    {% include_relative sprechende-tests/vorher.md %}
  </div>

</div>

#### Trade-Off

Auch *NOISE*-Reduction für *sprechende Tests* hat Vor- und Nachteile:

 * **Vorteile**
   * **Flexibilät**: Es ist leichter das Verhalten der Anwendung zu ändern oder zu erweitern, weil lesbar ist, was der Test bisher tut und weil schnell klar wird, was angepasst werden muss, um das gewünschte neue Verhalten darzustellen.
   * **Flexibilität**: Durch das Heraustrennen der Fachlichkeit, wird man flexibler Setup. So kann man dieselben fachlichen Test leichter in unterschiedlichen Umgebungen ausführen lassen, z. B. auf verschiedenen Betriebssystemen.
   * **Effizienz**: Die Fehlersuche bei gebrochenen Tests ist leichter, wenn man auf einen Blick erkennt, welche fachliche Anforderung gebrochen wurde.
   * **Funktionalität**: *Sprechende Tests* können zusammen mit Fachexperten validiert werden, um zu gewährleisten, das auch wirklich das Richtige™ gebaut wire.
 * **Nachteile**
   * **Aufwand**: Tests werden nicht von alleine zu *sprechenden Tests*. Im Gegenteil: Während der Entwicklung ist kaum zu vermeiden, dass sich Technik und Fachlichkeit vermischen. Es ist also Refactoring nötig, um die Tests *in Form* zu bringen.
   * **Abstraktion**: Die Indirektion, die durch *Separation of Concerns* entsteht, macht es schwerer zu verstehen wann wo was passiert. Programmiereinsteiger tun sich oft leicher mit Code, bei dem dem alle Anweisungen in einer langen Methode in Ausführungsreihenfolge aufgereiht sind.

> Gibt halt nix für umme.

Meine Einschätzung dazu: Wenn Ihr mit häufigen fachlichen Änderungs- und Erweiterungswünschen rechnet, dann lohnt es sich, den den erhöhten Aufwand zu investieren und den höheren Abstraktionsgrad zu akzeptieren, um Flexibilität zu gewinnen.

#### Hintergrund

> Grau, teurer Freund, ist alle Theorie,<BR/>
> Und grün des Lebens goldner Baum.<BR/>
> *(Goethe)*

Ein wenig theoretischen Hintergrund gibt es auch. Das Trennen der fachlichen Beschreibung der Tests von den technischen Details der Implementierung ist eine praktische Anwedung des Design-Prinzips [*Separation of Concerns*](https://en.wikipedia.org/wiki/Separation_of_concerns). Und der entstehende kompakte Code zur Beschreibung der Tests kann als [Language Internal Domain Specific Language](http://martinfowler.com/bliki/InternalDslStyle.html) verstanden werden.

### tl;dr

Macht Tests lesbar!
Zieht solange technischen Code in Hilfsmethoden oder Oberklassen heraus, bis eine kompakte fachliche Beschreibung entsteht.
Ihr werdet dann schneller und flexibler, wenn die Anforderungen sich ändern. Und, verlasst Euch drauf, das werden sie.

### Kommentare

> Ein Teste!
