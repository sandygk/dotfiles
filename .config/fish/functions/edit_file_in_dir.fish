function edit_file_in_dir
  set selection (ls -p $argv[1] | grep -v / | fzf)
  test $selection && $EDITOR "$argv[1]/$selection"
end
