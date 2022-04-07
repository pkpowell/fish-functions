function v
	set configDir $HOME/.config/vnc/
	mkdir -p $configDir

	getopts $argv | while read -l key option
		switch $key
			case _
				set vncTarget $option
			case t
				set vncTarget $option
			case u 
				set vncUser $option
			case i
				set iface $option
			case "*"
				echo "Usage: v target [-u --user user -i interface]"
				return
		end
	end

	if [ $iface ]
		set iface "%25"$iface
	else
		set iface ""
	end

	# function __connect
	# 	set_color green
	#     echo "Opening connection to '$argv[1]' as '$argv[2]'..." | tee -a $configDir/vnc.log
	#     # echo "Opening connection to '$argv[1]' via '$argv[2]" 2>> "$configDir/vnc.log"
	# 	open vnc://[$argv[2]@$argv[1]]
	# 	set_color normal
	# end
    
	if /usr/bin/nc -zw1 $vncTarget 5900 > /dev/null 2>> $configDir/vnc.log

	    set ips (/usr/bin/dscacheutil -q host -a name $vncTarget | grep ipv6_address | awk '{print $2}')$iface

		switch (count $ips)
			case 0
				set_color yellow
		        echo "No data found for '$vncTarget'" | /usr/bin/tee -a $configDir/vnc.log
		        echo "Check hostname and/or network connection."
				set_color normal	
			case 1
				if [ $vncUser ]
					open vnc://$vncUser@[$ips[1]]
				else
					open vnc://[$ips[1]]
				end
			case '*'
		    	for i in (seq (count $ips))
		    		echo -n "($i)"
		    		echo $ips[$i] 
		    	end
	    	echo "(q) Quit"

	    	read -p 'echo "Choose your ip 1*-"'(count $ips)": " choice
        
	    	switch $choice
	    		case q
	    			return
	    		case (seq (count $ips)) 
					if [ $vncUser ]
						open vnc://$vncUser@[$ips[$choice]]
					else
						open vnc://[$ips[$choice]]
					end
				case "*"
	                if string match --quiet --regex '[a-z]' $choice >/dev/null 2>> "$configDir/vnc.log"
	                    return
	                end         
					if [ $vncUser ]
						open vnc://$vncUser@[$ips[1]]
					else
						open vnc://[$ips[1]]
					end
	    	end
		end
	else
		echo No Network
	end
	
end