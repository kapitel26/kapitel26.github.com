require "test/unit"

class DemoCommandlineTest < Test::Unit::TestCase

	def test_creates_working_dir
		`rm -rf sample1`
		DemoCommandline.new do
			sh 'touch moin'
		end
		assert_equal "moin\n", `ls sample1`
	end

	def test_overwrites_existing_working_dir
		`mkdir -p sample1; touch sample1/alt`
		DemoCommandline.new {}
		assert_equal "", `ls sample1`
	end

	def test_edit_new_file_with_content
		DemoCommandline.new do
			edit 'wurst', :content =>"hallowelt\n", :commit => false
		end
		assert_equal "hallowelt\n", `cat sample1/wurst` 
	end

	def test_edit_new_file_with_default_content
		DemoCommandline.new do
			edit 'kaese', :commit => false
		end
		assert_equal "0: Created file kaese lines [] (edit nr. 1)\n", `cat sample1/kaese` 
	end

	def test_edit_new_file_at_specified_lines
		DemoCommandline.new do
			edit 'kaese', :line_numbers => [1,3], :commit => false
		end
		assert_equal "\n1: Created file kaese lines [1, 3] (edit nr. 1)\n\n3: Created file kaese lines [1, 3] (edit nr. 1)\n", `cat sample1/kaese` 
	end

	def test_edit_existing_file
		DemoCommandline.new do
			File.open("sample1/kaese","w") { |f| f.write "a\nb\nc\n" }
			edit 'kaese', :line_numbers => [1], :commit => false
			edit 'kaese', :line_numbers => [2], :commit => false
		end
		assert_equal "a\n1: Edited file kaese lines [1] (edit nr. 1)\n2: Edited file kaese lines [2] (edit nr. 2)\n", `cat sample1/kaese` 
	end

end