| | Branche |
|-------|------|
| **A** | Verwaltung |
| **B** | Logistik |
| **C** | Finanzen |
| **D** | Versicherung |
| **E** | Embedded |
| **F** |  |
| **G** |  |
| **H** | e-Commerce |
| **I** | e-Commerce |
| **J** | Forschung |
| **K** | e-Commerce |
| **L** | Open Source |
| **M** | Cloud |

Großes oder kleines Repo?
=========================
 * A - jede Anwendung ein Repo, Gemeinsame Module ein Repo
 * B - erst klein, dann groß
 * C - ein großes Repo
 * D - viele kleine Repos + ein großes Repo
 * E - kleine Repos
 * H - viele Repos
 * I - Große + einige Kleine
 * J - Beides
 * K - Großes
 * L - Großes
 * M - viele Repos



Repo-Abhängigkeiten: Git oder Extern?
=========================
 * A - extern / Gradle
 * B - extern / Maven
 * C - ???
 * D - Subtree
 * E - extern
 * H - extern / Maven
 * I - extern / Maven
 * J - extern / RPM Package Manager
 * K - ???
 * L - extern / Maven
 * M - extern / Package manager

Administration: Wer macht was?
=========================

 * H - Branches Devs, Repos wenig
 * I - Branches Devs, Repos wenig
 * J - sind Admins
 * K - Branches Devs, Repo auf Githun
 * L - Branches Devs, Repo auf Githun
 * M - Branches Devs, Repo auf Github enterpr

Berechtigungen: Wer darf was?
=========================

 * I - jeder Alles
 * J - freier Zugriff im Team, aber signes Tags für ausgelieferte Versionen
 * K - freier Zugriff
 * L - Nur mainter Push, Devs per PR
 * M - freier Zugriff

Push oder Pull-Requests?
=========================
 * A - Push
 * B - Push
 * C - Pull-Requests
 * D - Pull-Requests
 * E - ???
 * H - Push
 * I - Push
 * J - Push
 * K - Push
 * L - Pull-Requests
 * M - Push

Feature Branch?
=========================
 * A - Nein
 * B - Manchmal nciht vorgschrieben
 * C - Ja
 * D - Ja
 * E - ???
 * F - Ja, Branch per Jira-Issue, wenige Tage
 * I - Manchmal
 * J - Ja
 * K - Nein, (aber manchmal länger lebende regionale Branches)
 * L - Ja
 * M - Ja, Branch per Issue


Merge oder Rebase?
=========================

 * A - Rebase
 * B - Sowohl als auch
 * C - Rebase
 * D - Merge
 * E - ???
 * H - Sowohl als auch
 * I - Merge
 * J - Merge
 * K - Merge
 * L - Merge
 * M - Merge


Böse Merge-Konflikte?
=========================

 * H - nein
 * I - nein
 * J - nein
 * K - Ja, wegen langlebiger branches
 * L - Selten
 * M - nein

Task-Tracker?
=========================
 * A - Nein
 * B - Nein
 * C - Ja
 * D - Ja
 * E - ???
 * H - Ja, Jira, Branchname
 * I - ???
 * J - Nein
 * K - Ja, Issue-ID in Commits
 * L - ???
 * M - ???, Jira



Diff-To-Master oder Commit-By-Commit?
=========================
 * A - kein review
 * B - ???
 * C - Pull-Request-Review ~Diff-To-Master
 * D - Pull-Request-Review ~Diff-To-Master
 * E - ???
 * H - Commit-by-Commit nach Jenkins-Mail
 * I - Selten, Berührungsängste
 * J - Selten, Diff2master
 * K - Selten
 * L - Diff 2 Master
 * Diff-to-master

Schöne Historie / Interaktives Rebase?
=========================
 * alle nein

Staging Branches?
=========================
 * A - teilweise
 * B - ???
 * C - GitFlow - Ja
 * D - Ja
 * E - ???
 * H - master Branch
 * I - ???
 * J - ???
 * L - Master (und feature-branches)
 * M - Master (noch pre-alpha)

Branches, Tags, Notes?
=========================
 * A - Branches
 * B - Branches + Tags
 * C - Branches + Tags
 * D - Branches + Tags
 * E - ???
 * H - Branches
 * I - Tags
 * J - Signed Tags
 * K - Tags
 * L - Tags
 * M - Tags

Bauen mit Jenkins?
=========================
 * A - Ja, Autmatisch bei Änderungen, Manuell getriggertes Deployment
 * B - ???
 * C - Ja
 * D - Ja, komplex Build-Kette
 * E - ???
 * H - Ja
 * I - Ja
 * J - Nein, Scripte zum RPM-Package-Build
 * K - Ja
 * L - Ja
 * M - Nein
