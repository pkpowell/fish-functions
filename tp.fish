function tp
    set pid (pgrep $argv)
    if $pid = > 0; 
        top -pid $pid
    else
        echo "Can't find process"
    end
end
