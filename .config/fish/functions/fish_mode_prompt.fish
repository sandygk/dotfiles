#!/usr/bin/env fish
function fish_mode_prompt
  echo -n '['
  set_color green
  if test "$fish_key_bindings" = "fish_vi_key_bindings" &&
    switch $fish_bind_mode
      case default
        set_color --background red black
      case replace_one
        set_color --background blue black
      case replace
        set_color --background cyan black
      case visual
        set_color --background magenta black
    end
  end
  echo -n (pwd_name)
  set_color normal
  echo -n '] '
end
