function nb
    set args (string split @ $argv)
    if count args = 1; 
        echo "user: "|read user
        sudo netbird ssh $user@$args
    else
        sudo netbird ssh $argv
    end
end
