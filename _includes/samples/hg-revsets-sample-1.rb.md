Ein Beispiel: Die aktuelle Software hat die Version `1_1_3`. 
Ein neues Feature soll ausgeliefert werden. 
Die QA entdeckt einen Fehler, den es in `1_1_3` noch nicht
gegeben hat.
Das Beispiel zeigt die Branches `releases` und `myfeature`:


    > hg log --graph
    @  myfeature: Create file file4
    |
    o    myfeature: merge releases into feature
    |\
    | o  myfeature: Edit file user-roles.xml
    | |
    o |  releases: Added tag release_1_1_3 for changeset c9cd4f3a5334
    | |
    o |  releases: Edit line 0 in file user-roles.xml
    | |
    o |  releases: merge myfeature into releases
    |\|
    | o  myfeature: Create file file3
    |/
    o  releases: Create file file2
    |
    o  releases: Create line 0,1,2 in file user-roles.xml
    |
    o  releases: Create file hgrc
    
    
Zeige alle Änderungen auf dem Branch `myfeature`. 


    > hg log -r "branch(myfeature)"
    myfeature: Create file file3
    myfeature: Edit file user-roles.xml
    myfeature: merge releases into feature
    myfeature: Create file file4
    
Oha, ganz schön viele! Aber halt: Teile von `myfeature`
wurden schon in `1_1_3` ausgeliefert. Die können wir
aussortieren.


    > hg log -r "branch(myfeature) 
                 and not ancestors(release_1_1_3)"
    myfeature: Edit file user-roles.xml
    myfeature: merge releases into feature
    myfeature: Create file file4
    
QA sagt, der Fehler könnte was mit Berechtigungen zu tun haben.
Wir untersuchen, ob auf dem Branch seit `release_1_1_3` die Datei
`user-roles.xml` verändert wurde.


    > hg log -r "branch(myfeature) 
                 and not ancestors(release_1_1_3)
                 and file('user-roles.xml')"
    myfeature: Edit file user-roles.xml
    myfeature: merge releases into feature
    
Falls wir jetzt Commits gefunden haben, lohnt es sich vielleicht
noch zu prüfen, ob die Änderung wirklich auf `myfeature` stattgefunden 
haben, und nicht von woanders "hereingemerged" wurde.


    > hg log -r "branch(myfeature)
                 and not ancestors(release_1_1_3)
                 and modifies('user-roles.xml')
                 and not merge()"
    myfeature: Edit file user-roles.xml
    
