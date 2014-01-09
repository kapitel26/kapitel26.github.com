module Directories

	def cd directory
		action "Change directory to '#{directory}'."

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