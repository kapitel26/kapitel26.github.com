require "test/unit"

class BashWrapperTest < Test::Unit::TestCase

	def setup
		@b = BashWrapper.new
	end

	def test_output
		out = @b.sh "echo dosenwurst"
		assert_equal "dosenwurst\n", out
	end

	def test_exitcode
		out = @b.sh "echo dosenwurst"
		assert_equal "dosenwurst\n", out
	end

end