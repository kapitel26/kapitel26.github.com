require "test/unit"
require "stringio"
require "fileutils"

class DemoCommandlineTest < Test::Unit::TestCase

  def setup
	@result = ""
	@renderer = PlainRenderer.new(StringIO.new(@result))
	FileUtils::rm_rf "sample1"
	@commandline = DemoCommandline.new(@renderer)
  end

  def test_creates_working_dir
	@commandline.sh 'touch moin'
	assert_equal [".", "..", "moin"], Dir.new("sample1").to_a
  end

  def test_dsl_style_usage
	DemoCommandline.new(@renderer) {
		sh 'echo Moin'
		sh 'echo Moin!'
	}
	assert_equal <<-eos, 
> echo Moin
Moin
> echo Moin!
Moin!
	eos
	@result
  end


  def test_overwrites_existing_working_dir
  	File.open("sample1/alt", "w") { |f| f.write "egal" }
	DemoCommandline.new(@renderer)
	assert_equal "", `ls sample1`
  end

  def test_edit_new_file_with_content
	@commandline.edit 'wurst', :content =>"hallowelt\n", :commit => false
	assert_equal \
		"hallowelt\n", 
		IO.read("sample1/wurst")
  end

  def test_edit_new_file_with_default_content
	@commandline.edit 'kaese', :commit => false
	assert_equal \
		"0: Create file \"kaese\" /1\n", 
		IO.read("sample1/kaese")
  end

  def test_edit_new_file_at_specified_lines
	@commandline.edit 'kaese', :line_numbers => [1,3], :commit => false
	assert_equal <<-eos,

1: Create line 1,3 in file "kaese" /1

3: Create line 1,3 in file "kaese" /1
	eos
	IO.read("sample1/kaese")
  end

  def test_edit_existing_file
	File.open("sample1/kaese","w") { |f| f.write "a\nb\nc\n" }
	@commandline.edit 'kaese', :line_numbers => [1], :commit => false
	@commandline.edit 'kaese', :line_numbers => [2], :commit => false
	assert_equal <<-eos,
a
1: Edit line 1 in file "kaese" /1
2: Edit line 2 in file "kaese" /2
	eos
	IO.read("sample1/kaese")
  end

  def test_output_on_PlainRenderer_comment
	@commandline.comment 'beaufort'
	assert_equal "# beaufort\n", @result 
  end

  def test_output_on_PlainRenderer_shell_commands
	@commandline.sh 'echo moin; echo error >&2'
	assert_equal \
		"> echo moin; echo error >&2\nmoin\nerror\n",
		@result 
  end

  def test_raises_on_nonzero_exitcode_by_default
	assert_raises(RuntimeError) {
	  @commandline.sh 'false'
	}
  end

  def test_declare_valid_exit_codes
	@commandline.sh 'false', :valid_exits => [1]
  end

  def test_declare_valid_exit_codes_will_raise_on_invalid_exits
	assert_raises(RuntimeError) {
	  @commandline.sh 'false', :valid_exits => [7,3]
	}
  end

end

class MarkdownRendererTest < Test::Unit::TestCase

  def setup
	@result = ""
	@renderer = MarkdownRenderer.new(StringIO.new(@result))
	FileUtils::rm_rf "sample1"
	@commandline = DemoCommandline.new(@renderer)
  end

  def test_output
	@commandline.sh 'echo moin'
	@commandline.edit 'kaese', :line_numbers => [1,3], :commit => false
	@commandline.edit 'kaese', :commit => false
	@commandline.edit 'kaese', :line_numbers => [3], :commit => false

	assert_equal <<-eos, @result
    > echo moin
    moin
    
    # Create line 1,3 in file "kaese"
    
    # Edit file "kaese"
    
    # Edit line 3 in file "kaese"
    
	eos
  end
end