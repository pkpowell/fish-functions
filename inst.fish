function inst
    set pkgPath $PWD
    # set defaultAdminUser "ard"
    getopts $argv | while read -l key option
        switch $key
            case _
                set instPKG (realpath $option)
            case t
                set instTarget $option
            case p
                set instPKG $option
            # case a
            #     set adminUser $option
            case "*"
                echo "Usage: inst [-t target - p package]"
                return
        end
    end
    set -q instTarget ; or set instTarget "/"
    # set -q adminUser ; or set adminUser $defaultAdminUser

    if [ $instPKG ]
        # if [ $adminUser ]
        #     echo Installing $pkgPath/$instPKG to $instTarget as $adminUser
        #     su $adminUser
        # else
        #     echo Installing $pkgPath/$instPKG to $instTarget as (whoami)
        # end

        sudo installer -dumplog -target $instTarget -pkg $instPKG
    end

end