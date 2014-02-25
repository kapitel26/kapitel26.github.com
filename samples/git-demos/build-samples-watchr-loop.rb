#!/usr/bin/env watchr
# Eine erste Änderung im externen Projekt
watch( 'git-demos/.*.rb$' ) { |md| system 'ccdd --run-tests "ruby git-demos/build-samples.rb"' }


