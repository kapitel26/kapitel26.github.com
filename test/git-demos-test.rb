# encoding: UTF-8

class AbstractGitDemosTest < Test::Unit::TestCase

	def setup
		FileUtils.rm_rf 'tmp'
		@demo = GitDemos.new('tmp')
		assert @demo.log.empty?
		@demo.init
	end

end
