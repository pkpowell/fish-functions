function __secondsToFmt
	set timeInSecs $argv[1]
	set timeYears (math -s0 "$timeInSecs / 31536000")

	if [ $timeYears -gt 0 ]
		set timeString $timeYears"y"
	end
	set timeDays (math -s0 "$timeInSecs / 86400 % 365")

	if [ $timeDays -gt 0 ]
		set timeString "$timeString $timeDays""d"
	end

	set timeHours (math -s0 "$timeInSecs / 3600 % 24")

	if [ $timeHours -gt 0 ]
		set timeString "$timeString $timeHours""h"
	end

	set timeMins (math -s0 "$timeInSecs / 60 % 60")

	if [ $timeMins -gt 0 ]
		set timeString "$timeString $timeMins""m"
	end

	set timeString (string trim -- "$timeString")

	if [ (string length $timeString) -eq 0 ]
		set timeSecs (math "$timeInSecs % 60")
		set timeString $timeSecs"s"
	end
	echo "$timeString"
end