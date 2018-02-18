{% highlight ruby %}
class ArchiverChecks < Checks

  include Minitest::Assertions
  include FileUtils

  attr_accessor :assertions

  def initialize
    super()
    @assertions = 0

    action { |archiver| archiver.synchArchive }

    check "top-level-inactive"
    prepare do |check_name, archiver|
      chdir(archiver.workDir) { File.write("__#{check_name}", "content: #{check_name}") }
    end
    post do |check_name, archiver|
      chdir(archiver.archiveDir) { assert_equal "content: #{check_name}", File.read("__#{check_name}") }
    end

    check "subdir-inactive"
    prepare do |check_name, archiver|
      chdir(archiver.workDir) do
        mkdir_p "__#{check_name}"
        chdir("__#{check_name}") { File.write("__#{check_name}_file", "content: #{check_name}") }
      end
    end
    post do |check_name, archiver|
      chdir(archiver.archiveDir) { chdir("__#{check_name}") { assert_equal "content: #{check_name}", File.read("__#{check_name}_file") }  }
    end
  end
end
{% endhighlight %}
