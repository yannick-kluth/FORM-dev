* Tests for automatic directory creation for #write, #append, and #create

*--#[ AutoDir_Write :
    #write <test_dir_write/test.txt> "Hello"
    .end
    Dir.chdir(ENV['TESTTMPDIR']) do
        assert succeeded?
        assert File.directory?("test_dir_write")
        assert File.file?("test_dir_write/test.txt")
        assert File.read("test_dir_write/test.txt").strip == "Hello"
    end
*--#] AutoDir_Write :

*--#[ AutoDir_DeepWrite :
    #write <a/b/c/d/deep.txt> "Deep"
    .end
    Dir.chdir(ENV['TESTTMPDIR']) do
        assert succeeded?
        assert File.directory?("a/b/c/d")
        assert File.file?("a/b/c/d/deep.txt")
        assert File.read("a/b/c/d/deep.txt").strip == "Deep"
    end
*--#] AutoDir_DeepWrite :

*--#[ AutoDir_Append :
    #append <test_dir_append/append.txt>
    #write <test_dir_append/append.txt> "Line 1"
    .end
    Dir.chdir(ENV['TESTTMPDIR']) do
        assert succeeded?
        assert File.directory?("test_dir_append")
        assert File.file?("test_dir_append/append.txt")
        assert File.read("test_dir_append/append.txt").strip == "Line 1"
    end
*--#] AutoDir_Append :

*--#[ AutoDir_Create :
    #create <test_dir_create/create.txt>
    #write <test_dir_create/create.txt> "Created"
    .end
    Dir.chdir(ENV['TESTTMPDIR']) do
        assert succeeded?
        assert File.directory?("test_dir_create")
        assert File.file?("test_dir_create/create.txt")
        assert File.read("test_dir_create/create.txt").strip == "Created"
    end
*--#] AutoDir_Create :
