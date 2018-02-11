include config

if [[ $OS == "macos" ]]; then
	ok brew pass
fi
if pass help >/dev/null 2>&1 ; then
    if [ ! -d "${HOME}/.password-store" ]; then
        git clone git@github.com:bricewge/pass.git "${HOME}/.password-store"
    fi
    if [ ! -x "${HOME}/.password-store/.git/hooks/post-commit" ]; then
        cat > "${HOME}/.password-store/.git/hooks/post-commit" <<-EOF
				git pull --rebase
				git push origin
				EOF
        chmod u+x "${HOME}/.password-store/.git/hooks/post-commit"
    fi
fi
