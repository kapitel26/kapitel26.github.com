# encoding: UTF-8

class GitDemosShortcutTest < AbstractGitDemosTest

	def test_new_repo
		@demo.new_repo 'my-little-repo'

		`cd tmp/my-little-repo && git status`
		assert_equal 0, $?.to_i

		assert_equal "Create new repository in 'my-little-repo'.", @demo.log.last[:desc]
		assert_equal ["$ git init my-little-repo"], @demo.log.last[:shell]
	end

	def test_create_and_commit
		@demo.new_repo 'repo'
		@demo.cd 'repo'

		@demo.create_and_commit 'file'

		assert File.exists? 'tmp/repo/file'
		assert_equal "Create and edit 'file'.", @demo.log.last[:desc]
		assert_equal ["repo $ git add file", "repo $ git commit -m 'created new file file'"], @demo.log.last[:shell]
		assert_equal "created new file file", last_commit_comment
	end

	def test_cedit_and_commit
		@demo.new_repo 'repo'
		@demo.cd 'repo'
		@demo.shell 'touch file-a'
		@demo.shell 'touch file-b'

		@demo.edit_and_commit 'file-a', 'file-b'

		assert File.read('tmp/repo/file-a').length > 0
		assert File.read('tmp/repo/file-b').length > 0
		assert_equal "Edit and commit file-a, file-b.", @demo.log.last[:desc]
		assert_equal ["repo $ git add file-a file-b", "repo $ git commit -m 'edited file file-a, file-b'"], @demo.log.last[:shell]
		assert_equal "edited file file-a, file-b", last_commit_comment
	end

	def last_commit_comment
		/[0-9a-z]+\s+(.*)/.match(@demo.shell('git log --oneline -1')[0])[1]
	end

end
