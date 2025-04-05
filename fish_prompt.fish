function fish_prompt
    if test "$TERM_PROGRAM" != "WarpTerminal"
        /usr/local/bin/starship prompt
    end
end
