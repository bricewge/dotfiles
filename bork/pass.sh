include config

if pass help >/dev/null 2>&1 ; then
    if [ ! -d "${HOME}/.password-store" ]; then
        pass git clone git@github.com:bricewge/pass.git
    fi
    if [ ! -f  "${HOME}/.password-store/.git/hooks/post-commit" ]; then
        cat > "${HOME}/.password-store/.git/hooks/post-commit" <<-EOF
				git pull --rebase
				git push origin
				EOF
        chmod u+x "${HOME}/.password-store/.git/hooks/post-commit"
    fi
fi
