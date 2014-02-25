message = "Samples created:"

FileUtils.mkdir_p "samples"
Dir.glob('samples-src**/*.rb') do |f|
	load f
	htmlname = "samples/#{File.basename(f)}.html"
	markdown = @demo.to_markdown(htmlname)

	File.write("samples/#{File.basename(f)}.md",markdown)

	message << " " << htmlname
end

puts message
