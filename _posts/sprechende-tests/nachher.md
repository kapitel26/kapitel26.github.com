{% highlight ruby %}
class ArchiverChecks < Checks

  def declaration
    action_under_test { synchArchive }

    check "Top-level files will be synched."
    prepare { in_directory(workDir) { create_file(named('test'), "AAAA") } }
    post { in_directory(archiveDir) { assert_equal "AAAA", read_file(named('test')) } }

    check "Files in inactive directories will be synched."
    prepare { in_directory(workDir, named("inactive-dir")) { create_file(named(), "BBBB") } }
    post { in_directory(workDir, named("inactive-dir")) { assert_equal "BBBB", read_file(named()) } }
  end

end
{% endhighlight %}
