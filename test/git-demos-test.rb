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

		assert_equal @demo.log.last[:desc], "Create new repository in 'my-little-repo'."
		assert_equal @demo.log.last[:shell], [" $ git init my-little-repo"]
	end

	def test_shell
		@demo.shell 'mkdir wurstpelle'

		`ls tmp/wurstpelle`
		assert_equal 0, $?.to_i
		assert_equal @demo.log.last[:desc], "Execute shell command 'mkdir wurstpelle'."
		assert_equal @demo.log.last[:shell], [" $ mkdir wurstpelle"]
	end

	def test_cd
		@demo.shell 'mkdir kaese'
		@demo.cd 'kaese'
		assert_equal @demo.log.last[:desc], "Change directory to 'kaese'."
		assert_equal @demo.log.last[:shell], []

		@demo.shell 'mkdir gouda'
		assert File.directory? 'tmp/kaese/gouda'
		assert_equal @demo.log.last[:shell], [" $ mkdir gouda"]
	end



end


