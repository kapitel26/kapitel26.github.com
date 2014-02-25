#!/usr/bin/env watchr
# jetzt hier in kapitel26 und hier in git-demos und noch mehr
watch( 'git-demos/.*.rb$' ) { |md| system 'ccdd --run-tests "ruby git-demos/build-samples.rb"' }


