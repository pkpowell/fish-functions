# Defined in - @ line 1
function gst --description 'alias gs=git status --short'
	ls -lrtd (git status --porcelain | grep '^.[?M]' | sed 's/^.. //')
end
