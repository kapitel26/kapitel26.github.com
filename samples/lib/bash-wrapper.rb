require "rubygems"
require "open4"
require "io/wait"

class BashWrapper

	def initialize
		@pid, @stdin, @stdout, @stderr = Open4::popen4 "/bin/bash" 
		@magic = "72dfb552fe434ffe03e15e48ae9a884471f24340"
		@magicrex = /72dfb552fe434ffe03e15e48ae9a884471f24340 (.*)\n/
	end

	def sh command
		@stdin.puts command
		@stdin.puts "echo \"#{@magic} $?\""
		@stdin.flush
		out, exitcode = read_stdout_upto_next_magic_line
		err = read_stderr_available
		[out, err, exitcode]
	end


	private

	def read_stdout_upto_next_magic_line
		out = ""
		loop do
			while !@stdout.ready? do 
				sleep 0.1
			end 
			line = @stdout.readline
			break if line =~ @magicrex
			out << line
		end
		exitcode = $1.to_i
		[out, exitcode]
	end

	def read_stderr_available
		err = ""
		while @stderr.ready? do
			err << @stderr.readpartial(80)
		end
		err
	end
end

