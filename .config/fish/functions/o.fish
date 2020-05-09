function o
  if test -f $argv
    open $argv
  else
    cd $argv
  end
end
