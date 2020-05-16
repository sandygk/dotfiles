function launcher
  stest -flx $PATH | sort -u | fzf | begin nohup fish & end >/dev/null 2>&1
end
