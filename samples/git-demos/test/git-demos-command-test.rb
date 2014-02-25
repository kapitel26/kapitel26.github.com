# encoding: UTF-8

class GitDemosCommandTest < AbstractGitDemosTest

	def test_workspace_after_init
		assert File.directory? 'tmp'
		assert @demo.log.last[:desc] = "Initialize demo directory in 'tmp'"
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
