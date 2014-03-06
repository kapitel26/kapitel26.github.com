#!/usr/bin/env watchr
watch( 'samples/git-demos/.*.rb$' ) { |md| system 'ccdd --run-tests "ruby samples/git-demos/build-samples.rb"' }
