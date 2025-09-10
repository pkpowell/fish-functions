function tp
    set pid (pgrep -l $argv)
    if [ (count $pid) -gt 1 ]
        for i in (seq (count $ips))
            echo -n "($i)"
            echo $pid[$i] 
        end
        echo "(q) Quit"
        read -p 'echo "Choose your pid 1-"'(count $pid)": " choice
        
        switch $choice
            case q
                return
            case "*"
                if string match --quiet --regex '[a-z]' $choice >/dev/null 
                    return
                end
                set pid $pid[$choice]
        end
    end
        
    set pid string split ' ' $pid
    set pid $pid[1]

    if [ $pid -gt 1 ] 
        top -pid $pid
    else
        echo "Can't find process"
    end
end
