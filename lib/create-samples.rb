message = "Samples created:"

FileUtils.mkdir_p "samples"
Dir.glob('samples-src**/*.rb') do |f|
	load f
	htmlname = "samples/#{File.basename(f)}.html"
	@demo.to_markdown(htmlname)
	message << " " << htmlname
end

puts message
