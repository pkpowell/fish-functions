function fish_greeting
	set currentTime (date +%s)
	switch (uname)
	case Linux
		set kernos (uname -r)
		set arch (uname -m)
		set cpuCores (nproc)
		set model (string split : (cat /proc/cpuinfo | grep  'model name' | uniq))
		set cpu $model[2]
		set hdAvailable (df -H / --output=avail)[2]
		set utString (uptime -p)
		set networkInfo (hostname) #(hostname -I)

		set sleept 0
		
		# exit 0
	case Darwin
		set arch (uname -m)

		switch $arch
		case x86_64
			set cpuCache (sysctl -n machdep.cpu.cache.size)
		case '*'
			set cpuCache "unknown"
		end

		set hwm (sysctl -n hw.memsize)
		set memFormatted (math -s0 "$hwm / 1024 / 1024 / 1024")GB
		set kernos (sysctl -n kern.osversion)
		set brand (sysctl -n machdep.cpu.brand_string)

		set hdAvailable (diskutil info / | grep "Available Space\|Free Space" | awk '{print $4, $5}')

		set cpu (string trim (sysctl -n machdep.cpu.brand_string | awk '{print $1, $2, $3, $6}' ))
		set cpuCores (sysctl -n machdep.cpu.thread_count)
		

		set swap_u (sysctl -n vm.swapusage | awk '{print $3, $6, $9}' )
		set mem_pressure (sysctl -n vm.memory_pressure)

		set os_ver (sw_vers -productVersion)
		set build_ver (sw_vers -buildVersion)
		set hn (sysctl -n kern.hostname)
		set ip0 (ipconfig getifaddr en0)
		set ip1 (ipconfig getifaddr en1)
		set upt (sysctl -n kern.boottime)

		set networkInfo "$hn $ip0 $ip1"
		set bootTime (sysctl -n kern.boottime | awk '{print $4}' | sed 's/,//g')
		
		set upTime (math "$currentTime - $bootTime ")
		set utString (__secondsToFmt $upTime)

		set sleept (sysctl -n kern.sleeptime | awk '{print $4}' | sed 's/,//g')
		set waket (sysctl -n kern.waketime | awk '{print $4}' | sed 's/,//g')
		set sleepString (__secondsToFmt (math "$waket - $sleept"))

		set lastGUIUser (defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName)
	case FreeBSD NetBSD DragonFly
		echo Not supported
		exit 1
	case '*'
		echo unknown architecture. Bummer...
		exit 1
	end

	# set currentTime (date +%s)
	
	# set hwm (sysctl -n hw.memsize)
	# set memFormatted (math -s0 "$hwm / 1024 / 1024 / 1024")GB
	# set kernos (sysctl -n kern.osversion)
	# set brand (sysctl -n machdep.cpu.brand_string)

	# set hdAvailable (diskutil info / | grep "Available Space\|Free Space" | awk '{print $4, $5}')

	# set cpu (sysctl -n machdep.cpu.brand_string | awk '{print $1, $2, $3, $6}' )
	# set cpuCores (sysctl -n machdep.cpu.thread_count)
	# set cpuCache (sysctl -n machdep.cpu.cache.size)

	# set swap_u (sysctl -n vm.swapusage | awk '{print $3, $6, $9}' )
	# set mem_pressure (sysctl -n vm.memory_pressure)

	# set os_ver (sw_vers -productVersion)
	# set build_ver (sw_vers -buildVersion)
	# set hn (sysctl -n kern.hostname)
	# set ip0 (ipconfig getifaddr en0)
	# set ip1 (ipconfig getifaddr en1)
	# set upt (sysctl -n kern.boottime)

	# set networkInfo "$hn $ip0 $ip1"
	# set bootTime (sysctl -n kern.boottime | awk '{print $4}' | sed 's/,//g')
	
	# set upTime (math "$currentTime - $bootTime ")
	# set utString (__secondsToFmt $upTime)

	# set sleept (sysctl -n kern.sleeptime | awk '{print $4}' | sed 's/,//g')
	# set waket (sysctl -n kern.waketime | awk '{print $4}' | sed 's/,//g')
	# set sleepString (__secondsToFmt (math "$waket - $sleept"))

	# set lastGUIUser (defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName)

	echoFormat "cpu" "$cpu $cpuCores core, $arch"
	if [ $os_ver ]
		echoFormat "os" "$os_ver build $build_ver $memFormatted"
	end
	echoFormat "hd free" "$hdAvailable"
	echoFormat "swap" "$swap_u"
	echoFormat "host" "$networkInfo"
	echoFormat "uptime" "$utString"

	echoFormat "last user" "$lastGUIUser"
    
	if [ $SSH_CONNECTION ]
		echoFormat "ssh client" "$SSH_CLIENT"
	end	
	
	if [ $sleept -gt 0 ]
		echoFormat "last sleep" (date -r $sleept '+%d.%m.%y %H:%M:%S')" for $sleepString"
	end

	set_color normal
end

function echoFormat 
	set fillChar " "
	set fieldLength 12
	switch (count $argv)
	case 2
		set key $argv[1]
		set val $argv[2]
		if [ $val ]
			set keyLength (string length $argv[1])
			set_color $fish_color_autosuggestion
			echo -n $key
			printf $fillChar%.0s (seq (math "$fieldLength - $keyLength")) 
			set_color blue
			echo $val
			set_color normal
		end
	case "*"
		set key $argv[1]	
		set keyLength (string length $argv[1])
		set_color $fish_color_autosuggestion
		echo -n $key
		printf $fillChar%.0s (seq (math "$fieldLength - $keyLength")) 
		set_color red
		echo "data missing"
	end
end
