# encoding: UTF-8

samplename = 'subtree-extract-subproject'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do

	text <<-__
`subtree`-Repository für ein Teilprojekt erstellen
--------------------------------------------------

Es gibt verschieden Gründe, weshalb man mitunter ein Teilprojekt eines größeren Projekts in einem separaten Repository verwalten möchte:

 * Man möchte es als Bibliothek für andere Projekte bereit stellen.
 * Man möchte es Open-Source veröffentlichen. Das Gesamtprojekt aber nicht.
 * Man möchte es von externen Entwicklern weiterentwickeln lassen, ohne dass diese Zugriff auf das Gesamtrepository erhalten.
 * Man möchte den Entwicklern kleinere Repositorys an die Hand geben, weil das Gesamtrepository sehr groß geworden ist.

Natürlich könnte man einfach die Source-Dateien des Teilprojekts aus dem Hauptprojekt entfernen, und sie ein neues, unabhängiges Repository importieren. Wenn man jedoch

 * die Historie der Commits aus dem Hauptrepository übernehmen möchte, 
 * oder künftige Änderungen zwischen Teil- und Gesamtprojekt austauschen möchte, 
 * und die Sourcen vollständig im Gesamptprojekt erhalten möchte,

dann kann es sinnvoll sein, mit `git subtree` zu arbeiten. Ein Beispiel zeigt, wie das tgeh:

#### `lecker` - ein Projekt mit zwei Teilprojekten (Beispiel)
	__

	show
	createSubtreeSampleMainProject(self)

	text <<-__
Das Gesamtprojekt hat drei Dateien in zwei Teilprojekten `wurst` und `kaese`.
Das Log zeigt eine gemischte Historie mit Änderungen an
beiden Teilprojekten.
	__
	show :out, :text
	cd 'lecker'
	gitlog

	text <<-__
Die Dateien `edamer` und `gouda` unterhalb des Verzeichnisses `kaese` sollen in einem eigenen Repository verwaltet werden.

#### Schritt 1: Falls erforderlich, Teilprojekt in ein Verzeichnis bringen

Sorgen Sie dafür, dass alle Dateien des Teilprojekts unterhalb eines Verzeichnisses im Gesamtprojekts liegen. In unserem Beispiel ist dies bereits der Fall. 
Es sollen die Dateien im Unterverzeichnis 'kaese' extrahiert werden.
	__
	shell 'git ls-tree master -r --name-only'
	show :out, :text
	text <<-__
#### Schritt 2: Leeres Repository anlegen

Dann wird das neues Repository für das Teilprojekt angelegt. Wir erzeugen es als `bare`-Repository, weil wir dorthin pushen wollen. Im Beispiel nennen wir es `kaese.git` 
	__
	# cd '..'
	show :shell, :text
	shell 'git init --bare ../kaese.git'
	shell 'git remote add kaeserepo ../kaese.git'

	text <<-__


#### Schritt 3: Übertragen der Commits mit `git subtree push`

Aus dem Gesamtrepository heraus kann man mit `git subtree push` Commits in ein anderes Repository kopieren lassen. 
Der Parameter `--prefix` gibt an, welches Verzeichnis extrahiert werden soll.
	__
	show :shell, :out, :text
	shell 'git subtree push --prefix=kaese ../kaese.git master'

	text <<-__
Falls man später aus dem ausgelagerten Repository (hier: `kaese`) Commits zurückholen möchte,
dann empfiehlt es sich danach gleich ein `git subtree pull` auszuführen.
	__
	shell 'git subtree pull --prefix kaese kaeserepo master'

	text <<-__
Voilà! Das war's.

### Was ist passiert?

Das neue Repository enthält jene Dateien, die im Gesamtrepository unterhalb des `kaese`-Verzeichnisses liegen. Im neuen Repository liegen Sie auf oberster Ebene.
	__
	cd '..'; 
	cd 'kaese.git'; 
	show :out, :shell, :text
	shell 'git ls-tree master -r --name-only'
	text <<-__
Es wurden aber nicht nur die Dateien übernommen, sondern auch ihre Historie. Die Commits wurden kopiert. Das Log zeigt die gleichen Commits wie das Log im Gesamtrepository. Allerdings wurden jene Commits weggelassen, die keine Dateien in `kaese` berührten.
	__
	gitlog
	text <<-__
Auch die Inhalte der Commits sind gefiltert. Betrachtet man ein gemischtes Commit aus dem Gesamtrepository (mit Änderungen in `wurst` und `kaese`, so sieht man im neuen Repository nur die Änderungen an Dateien, die ursprünglich in  'kaese' lagen.
	__
	shell 'git log --oneline --stat head^^!'
	text <<-__
Blabla
	__

	cd '..'
	cd 'lecker'
	shell 'git fetch ../kaese.git'
	shell 'git branch -r'
	gitlog
	text <<-__
TODO: Warum das Pull?
	__


end

