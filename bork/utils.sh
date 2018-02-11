include config

if [[ $OS == "macos" ]]; then
    ok brew cmatrix
    ok brew coreutils
    ok brew htop
    ok brew the_silver_searcher
    ok brew tldr
    ok brew trash
    ok brew tree
    ok brew valgrind
    # GUI apps
    ok cask firefox "${appdir}"
fi
