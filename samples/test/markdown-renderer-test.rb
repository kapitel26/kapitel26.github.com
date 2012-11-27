require "test/unit"
require "stringio"
require "fileutils"

class MarkdownRendererTest < Test::Unit::TestCase

  def setup
	@result = ""
	@renderer = MarkdownRenderer.new(StringIO.new(@result))
	FileUtils::rm_rf "sample1"
  end

  def test_output
	@commandline = DemoCommandline.new(@renderer) do
		sh 'echo moin'
		edit 'kaese', :line_numbers => [1,3], :commit => false
		edit 'kaese', :commit => false
		edit 'kaese', :line_numbers => [3], :commit => false
		direct "hallo\nwelt"
	end

	assert_equal <<-eos, @result
    > echo moin
    moin
    
    # Create line 1,3 in file "kaese"
    
    # Edit file "kaese"
    
    # Edit line 3 in file "kaese"
    
hallo
welt

	eos
  end

  def test_hide_and_show
	@commandline = DemoCommandline.new(@renderer) do
		direct 'moin'
		show []
		sh 'echo hidden'
		edit 'hidden', :commit => false
		direct "hidden"
		show
		direct 'there_again'
		show [:command]
		sh "echo wurst"
	end

	assert_equal <<-eos, @result
moin

there_again

    > echo wurst
    
	eos
  end

  def test_render_multiline_command
	@commandline = DemoCommandline.new(@renderer) do
		sh <<-eos
echo "hallo
      welt"
		eos
	end

	assert_equal <<-eos, @result
    > echo "hallo
            welt"
    hallo
          welt
    
	eos
  end

end