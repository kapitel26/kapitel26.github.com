#!/usr/bin/env watchr
watch( 'git-demos/.*.rb$' ) { |md| system 'ccdd --run-tests "ruby git-demos/build-samples.rb"' }


