$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.dirname(__FILE__)+"/../lib"

require "fileutils"
require "test/unit"

require "git-demos"

require "git-demos-test"
require "git-demos-command-test"
require "git-demos-rendering-test"
