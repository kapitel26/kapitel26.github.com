require "fileutils"
require "rubygems"
require "maruku"

module GitDemosShortcuts

	def new_repo repo_dir
		shell "git init #{repo_dir}"
	end

	def create_and_commit file
		@log << {}
		_create file
		_shell "git add #{file}"
		_shell "git commit -m 'create #{file}'"
	end

	def edit_and_commit *files
		@log << {}
		_edit *files
		_shell "git add #{files.join(' ')}"
		_shell "git commit -m 'edit #{files.join(', ')}'"
	end

	def gitlog param = ""
		shell <<-EOS
branch=`git rev-parse --abbrev-ref HEAD`; \
	echo \"-- Branch '$branch' in '#{pwd}' --\"; \
	git log --graph --pretty=\"%s %d\" #{param}
		EOS
	end

	def show_all
		if block_given?
			show(:text, :shell, :out, :desc) { yield }
		else
			show :text, :shell, :out, :desc
		end
	end

	def hide_output 
		if block_given?
			show(:text, :shell) { yield }
		else
			show :text, :shell
		end
	end

	def hide_all
		if block_given?
			show() { yield }
		else
			show
		end
	end

	def hide_shell
		if block_given?
			show(:text, :out) { yield }
		else
			show :text, :out
		end
	end
end