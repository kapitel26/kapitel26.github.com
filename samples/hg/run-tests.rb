#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.dirname(__FILE__)+"/lib")
$LOAD_PATH << File.expand_path(File.dirname(__FILE__)+"/test")

require "commandline-sample-maker"

require "bash-wrapper-test"
require "demo-commandline-test"
require "markdown-renderer-test"
require "mercurial-extensions-test"