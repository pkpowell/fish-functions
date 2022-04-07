# Defined in - @ line 1
function unds --description 'delete .DS_Store files'
	/usr/bin/find . -name ".DS_Store" -delete;
end
