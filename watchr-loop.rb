#!/usr/bin/env watchr
watch( '.*.rb$' ) { |md| system 'ccdd --run-tests "ruby test/all-tests.rb"' }


