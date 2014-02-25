#!/usr/bin/env watchr
# Noch 'ne externe Änderung
# Eine erste Änderung im externen Projekt
# Eine Änderung im großen Projekt
watch( 'git-demos/.*.rb$' ) { |md| system 'ccdd --run-tests "ruby git-demos/build-samples.rb"' }


