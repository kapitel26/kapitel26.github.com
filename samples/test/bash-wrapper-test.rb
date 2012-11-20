require "test/unit"

class BashWrapperTest < Test::Unit::TestCase

	def setup
		@b = BashWrapper.new
	end

	def test_output
		out = @b.sh "echo dosenwurst"
		assert_equal "dosenwurst\n", out
		out = @b.sh 'echo -e "zwei\nZeilen"'
		assert_equal "zwei\nZeilen\n", out
	end

end