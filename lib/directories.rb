module Directories

	def cd directory
		description "Change directory to '#{directory}'."

		if directory == ".." 
			@current_path.pop
		else
			@current_path << directory
		end
	end

	def pwd
		([@basedir] << @current_path).join('/')
	end

end