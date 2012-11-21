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

	# def test_edit_files
	# 	DemoCommandline.new do
	# 		edit 'kaese/wurst', 
	# 			:content =>"hallowelt\n",
	# 			:commit => :false

	# 		assert_equal "hallowelt\n", `cat wurst` 
	# 	end
	# end

end