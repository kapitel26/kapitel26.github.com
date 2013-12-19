$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.dirname(__FILE__)+"/../lib"
$LOAD_PATH.unshift File.dirname(__FILE__)+"/../samples-src"

require "test/unit"

require "git-demos"

require "git-demos-test"
require "git-demos-command-test"
require "git-demos-rendering-test"

require "create-samples.rb"