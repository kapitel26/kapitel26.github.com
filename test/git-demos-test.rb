# encoding: UTF-8

class GitDemosTest < Test::Unit::TestCase

	include GitDemos

	def test_do_something
		assert_equal 1000, do_something
	end

end


