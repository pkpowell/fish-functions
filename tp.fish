function tp
    set args (string split @ $argv)
    if count args = 1; 
        set pid (pgrep args)
        top -pid $pid
    else
        echo "Wrong arg count"
    end
end
