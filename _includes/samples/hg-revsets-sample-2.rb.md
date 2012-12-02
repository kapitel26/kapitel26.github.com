    > hg init
    
    > hg branch releases
    marked working directory as branch releases
    (branches are permanent and global, did you want a bookmark?)
    
    # Create file "hgrc"
    
    # Create line 0,1,2,3,4,5 in file "hello"
    
    > hg log -r FIX_merge_before
    abort: unknown revision 'FIX_merge_before'!
    
    > hg branch FIX_merge_before
    marked working directory as branch FIX_merge_before
    (branches are permanent and global, did you want a bookmark?)
    
    # Edit file "hello"
    
    > hg up releases
    1 files updated, 0 files merged, 0 files removed, 0 files unresolved
    
    > hg merge FIX_merge_before
    1 files updated, 0 files merged, 0 files removed, 0 files unresolved
    (branch merge, don't forget to commit)
    
    > hg commit -m 'merge FIX_merge_before
       onto releases'
    
    > hg log -r FIX_graft_before
    abort: unknown revision 'FIX_graft_before'!
    
    > hg branch FIX_graft_before
    marked working directory as branch FIX_graft_before
    (branches are permanent and global, did you want a bookmark?)
    
    # Edit file "hello"
    
    > hg branch
    FIX_graft_before
    
    > hg up releases
    1 files updated, 0 files merged, 0 files removed, 0 files unresolved
    
    > hg graft -r 4
    grafting revision 4
    
    > hg tag release_1_1_3
    
    > hg log -r FIX_merge_after
    abort: unknown revision 'FIX_merge_after'!
    
    > hg branch FIX_merge_after
    marked working directory as branch FIX_merge_after
    (branches are permanent and global, did you want a bookmark?)
    
    # Edit file "hello"
    
    > hg up releases
    1 files updated, 0 files merged, 0 files removed, 0 files unresolved
    
    > hg merge FIX_merge_after
    1 files updated, 0 files merged, 0 files removed, 0 files unresolved
    (branch merge, don't forget to commit)
    
    > hg commit -m 'merge FIX_merge_after
       onto releases'
    
    > hg log -r FIX_graft_after
    abort: unknown revision 'FIX_graft_after'!
    
    > hg branch FIX_graft_after
    marked working directory as branch FIX_graft_after
    (branches are permanent and global, did you want a bookmark?)
    
    # Edit file "hello"
    
    > hg branch
    FIX_graft_after
    
    > hg up releases
    1 files updated, 0 files merged, 0 files removed, 0 files unresolved
    
    > hg graft -r 9
    grafting revision 9
    
    > hg log -r FOX
    abort: unknown revision 'FOX'!
    
    > hg branch FOX
    marked working directory as branch FOX
    (branches are permanent and global, did you want a bookmark?)
    
    # Edit file "hello"
    
    > hg up releases
    1 files updated, 0 files merged, 0 files removed, 0 files unresolved
    
    > hg merge FOX
    1 files updated, 0 files merged, 0 files removed, 0 files unresolved
    (branch merge, don't forget to commit)
    
    > hg commit -m 'merge FOX
       onto releases'
    
    > hg branch FIX_open
    marked working directory as branch FIX_open
    (branches are permanent and global, did you want a bookmark?)
    
    # Edit file "hello"
    
    > hg log --graph
    @  13@FIX_open: Edit file hello
    |
    o    12@releases: merge FOX
    |\
    | o  11@FOX: Edit file hello
    |/
    o  10@releases: Edit file hello
    |
    | o  9@FIX_graft_after: Edit file hello
    |/
    o    8@releases: merge FIX_merge_after
    |\
    | o  7@FIX_merge_after: Edit file hello
    |/
    o  6@releases: Added tag release_1_1_3 for changeset 394f125a4108
    |
    o  5@releases: Edit file hello
    |
    | o  4@FIX_graft_before: Edit file hello
    |/
    o    3@releases: merge FIX_merge_before
    |\
    | o  2@FIX_merge_before: Edit file hello
    |/
    o  1@releases: Create line 0,1,2,3,4,5 in file hello
    |
    o  0@releases: Create file hgrc
    
    
    > hg log -r "branch('re:FIX_.*')"
    2@FIX_merge_before: Edit file hello
    4@FIX_graft_before: Edit file hello
    7@FIX_merge_after: Edit file hello
    9@FIX_graft_after: Edit file hello
    13@FIX_open: Edit file hello
    
    > hg log -r "ancestors('release_1_1_3')"
    0@releases: Create file hgrc
    1@releases: Create line 0,1,2,3,4,5 in file hello
    2@FIX_merge_before: Edit file hello
    3@releases: merge FIX_merge_before
    5@releases: Edit file hello
    
    > hg log -r "origin(ancestors('release_1_1_3'))"
    4@FIX_graft_before: Edit file hello
    
Mehr? Herausfinden, welche Bugfixes im `release_1_1_3` noch nicht
enthalen sind:

    > hg log -r "branch('re:^FIX_.*')
                 - ancestors('release_1_1_3')"
    4@FIX_graft_before: Edit file hello
    7@FIX_merge_after: Edit file hello
    9@FIX_graft_after: Edit file hello
    13@FIX_open: Edit file hello
    
Stimmt noch nicht ganz. Bugfixes könne ja auch per Cherry-Pick
(`graft`, `transplant` oder `rebase`) übertragen worden sein:

    > hg log -r "branch('re:^FIX_.*')
                 - (ancestors('release_1_1_3')
                    or origin(ancestors('release_1_1_3')))"
    7@FIX_merge_after: Edit file hello
    9@FIX_graft_after: Edit file hello
    13@FIX_open: Edit file hello
    
