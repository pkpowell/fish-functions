# Defined in - @ line 1
function wh --description 'which binary'
  which $argv;
	ls -l (which $argv);
end
