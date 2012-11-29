module MercurialExtension
	
	def hg command
		sh "hg #{command}"
	end

	def hg_merge(p)
		p[:branch] ||= silent_sh("hg branch")[0]
		hg "up #{p[:onto]}"
		hg "merge #{p[:branch]}"
		hg "commit -m 'merge #{p[:branch]} onto #{p[:onto]}'"
	end

	def hg_graft(p)
		hg "branch"
		p[:rev] ||= silent_sh("hg log -r . --template '{rev}\\n'")[0]
		hg "up #{p[:onto]}"
		hg "graft -r #{p[:rev]}"
	end

	def hg_to_branch branch
		out, err, command, exitcode = sh "hg log -r #{branch}", :valid_exits => [0,255]
		if exitcode == 255
			hg "branch #{branch}"
		else
			hg "update #{branch}"
		end
	end

	def hg_commit comment
		silent_sh "hg commit -A -m \"#{comment}\"" 
	end

end
