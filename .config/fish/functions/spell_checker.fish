function spell_checker
  fzf < /usr/share/dict/words | tr -d '\n' | cat | xclip -selection clipboard
end
