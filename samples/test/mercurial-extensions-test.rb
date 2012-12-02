require "test/unit"
require "stringio"

class MercurialExtensionTest < Test::Unit::TestCase

  def setup
	@result = ""
	@renderer = MarkdownRenderer.new(StringIO.new(@result))
  end

  def test_output
	@commandline = DemoCommandline.new(@renderer) do
		hg 'init'
	end

	assert_equal true, File.exists?("sample1/.hg")
  end

  def test_merge
  	test = self
	@commandline = DemoCommandline.new(@renderer) do
		hg 'init'
		hg 'branch master'

		edit 'on_master' #0

		hg 'branch feature'
		edit 'on_feature' #1

		hg 'up master'
		edit 'on_master' #2

		hg 'branch feature2'
		edit 'on_feature2' #3

		hg_merge :branch => "feature", :onto => "master" #4

		test.assert_equal "2\n1\n", sh('hg parents -r . --template "{rev}\n"')[0]

		hg 'update feature2' #5
		hg_merge :onto => "master" # should use current branch

		test.assert_equal "4\n3\n", sh('hg parents -r . --template "{rev}\n"')[0]

		hg 'log --graph'
	end
  end

  def test_edit_on_branch
  	test = self
	@commandline = DemoCommandline.new(@renderer) do
		hg 'init'
		hg 'branch master'
		edit 'on_master'

		edit 'on_feature', :on_branch => "feature"
		test.assert_equal "feature\n", hg('log -r 1 --template "{branches}\n"')[0]
		test.assert_equal "feature\n", hg('branch')[0]

		edit 'on_master', :on_branch => "master"
		test.assert_equal "master\n", hg('log -r 2 --template "{branches}\n"')[0]
		test.assert_equal "master\n", hg('branch')[0]
	end
  end

end