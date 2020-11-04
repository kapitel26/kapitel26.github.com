<!-- .slide: data-background-image="07/modules.png" -->

### Aber es gibt doch auch...

### ... **`git submodule`** ... und
### **`git subtree`** ... gibt es doch auch.
### **Hilft das?**

================================================================

### Git unterstützt zwei Arten der Modularisierung

 * Submodules
   
   ```git submodule init/add/update```
   
 * Subtrees
   
   ```git subtree add/pull/push```

notes:

Beispiel: Data Scientisten nutzen Untility-Module


================================================================


### Beispiel

Das `UNTER` soll als Modul in `OBER` genutzt werden.

```bash
   OBER/
   |-- foo              # Datei auf Top-Level
   |-- UNTER/
       |-- bar          # Datei aus "UNTER"    
```


================================================================


### Submodules

> wie Soft-Links

Das übergeordnete Repo kennt nur die **URL** und ein **Commit-Hash** 
aus dem Untergeordneten.

```bash
   OBER/
   |-- .git/
   |   |-- ...Git-Kram...
   |-- foo
   |-- UNTER/                  # OBER kennt URL + Commit-Hash
       |-- .git/               # Separates Repo
       |   |-- ...Git-Kram...
       |-- bar                 # Nicht im log von "OBER"
```


================================================================

### Separate Historien bei Submodules

Log von `UNTER`:

```bash
3a0aff17 edit bar again
8e1508df edit bar
f05e91fa create bar
fe6cf6d7 init UNTER
```


Log von `OBER`:

```bash
8952f352 update module UNTER to 3a0aff17
8952f352 add module UNTER at 8e1508df
3a0aff17 create foo
8e1508df init OBER
```

================================================================


### Subtrees

> Commits kopieren

Commits werden vom untergeordenten Repo in das Übergeordnete kopiert,
wobei die Inhalte um eine Verzeichnisebene verschoben werden.

```bash
   OBER/
   |-- .git/
   |   |-- ...Git-Kram...
   |-- foo
   |-- UNTER/       # "UNTER/bar" ist Datei in "OBER"          
       |-- bar      # Commits, die "bar" modifizieren
                    # wurden kopiert.
```


================================================================

### Kopierte Commits bei Subtrees


Log von `UNTER`:

```bash
3a0aff17 edit bar again
8e1508df edit bar
f05e91fa create bar
fe6cf6d7 init UNTER
```

Log von `OBER`:

```bash
79e91afa edit bar again      # kopiert aus "UNTER"
9b31c60f edit bar            # kopiert aus "UNTER"
ce889e8e create bar          # kopiert aus "UNTER"
a6d3e59d init UNTER          # kopiert aus "UNTER"
3a0aff17 create foo
8e1508df init OBER
```

================================================================


### Submodule und Subtree binden weitere Repos in Unterverzeichnisse ein.

 * *In der Theorie* kombiniert dies die Vorteile.
   - großes Repo zum Integrieren
   - kleine Repos zum Arbeiten
 
 * *In der Praxis* kombinieren sich eher die Nachteile
   - hohe Komplexität, Fehleranfälligkeit
   - aufwändige Synchronisation

notes:

