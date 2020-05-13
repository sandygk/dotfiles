function open_repo
  set selection (find ~/repos -maxdepth 1 -type d -printf '%P\n' | fzf)
  test $selection && code ~/repos/$selection/
end
