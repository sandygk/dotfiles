# pass -r as first argument for recursive
# last argument is the path to the dir, it must include a / at the end
function open_file_in_dir
  set dir $argv[-1]
  set selection (find $dir -not -path '*/\.git/*' (test $argv[1] != -r && echo -maxdepth\n1) -type f -printf '%P\n' | fzf)
  test -n "$selection" && o "$dir/$selection"
end
