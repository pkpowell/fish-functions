function lop
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
	set app (mdfind -name "$appname" -onlyin /Applications) 
	echo "$app"
end