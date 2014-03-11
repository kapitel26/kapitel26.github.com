def createSubtreeSampleMainProject(demo)
	demo.section do
		new_repo 'lecker'
		cd 'lecker'
		create_and_commit 'wurst/salami'
		create_and_commit 'kaese/gouda'
		edit_and_commit 'wurst/salami'
		edit_and_commit 'kaese/gouda', 'wurst/salami'
		create_and_commit 'kaese/edamer'
		cd '..'
	end
end

def createCreateAndCloneSubprojectKaese(demo)
	demo.section do
		cd 'lecker'
		shell 'git init --bare ../kaese.git'
		shell 'git remote add kaese.git ../kaese.git'
		shell 'git subtree push --prefix kaese kaese.git master'
		shell 'git subtree pull --prefix kaese kaese.git master'
		cd '..'
	end
end