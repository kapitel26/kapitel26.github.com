# encoding: UTF-8

class GitDemosShortcutTest < AbstractGitDemosTest

	def test_new_repo
		@demo.new_repo 'my-little-repo'

		`cd tmp/my-little-repo && git status`
		assert_equal 0, $?.to_i

		assert_equal ["$ git init my-little-repo"], @demo.log.last[:shell]
	end

	def test_create_and_commit
		@demo.new_repo 'repo'
		@demo.cd 'repo'

		@demo.create_and_commit 'file'

		assert File.exists? 'tmp/repo/file'
		assert_equal ["repo $ git add file", "repo $ git commit -m 'create file'"], @demo.log.last[:shell]
		assert_equal "create file", last_commit_comment
	end

	def test_edit_and_commit
		@demo.new_repo 'repo'
		@demo.cd 'repo'
		@demo.shell 'touch file-a'
		@demo.shell 'touch file-b'

		@demo.edit_and_commit 'file-a', 'file-b'

		assert File.read('tmp/repo/file-a').length > 0
		assert File.read('tmp/repo/file-b').length > 0
		assert_equal ["repo $ git add file-a file-b", "repo $ git commit -m 'edit file-a, file-b'"], @demo.log.last[:shell]
		assert_equal "edit file-a, file-b", last_commit_comment
	end

	def test_log
		@demo.new_repo 'repo'
		@demo.cd 'repo'
		@demo.create_and_commit 'file-a'
		@demo.create_and_commit 'file-b'
		@demo.gitlog

		assert_equal <<-__ ,  @demo.log.last[:out].join("\n")+"\n"
-- Branch 'master' in 'repo' --
* create file-b  (HEAD, master)
* create file-a
		__

		@demo.gitlog '-1'

		assert_equal <<-__ ,  @demo.log.last[:out].join("\n")+"\n"
-- Branch 'master' in 'repo' --
* create file-b  (HEAD, master)
		__


	end

	def last_commit_comment
		/[0-9a-z]+\s+(.*)/.match(@demo.shell('git log --oneline -1')[0])[1]
	end

	def test_show_all
		@demo.show []

		@demo.show_all

		@demo.text "Text"
		@demo.shell "echo Moin"
		assert_equal <<-__, @demo.to_markdown
<!-- working directory in tmp -->
Text
<pre>
$ <b>echo Moin</b>
Moin
</pre>
	__
	end

	def test_hide_output
		@demo.show []

		@demo.hide_output

		@demo.text "Text"
		@demo.shell "echo Moin"
		assert_equal <<-__, @demo.to_markdown
<!-- working directory in tmp -->
Text
<pre>
$ <b>echo Moin</b>
</pre>
		__
	end

	def test_hide_shell
		@demo.show []

		@demo.hide_shell

		@demo.text "Text"
		@demo.shell "echo Moin"
		assert_equal <<-__, @demo.to_markdown
<!-- working directory in tmp -->
Text
<pre>
Moin
</pre>
		__
	end


end
