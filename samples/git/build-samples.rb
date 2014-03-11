basedir = File.dirname(__FILE__)

$LOAD_PATH.unshift basedir + "/../../_tools/git-demos/lib"
$LOAD_PATH.unshift basedir + "/samples-src"

require "git-demos"

message = "Samples created:"


FileUtils.mkdir_p "samples"
Dir.glob("#{basedir}/samples-src**/*.rb") do |f|
	load f
	markdown = @demo.to_markdown
	mdfile = "_posts/#{File.basename(f)}.md"
	File.write(mdfile, markdown)

	message << " " << mdfile
end

puts message
