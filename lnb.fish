function lnb
    set f $argv
    set filepath "$PWD/$f"
    set binpath "/usr/local/bin/$f"
    echo "linking" "$filepath" "to" "$binpath"
    /bin/ln -sf $filepath $binpath
end