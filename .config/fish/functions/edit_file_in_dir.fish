function edit_file_in_dir
  set dir $argv[-1] 
  set selection (find $dir (test $argv[1] != -r && echo -maxdepth\n1) -type f -printf '%P\n' | fzf)
  test $selection && $EDITOR "$dir/$selection"
end
