# encoding: UTF-8

class GitDemosTest < Test::Unit::TestCase

	def setup
		FileUtils.rm_rf 'tmp'
		@demo = GitDemos.new('tmp')
	end

	def test_log_is_empty_at_startup
		assert @demo.log.empty?
	end

	def test_init
		@demo.init

		assert File.directory? 'tmp'

		assert @demo.log.last[:desc] = "Initialize demo directory in 'tmp'"
	end

end


