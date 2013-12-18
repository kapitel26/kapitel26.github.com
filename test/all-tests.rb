$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.dirname(__FILE__)+"/../lib"
$LOAD_PATH.unshift File.dirname(__FILE__)+"/../samples-src"

require "fileutils"
require "test/unit"

require "rubygems"
require "maruku"

require "git-demos"

require "git-demos-test"
require "git-demos-command-test"
require "git-demos-rendering-test"

FileUtils.mkdir_p "samples"
Dir.glob('samples-src**/*.rb') do |f|
	load f
	basename = File.basename(f)
	@demo.to_markdown("samples/#{basename}.html")
end

