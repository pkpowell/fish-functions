function fish_prompt
    if test "$TERM_PROGRAM" != "WarpTerminal"
        starship prompt
    end
end
