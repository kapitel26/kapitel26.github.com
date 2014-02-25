# encoding: UTF-8

class GitDemosFilesTest < AbstractGitDemosTest

	def test_create
		@demo.create 'hallo.txt'

		assert File.exist? 'tmp/hallo.txt'
		assert_equal nil, @demo.log.last[:shell]
	end

	def test_create_with_path
		@demo.create 'lebensmittel/kaese/gouda.txt'

		assert File.exist? 'tmp/lebensmittel/kaese/gouda.txt'
		assert_equal nil, @demo.log.last[:shell]
	end

	def test_create_with_path
		@demo.create 'lebensmittel/kaese/gouda.txt'

		assert File.exist? 'tmp/lebensmittel/kaese/gouda.txt'
		assert_equal nil, @demo.log.last[:shell]
	end

	def test_edit
		@demo.create 'hallo.txt'
		a = File.read('tmp/hallo.txt')

		@demo.edit 'hallo.txt'
		b = File.read('tmp/hallo.txt')
		assert !(a == b)
		assert b.length > a.length
	end

	def test_multifile_edit
		@demo.create 'a'
		@demo.create 'b'

		a1 = File.read('tmp/a')
		b1 = File.read('tmp/b')

		@demo.edit 'a' , 'b'

		a2 = File.read('tmp/a')
		b2 = File.read('tmp/b')

		assert a2.length > a1.length
		assert b2.length > b1.length
	end

end
