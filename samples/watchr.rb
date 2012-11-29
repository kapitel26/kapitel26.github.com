require "rainbow"
require "terminal-notifier"

@@last_commit_comment = nil
@@commit_nr = 1

puts "THE UNITTESTS ARE WATCHING YOU!".color(:yellow)

def decorate comment
	@@commit_nr > 1 ? "fixup! #{comment}" : comment 
end

def commit_it
	commit_comment = IO.read("commit-comment")
	if @@last_commit_comment != commit_comment
		@@commit_nr = 1
	end
	@@last_commit_comment = commit_comment
	message = decorate(commit_comment)
	system "git commit -am \"#{message}\""
	raise "failed to commit" unless $?.to_i == 0
	puts "Committed to Git:\n#{message}".color(:blue)
	puts "Sequence with #{@@commit_nr} commits\n".color(:blue)
	@@commit_nr += 1
end

def commit_if_possible
	status = `git status --porcelain`
	unless status.empty?
		if status =~ /^\?\?/
			$stderr.puts "Add files to git first (or gitignore them):\n#{status}\n"
			exit 1
		end
		commit_it
	end
end

def run_tests
	puts '-'*40
	system("./run-tests.rb")
	exitcode = $?.to_i
	puts "Exited with: #{exitcode}"
	if exitcode == 0
		TerminalNotifier.notify('Hello World', :title => 'GREEN', :subtitle => 'Programming Language')
		puts "*** GREEN ***".color(:green)
		commit_if_possible
	else
		TerminalNotifier.notify('Hello World', :title => 'RED', :subtitle => 'Programming Language')
		puts "*** RED ***".color(:red)
	end
end

watch( '.*\.rb' ) { |md| run_tests }
