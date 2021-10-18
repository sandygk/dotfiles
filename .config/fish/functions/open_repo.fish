function open_repo
  # - List all the files (including directories and links) that are
  #   direct children of the ~/repos directory.
  # - Print only the name of the file followed by a line break
  # - Remove empty lines from the ouput (grep .), this line is generated
  #   by `repos/.`
  set selection (find ~/repos -maxdepth 2 -mindepth 2 -printf '%P\n' | grep . | fzf)
  test -n "$selection" && code ~/repos/$selection/
end
