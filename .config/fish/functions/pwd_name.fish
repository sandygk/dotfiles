function pwd_name
  if test $PWD = ~ 
    echo '~'
  else if test $PWD = '/'
    echo '/'
  else
    echo (string split -- / $PWD)[-1]
  end
end
