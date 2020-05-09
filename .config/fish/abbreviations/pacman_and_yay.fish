#!/usr/bin/env fish

# Install a package.
# S: S is for synchronize.
abbr -g pi 'sudo pacman -S'
abbr -g yi 'yay -S'

# Remove a package.
# R: Remove a package.
# n: Selete configuration files.
# s: Remove the dependencies that are not required by other installed package.
abbr -g pr 'sudo pacman -Rns'

# Upgrades all the packages in the system.
# S: S is for synchronize.
# y: Update the database.
# u: Upgrades all packages that are out-of-date.
abbr -g pu 'sudo pacman -Syu'

# Search each package in the sync databases for names or descriptions that match regexp. 
# When you include multiple search terms, only packages with descriptions matching ALL
# of those terms will be returned. If no argument is given it returns all.
abbr -g ps 'pacman -Ss'  
abbr -g ys 'yay'

# Search each locally-installed package for names or descriptions that match regexp. 
# When including multiple search terms, only packages with descriptions matching ALL 
# of those terms are returned. If no argument is given it returns all.
abbr -g pq 'pacman -Qs'  

# List explicitly installed packages.
abbr -g ple 'pacman -Qe'  

# List packages explicitly installed by me.
abbr -g plm 'comm -23 <(pacman -Qeq | sort) <(pacman -Qgq base base-devel | sort)'

# List unneeded dependencies.
# d: Only dependencies.
# t: Only unrequired.
abbr -g plu 'pacman -Qdt'

# Remove unneeded dependencies.
# d: Only dependencies.
# t: Only unrequired.
# q: Quite ouput.
abbr -g pru 'sudo pacman -Rns (pacman -Qtdq)'
