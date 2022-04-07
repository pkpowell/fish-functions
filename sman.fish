function sman
    if count $argv > /dev/null
        open x-man-page://$argv
    end
end