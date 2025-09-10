function tp
    set pid (pgrep $argv)
    if [ $pid -ne "" ] 
        top -pid $pid
    else
        echo "Can't find process"
    end
end
