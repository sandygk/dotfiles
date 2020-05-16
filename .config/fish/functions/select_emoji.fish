function select_emoji
  set selection (fzf --color=bw < ~/.emoji_list | sed "s/ .*//")
  if test $selection
    echo -n $selection | xsel -b
    notify-send "'$selection' copied to clipboard" &
  end
end