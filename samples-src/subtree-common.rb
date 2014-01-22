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

