# encoding: UTF-8

class GitDemosRenderingTest < AbstractGitDemosTest


	def test_empty_to_markdown
		assert_equal <<-EOS, @demo.to_markdown
		EOS
	end

	def test_text_to_markdown
		@demo.text 'XYZ'

		assert_equal <<-EOS, @demo.to_markdown
XYZ
		EOS
	end

# ```Test``` XXX **```git add `ls` s#  ```**
	def test_shell_to_markdown
		@demo.shell 'echo A'

		assert_equal <<-EOS, @demo.to_markdown
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
<pre>
$ <b>git init my-little-repo</b>
Initialized empty Git repository in /Users/stachi/work/git-demos/tmp/my-little-repo/.git/
my-little-repo $ <b>touch wurst</b>
</pre>
		EOS
	end

	def test_to_markdown_multiline
		@demo.shell "echo A; echo '   B'; echo 	C"

		assert_equal <<-EOS, @demo.to_markdown
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
Hallo
Welt

		EOS
	end

	def test_show
		@demo.show :shell, :text
		
		@demo.text "MOIN"
		@demo.shell 'echo A'
		assert_equal <<-EOS, @demo.to_markdown
MOIN
<pre>
$ <b>echo A</b>
</pre>
		EOS
	end

	def test_block
		@demo.show :out do
			@demo.shell 'echo A'
		end
		@demo.text "MOIN"
		assert_equal <<-EOS, @demo.to_markdown
<pre>
A
</pre>
MOIN
		EOS
	end


	def test_show_nothing
		@demo.show 

		@demo.text 'MOIN'
		@demo.shell 'echo A'
		assert_equal <<-EOS, @demo.to_markdown
		EOS
	end

end