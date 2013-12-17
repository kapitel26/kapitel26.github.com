# encoding: UTF-8

class GitDemosRenderingTest < AbstractGitDemosTest

	def test_to_markdown
		@demo.new_repo 'my-little-repo'
		@demo.cd 'my-little-repo'
		@demo.shell 'touch wurst'

		assert_equal <<-EOS, @demo.to_markdown
Initialize demo directory in 'tmp'.

Create new repository in 'my-little-repo'.

    $ git init my-little-repo
    Initialized empty Git repository in /Users/stachi/work/git-demos/tmp/my-little-repo/.git/

Change directory to 'my-little-repo'.

Execute shell command 'touch wurst'.

    my-little-repo $ touch wurst

		EOS
	end

	def test_to_markdown_multiline
		@demo.shell "echo A; echo '   B'; echo 	C"

		assert_equal <<-EOS, @demo.to_markdown
Initialize demo directory in 'tmp'.

Execute shell command 'echo A; echo '   B'; echo 	C'.

    $ echo A; echo '   B'; echo 	C
    A
       B
    C

		EOS

	end
end