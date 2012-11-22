require "rainbow"

last_commit_comment = nil
commit_nr = 1

watch( '.*\.rb' )  do |md| 
	puts '-'*40
	system("./run-tests.rb")
	exitcode = $?.to_i
	puts "Exited with: #{exitcode}"
	if exitcode == 0
		puts "*** GREEN ***".color(:green)
		# TODO check if somethin has changed
		# TODO check for untracked files
		commit_comment = IO.read("commit-comment")
		if last_commit_comment != commit_comment
			commit_nr = 1
		end
		last_commit_comment = commit_comment
		message = "#{commit_comment} /#{commit_nr}"
		puts "Committing to Git: #{message}"
		system "git commit -am \"#{message}\""
		if $?.to_i == 0
			commit_nr += 1
		else
			raise "failed to commit"
		end
	else
		puts "*** RED ***".color(:red)
	end
end
