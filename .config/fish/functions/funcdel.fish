function funcdel
    if test -z "$argv[1]"
        echo "Must provide function name in first argument"
        return 1
    end
    if not rm $__fish_config_dir/functions/$argv[1].fish 2>/dev/null
        echo "The function '$argv[1]' does not exist"
        return 1
    end
end
