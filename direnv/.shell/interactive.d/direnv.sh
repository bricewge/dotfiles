#!/bin/sh

# Load corect hook bashedon the shell if direnv is availaile

if command -v direnv >/dev/null ; then
    if [ -n "$BASH_VERSION" ]; then
       eval "$(direnv hook bash)"
    else [ -n "$ZSH_VERSION" ]
         eval "$(direnv hook zsh)"
    fi
fi
