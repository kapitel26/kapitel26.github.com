| | Branche | Wer |
|-------|------|---------|
| **A** | Verwaltung | Wasswerke |
| **B** | Logistik | HHLA |
| **C** | Finanzen | Payone |
| **D** | Versicherung | TK |
| **E** | Embedded | MEN |
| **F** |  | |
| **G** |  | |
| **H** | e-Commerce | |
| **I** |  | |
| **J** | Forschung | |
| **K** |  | |

Großes oder kleines Repo?
=========================
 * A - jede Anwendung ein Repo, Gemeinsame Module ein Repo
 * B - erst klein, dann groß
 * C - ein großes Repo
 * D - viele kleine Repos + ein großes Repo
 * E - kleine Repos
 * H - viele Repos
 * J - Beides


Repo-Abhängigkeiten: Git oder Extern?
=========================
 * A - extern / Gradle
 * B - extern / Maven
 * C - ???
 * D - Subtree
 * E - extern
 * H - extern / Maven
 * J - extern / RPM

Administration: Wer macht was?
=========================

 * H - Branches Devs, Repos wenig
 * J - sind Admins

Berchtigungen: Wer darf was?
=========================

 * J - freier Zugriff im Team, aber signes Tags für ausgelieferte Versionen

Push oder Pull-Requests?
=========================
 * A - Push
 * B - Push
 * C - Pull-Requests
 * D - Pull-Requests
 * E - ???
 * H - Push
 * J - Push

Feature Branch?
=========================
 * A - Nein
 * B - Manchmal nciht vorgschrieben
 * C - Ja
 * D - Ja
 * E - ???
 * F - Ja, Branch per Jira-Issue, wenige Tage
 * J - Ja


Merge oder Rebase?
=========================

 * A - Rebase
 * B - Sowohl als auch
 * C - Rebase
 * D - Merge
 * E - ???
 * H - Sowohl als auch
 * J - Merge


Böse Merge-Konflikte?
=========================

 * H - nein
 * J - nein

Task-Tracker?
=========================
 * A - Nein
 * B - Nein
 * C - Ja
 * D - Ja
 * E - ???
 * H - Ja, Jira, Branchname
 * J - Nein



Diff-To-Master oder Commit-By-Commit?
=========================
 * A - kein review
 * B - ???
 * C - Pull-Request-Review ~Diff-To-Master
 * D - Pull-Request-Review ~Diff-To-Master
 * E - ???
 * H - Commit-by-Commit nach Jenkins-Mail
 * J - Selten, Diff2master

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
 * J - ???

Branches, Tags, Notes?
=========================
 * A - Branches
 * B - Branches + Tags
 * C - Branches + Tags
 * D - Branches + Tags
 * E - ???
 * H - Branches
 * J - Signed Tags

Bauen mit Jenkins?
=========================
 * A - Ja, Autmatisch bei Änderungen, Manuell getriggertes Deployment
 * B - ???
 * C - Ja
 * D - Ja, komplex Build-Kette
 * E - ???
 * H - Ja
 * J Nein, Scripte zum RPM-Package-Build
