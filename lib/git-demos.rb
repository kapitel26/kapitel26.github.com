require "fileutils"
require "open3"
require "set"

require "rubygems"
require "maruku"

require "directories"
require "files"
require "rendering"
require "shell"
require "git-demos-shortcuts"

class GitDemos

	include Directories
	include Files
	include Rendering
	include Shell
	include GitDemosShortcuts

	attr_reader :log

	def initialize dir
		@basedir = dir
		@current_path = []
		@log = []

		@log << { text: "<!-- working directory in #{@basedir} -->" }
		FileUtils.mkdir_p @basedir
	end

	def append_to_log key, value
		@log.last[key] ||= []
		@log.last[key] <<  value
	end

	def text md
		@log << { text: md }
	end

	def section &block
		instance_eval &block
	end

end