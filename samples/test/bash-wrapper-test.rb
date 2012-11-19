require "test/unit"

class BashWrapperTest < Test::Unit::TestCase

	def setup
		@b = BashWrapper.new
	end

	def test_some_commands
		@b.sh "echo dosenwurst"
		@b.sh "ls asdfklj"
		@b.sh "echo hanswurst"
	end
end