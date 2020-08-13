function killport
    fuser -k $argv[1]/tcp
end
