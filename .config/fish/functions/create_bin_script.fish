function create_bin_script
    if test -n "$argv[1]"
        cp ~/.bash_script_template ~/bin/$argv[1]
        $EDITOR ~/bin/$argv[1]
    end
end
