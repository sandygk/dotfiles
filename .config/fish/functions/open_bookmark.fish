function open_bookmark
  cd ~/bookmarks
  set selection (grep -v '^ *#' ** | awk -F  ':[ \t]*' '{sub(/^[ \t]+/, ""); print $1": "$2}' | fzf | awk '{print $2}')
  test -n "$selection" && set url (grep -h "^ *$selection: " ** | awk -F  ': ' '{print $2}')
  xdg-open "$url"
  cd -
end
