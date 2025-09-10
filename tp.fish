function tp
    
    set pid (pgrep $argv)
    if count $pid = < 1; 
        top -pid $pid
    else
        echo "Can't find process"
    end
end
