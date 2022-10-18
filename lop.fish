function lop
	set locale "en"
	getopts $argv | while read -l key option
		switch $key
			case _
				set appname $option
			case l 
				set locale $option
			case "*"
				echo "Usage: lop <app name> [-l locale string de, en]"
				return
		end
	end
	set apps (mdfind -name "$appname" -onlyin /Applications) 
	
	switch (count $apps)
	case 0
		exit 1

	case 1
		set app $apps[1]

	case *
		for idx in (seq (count $apps))
			echo -n "($idx)"
			echo $apps[$idx] 
		end

		echo "(q) Quit"
		read -p echo "Choose your app 1 - "(count $apps)": " choice
		
		switch $choice
			case q
				return
			case "*"
				if string match --quiet --regex '[a-z]' $choice >/dev/null 
					return
				end
				set app $apps[$choice]
		end
	end
	echo "opening $app with local $locale"
	open "$app" --args -AppleLanguages "($locale)"
end