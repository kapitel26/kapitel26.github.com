| | Branche | Wer |
|-------|------|---------|
| **A** | Verwaltung | Wasswerke |
| **B** | Logistik | HHLA |
| **C** | Finanzen | Payone |
| **D** | Versicherung | TK |
| **E** | Embedded | MEN |

Großes oder kleines Repo?
=========================
 * A - jede Anwendung ein Repo, Gemeinsame Module ein Repo
 * B - erst klein, dann groß
 * C - ein großes Repo
 * D - viele kleine Repos + ein großes Repo
 * E - kleine Repos


Repo-Abhängigkeiten: Git oder Extern?
=========================
 * A - extern / Gradle
 * B - extern / Maven
 * C - ???
 * D - Subtree
 * E - extern

Administration: Wer macht was?
=========================

Berchtigungen: Wer darf was?
=========================

Push oder Pull-Requests?
=========================
 * A - Push
 * B - Push
 * C - Pull-Requests
 * D - Pull-Requests
 * E - ???

Feature Branch?
=========================
 * A - Nein
 * B - Manchmal nciht vorgschrieben
 * C - Ja
 * D - Ja
 * E - ???


Merge oder Rebase?
=========================

 * A - Rebase
 * B - Sowohl als auch
 * C - Rebase
 * D - Merge
 * E - ???


Böse Merge-Konflikte?
=========================

Task-Tracker?
=========================
 * A - Nein
 * B - Nein
 * C - Ja
 * D - Ja
 * E - ???



Diff-To-Master oder Commit-By-Commit?
=========================
 * A - kein review
 * B - ???
 * C - Pull-Request-Review ~Diff-To-Master
 * D - Pull-Request-Review ~Diff-To-Master
 * E - ???

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

Branches, Tags, Notes?
=========================
 * A - Branches
 * B - Branches + Tags
 * C - Branches + Tags
 * D - Branches + Tags
 * E - ???

Bauen mit Jenkins?
=========================
 * A - Ja, Autmatisch bei Änderungen, Manuell getriggertes Deployment
 * B - ???
 * C - Ja
 * D - Ja, komplex Build-Kette
 * E - ???
