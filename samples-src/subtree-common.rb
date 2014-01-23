def createSubtreeSampleMainProject(demo)
	demo.section do
		new_repo 'lecker'
		cd 'lecker'
		create_and_commit 'wurst/salami'
		create_and_commit 'kaese/gouda'
		edit_and_commit 'wurst/salami'
		edit_and_commit 'kaese/gouda', 'wurst/salami'
		create_and_commit 'kaese/edamer'
	end
end

def createCreateAndCloneSubprojectKaese(demo)
	demo.section do

		shell 'git init --bare ../kaese.git'
		shell 'git subtree push --prefix kaese ../kaese.git master'
		cd '..'
		shell 'git clone kaese.git kaese'

	end
end