function ga
	switch (count $argv)
		case 0
			set commitMessage "updates"
		case 1 
			set commitMessage $argv[1]
		case "*"
			echo "Usage: ga [commit message]"
			return
	end

	git add -A
	git commit -a -m $commitMessage
	git push
end