function pkgmaker

    set pkgExt ".pkg"
    
	getopts $argv | while read -l key option
		switch $key
			case _
				set dirRoot $option
			case o 
				set ownership $option
			case v
				set pkgVersion $option
            case i
                set locationFromDirRoot true
            case s
                set scriptDir $option
			case "*"
				echo "Usage: pkgmaker <root-directory> [-o ownership] [-v version]"
				return
		end
	end

    set -q ownership; or set ownership "recommended"
    # echo "ownership: $ownership"
    # switch $oship
    # 	case 1 
    #         set ownership "recommended"
    # 	case 2 
    #         set ownership "preserve"
    # 	case 3 
    #         set ownership "preserve-other"
    # 	case "*" 
    #         set ownership "recommended"
    # end
    if [ $scriptDir ]
        set scriptFlag "--scripts $scriptDir"
    else 
        set scriptFlag ""
    end
    
    if [ $dirRoot ]
        if [ -d $dirRoot ]
            set identifier "net.pkpowell"
            set -q pkgVersion; or set pkgVersion "1.0"
            set pkgName (string split / (string trim -r -c / $dirRoot))[-1]
            set pkgNameID (string replace -a " " "_" $pkgName)
            set pkgIdentifier $identifier"."$pkgNameID$pkgExt
            # set ownership "recommended"
        else
            echo Could not find $dirRoot
            return 0
        end
    else
        echo "Usage: pkgmaker root -o [ownership] -v [version] -s [script-directory]"
        return 0
    end

    set -q pkgName; or set pkgName unnamed_package.pkg
    
    if [ $locationFromDirRoot ]
        set installLocation $dirRoot
        # printf "$locationFromDirRoot is set. Using $dirRoot for installLocation"
    else
        set installLocation "/"
        # printf "$locationFromDirRoot not set. Using / for installLocation"
    end
        
    printf "–––––––––––––– parameters –––––––––––––––\n"
    printf "\e[94mdirRoot: \t" 
    printf "\e[30m"$dirRoot'\n' 

    printf "\e[94mpkgName: \t" 
    printf "\e[30m"$pkgName'\n' 

    printf "\e[94mpkgNameID: \t" 
    printf "\e[30m"$pkgNameID'\n' 

    printf "\e[94mpkgVersion: \t" 
    printf "\e[30m"$pkgVersion'\n'

    printf "\e[94mownership: \t" 
    printf "\e[30m"$ownership'\n' 

    printf "\e[94mpkgIdentifier: \t" 
    printf "\e[30m"$pkgIdentifier'\n' 

    printf "\e[94minstallPath: \t" 
    printf "\e[30m"$installLocation'\n' 
    
    if [ $scriptDir ]
        printf "\e[94mscriptDir: \t" 
        printf "\e[30m"$scriptDir'\n' 
    end
    
    printf "–––––––––––––––––––––––––––––––––––––––––\n"
    
    set pkgbuildCmd "pkgbuild --root $dirRoot --install-location $installLocation $scriptFlag --identifier $pkgIdentifier --version $pkgVersion --ownership $ownership $pkgName$pkgExt"
    # echo "$pkgbuildCmd"
    
    eval $pkgbuildCmd

    echo "Done."

end