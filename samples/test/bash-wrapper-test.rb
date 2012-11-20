require "test/unit"

class BashWrapperTest < Test::Unit::TestCase

	def setup
		@b = BashWrapper.new
	end

	def test_output
		out, exitcode = @b.sh "echo dosenwurst"
		assert_equal "dosenwurst\n", out
		out, exitcode = @b.sh 'echo -e "zwei\nZeilen"'
		assert_equal "zwei\nZeilen\n", out
	end

	def test_exitcode
		out, exitcode = @b.sh "false"
		assert_equal 1, exitcode
		out, exitcode = @b.sh "echo wurst"
		assert_equal 0, exitcode
	end

end