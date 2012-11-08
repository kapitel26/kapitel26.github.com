require "fileutils"

class DemoCommandline

	@@edit_nr = 1

	def initialize(&block)
		@root="sample1"
		FileUtils::rm_rf @root
		FileUtils::mkdir @root

		self.instance_eval &block

		$stdout.flush
	end

	def fullpath(ext = nil)
		if ext.nil?
			@root
		else
			"#{@root}/#{ext}"
		end
	end

	def sh command
		puts "> #{command}"
		puts
		out = `cd #{fullpath}; #{command}` 
		out.each_line do |line|
			puts "  #{line}"
		end
		puts unless out.empty?
	end

	def comment text
		puts "# #{text}"
	end

	def edit(filepath, options = {})
		opts = {:line_numbers => [], :commit => true}.merge(options)

		if File.exists?(fullpath(filepath))
			lines = File.new(fullpath(filepath)).lines.to_a
			message = "Created"
		else
			lines = []
			message = "Edited"
		end

		message << " file #{filepath}  lines #{opts[:line_numbers].inspect}  (edit nr. #{@@edit_nr})"

		if opts[:content].nil?
			opts[:content] = edit_lines(lines, opts[:line_numbers], message).join() 
		end
		
		open_file(fullpath(filepath), "w") { |f| f << opts[:content] }

		sh "hg commit -A -m \"#{message}\"" if opts[:commit]
	end

	private

	def open_file(filepath, mode = "r", &block)
		File.open(filepath, mode, &block)
	end

	def edit_lines(lines, line_numbers, message)
		line_numbers = [lines.size] if line_numbers.empty?
		line_numbers.each do |nr| 
			@@edit_nr += 1
			lines[nr] = "#{nr}: #{message}\n" 
		end
		lines.map { |line| line ||= "\n" }
	end
end

DemoCommandline.new do
	sh 'hg init'

	sh 'hg branch releases'
	edit '.hg/hgrc', 
		:content =>"[ui]\nlogtemplate=\"{rev} on {branches}: {desc|firstline}\\n\"\n",
		:commit => :false
	edit 'user-roles.xml', :line_numbers => [0,1,2]
	edit 'file2'

	sh 'hg branch myfeature'
	edit 'file3'

	sh 'hg up releases'
	sh 'hg merge myfeature'
	sh 'hg commit -m "merge myfeature into releases"'
	edit 'user-roles.xml', :line_numbers => [0]
	sh 'hg tag release_1_1_3'

	sh 'hg up myfeature'
	edit 'user-roles.xml'
	sh 'hg merge releases --tool internal:merge'
	sh 'hg commit -m "merge releases into feature"'
	edit 'file4'

	sh 'hg log --graph'

    sh 'hg log -r "branch(myfeature)"'
    sh 'hg log -r "branch(myfeature) and not ancestors(release_1_1_3)"'
    sh 'hg log -r "branch(myfeature) and not ancestors(release_1_1_3)' +
       ' and file(\'user-roles.xml\')"'
    sh 'hg log -r "branch(myfeature) and not ancestors(release_1_1_3) ' +
       'and modifies(\'user-roles.xml\') and not merge()"'

    sh 'cat file2'
    sh 'cat file3'
    sh 'cat file4'
    sh 'cat user-roles.xml'

end