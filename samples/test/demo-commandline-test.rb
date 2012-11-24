require "test/unit"
require "stringio"

class DemoCommandlineTest < Test::Unit::TestCase

	def setup
		@result = ""
		@renderer = PlainRenderer.new(StringIO.new(@result))
		`rm -rf sample1`
		@commandline = DemoCommandline.new(@renderer)
	end

	def test_creates_working_dir
		@commandline.sh 'touch moin'
		assert_equal "moin\n", `ls sample1`
	end

	def test_dsl_style_usage
		DemoCommandline.new(@renderer) {
			sh 'echo Moin'
			sh 'echo Moin!'
		}
		assert_equal "> echo Moin\nMoin\n\n> echo Moin!\nMoin!\n\n", @result
	end


	def test_overwrites_existing_working_dir
		`mkdir -p sample1; touch sample1/alt`
		DemoCommandline.new(@renderer)
		assert_equal "", `ls sample1`
	end

	def test_edit_new_file_with_content
		
		@commandline.edit 'wurst', :content =>"hallowelt\n", :commit => false
		assert_equal "hallowelt\n", `cat sample1/wurst` 
	end

	def test_edit_new_file_with_default_content
		
		@commandline.edit 'kaese', :commit => false
		assert_equal "0: Created file kaese lines [] (edit nr. 1)\n", `cat sample1/kaese` 
	end

	def test_edit_new_file_at_specified_lines
		
		@commandline.edit 'kaese', :line_numbers => [1,3], :commit => false
		assert_equal "\n1: Created file kaese lines [1, 3] (edit nr. 1)\n\n3: Created file kaese lines [1, 3] (edit nr. 1)\n", `cat sample1/kaese` 
	end

	def test_edit_existing_file
		File.open("sample1/kaese","w") { |f| f.write "a\nb\nc\n" }
		@commandline.edit 'kaese', :line_numbers => [1], :commit => false
		@commandline.edit 'kaese', :line_numbers => [2], :commit => false
		assert_equal "a\n1: Edited file kaese lines [1] (edit nr. 1)\n2: Edited file kaese lines [2] (edit nr. 2)\n", `cat sample1/kaese` 
	end

	def test_output_on_PlainRenderer_comment
		@commandline.comment 'beaufort'
		assert_equal "# beaufort\n", @result 
	end

	def test_output_on_PlainRenderer_shell_commands
		@commandline.sh 'echo moin; echo error >&2'
		assert_equal "> echo moin; echo error >&2\nmoin\nerror\n", @result 
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