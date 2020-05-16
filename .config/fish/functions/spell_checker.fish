function spell_checker
  # using xsel because xclip was not working when
  # launched with $TERM -e
  fzf < /usr/share/dict/words --print0 | xsel -b 
end
