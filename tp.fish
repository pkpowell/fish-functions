function tp
    set pid (pgrep $argv)
    if [ $pid -gt 0 ] 
        top -pid $pid
    else
        echo "Can't find process"
    end
end
