# encoding: UTF-8

class GitDemosRenderingTest < AbstractGitDemosTest


	def test_description_to_markdown
		@demo.description 'Hallo Welt!'

		assert_equal <<-EOS, @demo.to_markdown
<!-- working directory in tmp -->
    # Hallo Welt!
		EOS
	end

	def test_text_to_markdown
		@demo.text 'XYZ'

		assert_equal <<-EOS, @demo.to_markdown
<!-- working directory in tmp -->
XYZ
		EOS
	end

# ```Test``` XXX **```git add `ls` s#  ```**
	def test_shell_to_markdown
		@demo.shell 'echo A'

		assert_equal <<-EOS, @demo.to_markdown
<!-- working directory in tmp -->
    # Execute shell command 'echo A'.
<pre>
$ <b>echo A</b>
A
</pre>
		EOS
	end

	def test_to_markdown
		@demo.new_repo 'my-little-repo'
		@demo.cd 'my-little-repo'
		@demo.shell 'touch wurst'

		assert_equal <<-EOS, @demo.to_markdown
<!-- working directory in tmp -->
    # Create new repository in 'my-little-repo'.
<pre>
$ <b>git init my-little-repo</b>
Initialized empty Git repository in /Users/stachi/work/git-demos/tmp/my-little-repo/.git/
</pre>
    # Change directory to 'my-little-repo'.
    # Execute shell command 'touch wurst'.
<pre>
my-little-repo $ <b>touch wurst</b>
</pre>
		EOS
	end

	def test_to_markdown_multiline
		@demo.shell "echo A; echo '   B'; echo 	C"

		assert_equal <<-EOS, @demo.to_markdown
<!-- working directory in tmp -->
    # Execute shell command 'echo A; echo '   B'; echo 	C'.
<pre>
$ <b>echo A; echo '   B'; echo 	C</b>
A
   B
C
</pre>
		EOS

	end

	def test_text_with_markdown
		@demo.text <<-EOS
Hallo
Welt
		EOS

		assert_equal <<-EOS, @demo.to_markdown
<!-- working directory in tmp -->
Hallo
Welt

		EOS
	end

	def test_show
		@demo.show :shell, :text
		
		@demo.text "MOIN"
		@demo.shell 'echo A'
		assert_equal <<-EOS, @demo.to_markdown
<!-- working directory in tmp -->
MOIN
<pre>
$ <b>echo A</b>
</pre>
		EOS
	end

	def test_show_nothing
		@demo.show 

		@demo.text 'MOIN'
		@demo.shell 'echo A'
		assert_equal <<-EOS, @demo.to_markdown
<!-- working directory in tmp -->
		EOS
	end

end