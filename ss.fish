function ss
	# set jq (which jq )
	# set sshFlags " -6 -o BatchMode=yes -o StrictHostKeyChecking=no "
	set defaultSSHUser ard

	set sshPort 22
	set sshProtoll "-4"
	set verbose ""

	getopts $argv | while read -l key option
		switch $key
			case _
				set sshTarget $option
                set target $option
			case c
				set sshCommand $option
			case 4
				set sshProtoll "-4"
			case v
				set verbose " -v"
			case u
				set sshUser $option
			case p
				set sshPort $option
			case f
				set fileTransfer $option
				set fileTransferFull (realpath fileTransfer)
            case i
                set showIPs true
			case "*"
				echo "Usage: s6 target [-u user -c command -f file]"
				return
		end
	end
	# check if user set
	set -q sshUser; or set sshUser $defaultSSHUser

	if [ $sshTarget ]
        set ips (/usr/bin/dscacheutil -q host -a name $sshTarget | grep ipv6_address | awk '{print $2}')
        set -a ips (/usr/bin/dscacheutil -q host -a name $sshTarget | grep ip_address | awk '{print $2}')
        set ipNumber (count $ips)
        echo $ips

		if [ $showIPs ]
			switch $ipNumber
				case 0
					set_color yellow
					echo "No data found for '$sshTarget'"
					echo "Check hostname and/or network connection."
					set_color normal
				case 1
					if [ $sshTarget ]
						echo "One ip"
						set sshTarget $ips[1]
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
						case "*"
							if string match --quiet --regex '[a-z]' $choice >/dev/null
								return
							end
							set sshTarget $ips[$choice]
					end

			end
		end

		if [ $fileTransfer ]
			echo "Transferring $fileTransfer to $sshTarget to $sshUser's home folder"
			scp -P $sshPort -r $sshProtoll $fileTransfer $sshUser@$sshTarget:./
			return
		end

		set -l ssh_command "ssh -p $sshPort -t $sshTarget $sshProtoll -l $sshUser $verbose"

		if [ $sshCommand ]
			set -a ssh_command $sshCommand
		end
		echo "Connecting to $target ("$sshTarget") as user $sshUser"
		eval $ssh_command
	end
end
