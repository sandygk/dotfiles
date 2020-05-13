function launcher
  fish -c (dmenu_path | fzf) &
  disown
end
