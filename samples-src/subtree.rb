# encoding: UTF-8

FileUtils.rm_rf 'workspaces/subtree'

@demo = GitDemos.new('workspaces/subtree')

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

dann kann es sinnvoll sein, mit `git subtree` zu arbeiten. Ein Beispiel zeigt, wie das geht:

#### `lecker` - ein Projekt mit zwei Teilprojekten (Beispiel)
	__

	hide :out, :shell, :desc

	new_repo 'lecker'
	cd 'lecker'

	create_and_commit 'wurst/salami'
	create_and_commit 'kaese/gouda'
	edit_and_commit 'wurst/salami'
	edit_and_commit 'kaese/gouda', 'wurst/salami'
	create_and_commit 'kaese/edamer'

	show :out

	text <<-__
Das Gesamtprojekt hat drei Dateien in zwei Teilprojekten `wurst` und `kaese`.
	__
	shell 'git ls-tree master -r --name-only'

	text <<-__
Das Log zeigt eine gemischte Historie mit Änderungen an
beiden Teilprojekten.
	__
	shell 'git log --oneline --reverse'
	hide :out

	text <<-__
Die Dateien `edamer` und `gouda` unterhalb des Verzeichnisses `kaese` sollen in einem eigenen Repository verwaltet werden.

#### Schritt 1: Falls erforderlich, Teilprojekt in ein Verzeichnis bringen

Sorgen Sie dafür, dass alle Dateien des Teilprojekts unterhalb eines Verzeichnisses im Gesamtprojekts liegen. In unserem Beispiel ist dies bereits der Fall.

#### Schritt 2: Leeres Repository anlegen

Dann wird das neues Repository für das Teilprojekt angelegt. Wir erzeugen es als `bare`-Repository, weil wir dorthin pushen wollen. Im Beispiel nennen wir es `kaese.git` 
	__

	cd '..'
	show :shell
	shell 'git init --bare kaese.git'

	text <<-__
#### Schritt 3: Übertragen der Commits mit `git subtree push

Aus dem Gesamtrepository heraus kann man mit `git subtree push` Commits in ein anderes Repository kopieren lassen. Der Parameter `--prefix` gibt an, welches Verzeichnis extrahiert werden soll.
	__

	cd 'lecker'
	shell 'git subtree push --prefix kaese ../kaese.git master'

	text <<-__
Voilà! Das war's.

### Was ist passiert?

Das neue Repository enthält jene Dateien, die im Gesamtrepository unterhalb des `kaese`-Verzeichnisses liegen. Im neuen Repository liegen Sie auf oberster Ebene.
	__

	cd '..'; cd 'kaese.git'; 
	show :out; hide :shell
	shell 'git ls-tree master -r --name-only'

	text <<-__
Es wurden aber nicht nur die Dateien übernommen, sondern auch ihre Historie. Die Commits wurden kopiert. Das Log zeigt die gleichen Commits wie das Log im Gesamtrepository. Allerdings wurden jene Commits weggelassen, die keine Dateien in `kaese` berührten.
	__

	shell 'git log --oneline --reverse'

	text <<-__
Auch die Inhalte der Commits sind gefiltert. Betrachtet man ein gemischtes Commit aus dem Gesamtrepository (mit Änderungen in `wurst` und `kaese`, so sieht man im neuen Repository nur die Änderungen an Dateien, die ursprünglich in  'kaese' lagen.
	__

	shell 'git log --oneline --stat head^^!'

end

