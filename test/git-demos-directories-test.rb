# encoding: UTF-8

class GitDemosDirectoriesTest < AbstractGitDemosTest

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

end
