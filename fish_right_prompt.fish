function fish_right_prompt
	set milliseconds 0
	set seconds 0
	set minutes 0
	set hours 0

	set commandDuration ""

	set milliseconds (math (string sub --start=-3 $CMD_DURATION) x 1)
	set seconds (math -s0 "$CMD_DURATION/1000" % 60)
	set minutes (math -s0 "$CMD_DURATION/60000" % 60)
	set hours (math -s0 "$CMD_DURATION/3600000")

	if test $CMD_DURATION -lt 1000
		set commandDuration $commandDuration$milliseconds'ms'
	else 
		if test $hours -gt 0
			set commandDuration $commandDuration$hours'h '$minutes'm'
		else if test $minutes -gt 0
			set commandDuration $commandDuration$minutes'm '$seconds's'
		else if test $seconds -gt 0
			if test $milliseconds -gt 0
				set commandDuration $commandDuration(math $seconds + (math $milliseconds / 1000))'s'
			else 
				set commandDuration $commandDuration$seconds's'
			end
		else
			if test $milliseconds -gt 0
				set commandDuration $commandDuration$milliseconds'ms'
			end
		end
	end

	echo -n $commandDuration' '
	set_color grey
    date +"%H:%M %d %h"
	set_color normal
end

