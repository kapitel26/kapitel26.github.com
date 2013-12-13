# encoding: UTF-8

class GitDemosTest < Test::Unit::TestCase

	def setup
		FileUtils.rm_rf 'tmp'
		@demo = GitDemos.new('tmp')
		assert @demo.log.empty?
		@demo.init
	end

	def test_workspace_after_init
		assert File.directory? 'tmp'
		assert @demo.log.last[:desc] = "Initialize demo directory in 'tmp'"
	end

	def test_new_repo
		@demo.new_repo 'my-little-repo'

		`cd tmp/my-little-repo && git status`
		assert_equal 0, $?.to_i

		assert_equal "Create new repository in 'my-little-repo'.", @demo.log.last[:desc]
		assert_equal ["$ git init my-little-repo"], @demo.log.last[:shell]
	end

	def test_shell
		@demo.shell 'mkdir wurstpelle'

		assert File.directory? 'tmp/wurstpelle'
		assert_equal "Execute shell command 'mkdir wurstpelle'.", @demo.log.last[:desc]
		assert_equal ["$ mkdir wurstpelle"], @demo.log.last[:shell]
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

	def test_to_markdown
		@demo.new_repo 'my-little-repo'
		@demo.cd 'my-little-repo'
		@demo.shell 'touch wurst'

		expected = <<-EOS
Initialize demo directory in 'tmp'.

Create new repository in 'my-little-repo'.

    $ git init my-little-repo

Change directory to 'my-little-repo'.

Execute shell command 'touch wurst'.

    my-little-repo $ touch wurst

		EOS

		assert_equal expected, @demo.to_markdown
	end

	def test_create
		@demo.create_file 'hallo.txt'

		assert_equal "Create new file 'hallo.txt'.", @demo.log.last[:desc]
		assert_equal nil, @demo.log.last[:shell]
	end

end