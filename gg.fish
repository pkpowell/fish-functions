function gg
    if test -f .git/config
        switch (count $argv)

        case 0
            printf "%s\n" (cat .git/config)
            
        case "*"
	    	for i in (seq (count $argv))
	    		echo -n "$i. "
                printf "%s\n" (string trim -l (cat .git/config | grep $argv[$i]))
	    	end
        
        end
    else
        echo "no config ($PWD)"
    end
end