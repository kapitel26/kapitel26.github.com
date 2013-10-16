  514  git clone shared.git/ bjoern
  515  cd bjoern/
  516  git branch --all
  517  git checkout kata-hash-collisions-setup
  518  git checkout -b lehmanns 
  519  git push --set-upstream origin lehmanns
  520  ls
  521  ruby test/hashcollisions-test.rb 
  522  ruby test/all-tests.rb 
  523  ruby test/all-tests.rb 
  524  git commit -am "ersetze Rationals durch Doubles"
  525  git log --oneline
  526  watchr watchr-loop.rb 
  527  cd ..
  528  git clone shared.git/
  529  git clone shared.git/ rene
  530  rm -rf shared
  531  cd rene/
  532  watchr watchr-loop.rb 
  533  git commit -am "fix: show right linenumber in assertion message"
  534  git reset head^
  535  git stash
  536  git branch --all
  537  git checkout lehmanns
  538  git stash pop
  539  git commit -am "fix: show right linenumber in assertion message"
  540  git log --oneline 
  541  git log --oneline --decorate
  542  cd ..
  543  cd bjoern/
  544  git pull
  545  cd ..
  546  cd rene
  547  git push
  548  cd ../bjoern/
  549  git pull
  550  git reset --hard head^
  551  git rebase origin/lehmanns 
  552  watchr  watchr-loop.rb 
  553  git rebase --interactive 
  554  git rebase --interactive 
  555  git rebase --interactive 
  556  git log --oneline 
  557  git reset head^
  558  git diff
  559  git gui
  560  git log --oneline 
  561  git rebase --continue 
  562  git rebase --interactive 
  563  git checkout -b hotfix-repair-message
  564  git branch -f lehmanns head^
  565  git rebase lehmanns --onto kata-hash-collisions-setup 
  566  vim ~/.bash_profile 
  567  vim ~/.bash_profile 
  568  history | tail
  569  history > ~/work/kapitel26/lehmanns-beispiel2.log 
