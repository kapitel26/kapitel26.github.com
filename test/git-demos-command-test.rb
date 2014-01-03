# encoding: UTF-8

class GitDemosCommandTest < AbstractGitDemosTest

	def test_workspace_after_init
		assert File.directory? 'tmp'
		assert @demo.log.last[:desc] = "Initialize demo directory in 'tmp'"
	end

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

	def test_shell_output_multiline
		@demo.shell 'echo "MOIN\n  WELT"'

		assert_equal ["MOIN", "  WELT"], @demo.log.last[:out]
	end

	def test_cd
		@demo.shell 'mkdir kaese'
		@demo.cd 'kaese'
		assert_equal "Change directory to 'kaese'.", @demo.log.last[:desc]
		assert_equal nil, @demo.log.last[:shell]

		@demo.shell 'mkdir gouda'
		assert File.directory? 'tmp/kaese/gouda'
		assert_equal ["kaese $ mkdir gouda"], @demo.log.last[:shell]
	end

	def test_nested_cds
		@demo.shell 'mkdir -p kaese/gouda'
		@demo.cd 'kaese'
		@demo.cd 'gouda'

		@demo.shell 'mkdir mittelalt'
		assert File.directory? 'tmp/kaese/gouda/mittelalt'
		assert_equal ["kaese/gouda $ mkdir mittelalt"], @demo.log.last[:shell]
	end

	def test_nested_up
		@demo.shell 'mkdir -p kaese/gouda'
		@demo.cd 'kaese'
		@demo.cd 'gouda'

		@demo.shell 'mkdir unten'
		@demo.cd '..'
		@demo.shell 'mkdir mitte'
		@demo.cd '..'
		@demo.shell 'mkdir oben'

		assert File.directory? 'tmp/kaese/gouda/unten'
		assert File.directory? 'tmp/kaese/mitte'
		assert File.directory? 'tmp/oben'
		assert_equal "Change directory to '..'.", @demo.log[-2][:desc]
		assert_equal "Change directory to '..'.", @demo.log[-4][:desc]
	end

	def test_cd_up_shell_prefix
		@demo.shell 'mkdir -p kaese/gouda'
		@demo.cd 'kaese'
		@demo.cd 'gouda'
		@demo.cd '..'
		@demo.shell 'touch brie'

		assert_equal ["kaese $ touch brie"], @demo.log.last[:shell]
	end


	def test_create
		@demo.create 'hallo.txt'

		assert File.exist? 'tmp/hallo.txt'
		assert_equal "Create new file 'hallo.txt'.", @demo.log.last[:desc]
		assert_equal nil, @demo.log.last[:shell]
	end

	def test_create_with_path
		@demo.create 'lebensmittel/kaese/gouda.txt'

		assert File.exist? 'tmp/lebensmittel/kaese/gouda.txt'
		assert_equal "Create new file 'lebensmittel/kaese/gouda.txt'.", @demo.log.last[:desc]
		assert_equal nil, @demo.log.last[:shell]
	end

	def test_create_with_path
		@demo.create 'lebensmittel/kaese/gouda.txt'

		assert File.exist? 'tmp/lebensmittel/kaese/gouda.txt'
		assert_equal "Create new file 'lebensmittel/kaese/gouda.txt'.", @demo.log.last[:desc]
		assert_equal nil, @demo.log.last[:shell]
	end

	def test_edit
		@demo.create 'hallo.txt'
		a = File.read('tmp/hallo.txt')

		@demo.edit 'hallo.txt'
		b = File.read('tmp/hallo.txt')
		assert !(a == b)
		assert b.length > a.length
	end

	def test_section_dsl
		@demo.section do
			shell "touch wurst"
			shell "touch kaese"
		end

		assert File.exist? 'tmp/wurst'
		assert File.exist? 'tmp/kaese'
	end

end
