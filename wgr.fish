function wgr
    set i $argv
    sudo wg syncconf $i <(wg-quick strip $i)

    # sudo env WG_QUICK_USERSPACE_IMPLEMENTATION=boringtun-cli WG_SUDO=1 wg-quick down $i
    # sudo env WG_QUICK_USERSPACE_IMPLEMENTATION=boringtun-cli WG_SUDO=1 wg-quick up $i
end