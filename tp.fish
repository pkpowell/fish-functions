function tb
    set args (string split @ $argv)
    if count args = 1; 
        set pid (pgrep zt-client)
        top -pid $pid
    else
        echo "Wrong arg count"
    end
end
