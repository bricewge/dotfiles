include config

if [[ $OS == "macos" ]]; then
    ok brew tree
    ok brew tldr
    ok brew trash
    ok brew cmatrix
    ok brew the_silver_searcher
    # GUI apps
    ok cask mpv
    ok cask firefox
    ok cask emacs
fi
