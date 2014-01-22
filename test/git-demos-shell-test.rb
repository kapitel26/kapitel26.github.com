# encoding: UTF-8

class GitDemosShellTest < AbstractGitDemosTest

	def test_shell
		@demo.shell 'mkdir wurstpelle'

		assert File.directory? 'tmp/wurstpelle'
		assert_equal "Execute shell command 'mkdir wurstpelle'.", @demo.log.last[:desc]
		assert_equal ["$ mkdir wurstpelle"], @demo.log.last[:shell]
	end

	def test_shell_output
		@demo.shell 'echo MOIN'

		assert_equal ["MOIN"], @demo.log.last[:out]
	end

	def test_shell_output_multiline_output
		@demo.shell 'echo "MOIN\n  WELT"'

		assert_equal ["MOIN", "  WELT"], @demo.log.last[:out]
	end

	def test_shell_output_multiline_commands
		@demo.shell 'echo hallo', "2 commands"
		@demo._shell 'echo welt'

		assert_equal "2 commands", @demo.log.last[:desc]
		assert_equal ["$ echo hallo", "$ echo welt"], @demo.log.last[:shell]
		assert_equal ["hallo", "welt"], @demo.log.last[:out]
	end

	def test_shell_raises_exception_after_exitcode
		assert_raises(RuntimeError) do
			@demo.shell 'cat adaf234214'
		end
	end

end
