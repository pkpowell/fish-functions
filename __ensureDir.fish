function __ensureDir
    set directory $argv
    if [ ! -d $directory ]
        echo Creating directory $directory
        mkdir -p $directory
    end
end