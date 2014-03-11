module Directories

	def cd directory
		if directory == ".." 
			@current_path.pop
		else
			@current_path << directory
		end
	end

	def working_dir
		([@basedir] << @current_path).join('/')
	end

	def pwd
		@current_path.join('/')
	end

end