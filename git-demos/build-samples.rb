$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.dirname(__FILE__)+"/../lib"
$LOAD_PATH.unshift File.dirname(__FILE__)+"/samples-src"

require "git-demos"

message = "Samples created:"

FileUtils.mkdir_p "samples"
Dir.glob("#{File.dirname(__FILE__)}/samples-src**/*.rb") do |f|
	load f
	htmlname = "samples/#{File.basename(f)}.html"
	markdown = @demo.to_markdown(htmlname)

	File.write("samples/#{File.basename(f)}.md",markdown)

	message << " " << htmlname
end

puts message
