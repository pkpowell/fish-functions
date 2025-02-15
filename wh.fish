function wh --description 'which binary'
  which $argv;
	ls -l (which $argv);
end
