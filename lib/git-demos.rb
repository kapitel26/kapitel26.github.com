class GitDemos

	attr_reader :log

	def initialize dir
		@basedir = dir
		@log = []
	end

	def init
		FileUtils.mkdir_p @basedir
		@log << { desc: "Initialize demo directory in '#{@basedir}'" } 	
	end
end