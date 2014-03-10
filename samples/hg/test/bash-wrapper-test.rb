require "test/unit"

class BashWrapperTest < Test::Unit::TestCase

	def setup
		@b = BashWrapper.new
	end

	def test_output
		out, err, exitcode = @b.sh "echo dosenwurst"
		assert_equal "dosenwurst\n", out
		out, err, exitcode = @b.sh 'echo -e "zwei\nZeilen"'
		assert_equal "zwei\nZeilen\n", out
	end

	def test_err
		out, err, exitcode = @b.sh "ls asdf"
		assert_equal "ls: asdf: No such file or directory\n", err
	end

	def test_exitcode
		out, err, exitcode = @b.sh "false"
		assert_equal 1, exitcode
		out, err, exitcode = @b.sh "echo wurst"
		assert_equal 0, exitcode
	end

end