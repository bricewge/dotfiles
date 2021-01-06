;;; init.el -*- lexical-binding: t; -*-
;; Copy me to ~/.doom.d/init.el or ~/.config/doom/init.el, then edit me!

(doom! :input
       ;;chinese
       ;;japanese

       :completion
       (company +childframe)      ; the ultimate code completion backend
       ;;helm              ; the *other* search engine for love and life
       ;;ido               ; the other *other* search engine...
       ;; (ivy                             ; a search engine for love and life
       ;;  ;; +fuzzy
       ;;  +prescient
       ;;  +childframe)

       :ui
       deft                      ; notational velocity for Emacs
       doom                      ; what makes DOOM look the way it does
       doom-dashboard            ; a nifty splash screen for Emacs
       doom-quit                 ; DOOM quit-message prompts when you quit Emacs
       fill-column               ; a `fill-column' indicator
       hl-todo                   ; highlight TODO/FIXME/NOTE tags
       modeline                  ; snazzy, Atom-inspired modeline, plus API
       nav-flash                 ; blink the current line after jumping
       ;; neotree                   ; a project drawer, like NERDTree for vim
       ophints                   ; highlight the region an operation acts on
       treemacs          ; a project drawer, like neotree but cooler
       (popup      ; tame sudden yet inevitable temporary windows
        +all       ; catch all popups that start with an asterix
        +defaults) ; default popup rules
       pretty-code ; replace bits of code with pretty symbols
       ;; tabs                   ; an tab bar for Emacs
       ;;unicode           ; extended unicode support for various languages
       vc-gutter              ; vcs diff in the fringe
       vi-tilde-fringe        ; fringe tildes to mark beyond EOB
       window-select          ; visually switch windows
       workspaces             ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere)   ; come to the dark side, we have cookies
       file-templates       ; auto-snippets for empty files
       fold                 ; (nigh) universal code folding
       ;;(format +onsave)  ; automated prettiness
       lispy                ; vim for lisp, for people who dont like vim
       multiple-cursors     ; editing in many places at once
       ;;parinfer          ; turn lisp into python, sort of
       rotate-text               ; cycle region at point between text candidates
       snippets                  ; my elves. They type so I don't have to

       :emacs
       (dired      ; making dired pretty [functional]
        ;; +ranger         ; bringing the goodness of ranger to dired
        +icons                          ; colorful icons for dired-mode
        )
       electric                   ; smarter, keyword-based electric-indent
       vc                         ; version-control and Emacs, sitting in a tree

       :term
       eshell                         ; a consistent, cross-platform shell (WIP)
       ;;term              ; terminals in Emacs
       vterm                            ; another terminals in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       (spell              ; tasing you for misspelling mispelling
        +flyspell)         ; it's slower than spell-fu but support non-english languages
       grammar           ; tasing grammar mistake every you make

       :tools
       ;;ansible
       direnv
       ;; debugger          ; FIXME stepping through code, to help you add bugs
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       eval                  ; run code, run (also, repls)
       ;;gist              ; interacting with github gists
       (lookup                  ; helps you navigate your code and documentation
        +docsets)               ; ...or in Dash docsets locally
       lsp
       ;;macos             ; MacOS-specific commands
       make                             ; run make tasks from Emacs
       magit                            ; a git porcelain for Emacs
       (pass                            ; password manager for nerds
        +auth)
       pdf                              ; pdf enhancements
       ;;prodigy           ; FIXME managing external services & code builders
       rgb        ; creating color strings
       ;;terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       ;;upload            ; map local to remote projects via ssh/ftp
       ;;wakatime

       :lang
       (cc +lsp)                        ; C/C++/Obj-C madness
       ;;clojure           ; java with a lisp
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       data   ; config/data formats
       ;;erlang            ; an elegant language for a more civilized age
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       emacs-lisp ; drown in parentheses
       ;;ess               ; emacs speaks statistics
       (go +lsp)  ; the hipster dialect
       ;;(haskell +intero) ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ;
       json             ; At least it ain't XML
       ;;(java +meghanada) ; the poster child for carpal tunnel syndrome
       (javascript +lsp)           ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better, faster MATLAB
       ;;latex             ; writing papers in Emacs has never been so fun
       ;;ledger            ; an accounting system in Emacs
       ;;lua               ; one-based indices? one-based indices
       markdown      ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       nix           ; I hereby declare "nix geht mehr!"
       ;;ocaml             ; an objective camel
       (org          ; organize your plain life in plain text
        +attach      ; custom attachment system
        +babel       ; running code in org
        +capture     ; org-capture in and outside of Emacs
        +export      ; Exporting org to whatever you want
        +present)    ; Emacs for presentations
       ;;perl              ; write code no one else can comprehend
       ;;php               ; perl's insecure younger brother
       ;;plantuml          ; diagrams for confusing people more
       ;;purescript        ; javascript, but functional
       (python +lsp)       ; beautiful is better than ugly
       ;;qt                ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       ;;rest              ; Emacs as a REST client
       ;;ruby              ; 1.step do {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp)              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good
       scheme            ; a fully conniving family of lisps
       (sh +lsp)            ; she sells (ba|z|fi)sh shells on the C xor
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       (web +lsp)                       ; the tubes
       yaml              ; JSON, but readable
       ;;vala              ; GObjective-C

       :email
       (mu4e +gmail)       ; WIP
       ;;notmuch             ; WIP
       ;;(wanderlust +gmail) ; WIP

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
       ;;irc               ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought

       :collab
       ;;floobits          ; peer programming for a price
       ;;impatient-mode    ; show off code over HTTP

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       ;;literate

       ;; The default module sets reasonable defaults for Emacs. It also
       ;; provides a Spacemacs-inspired keybinding scheme and a smartparens
       ;; library, and additional ex commands for evil-mode. Use it as a
       ;; config. Use it as a reference for your own modules.
       ;; reference for your own modules.
       (default +bindings +smartparens +evil-commands)

       :private
       dired
       org
       ebook
       eshell
       mu4e
       (selectrum +prescient
                  +childframe)
       gnus)

       ;; ;; provides a Spacemacs-inspired keybinding scheme, a custom yasnippet
       ;; ;; library, and additional ex commands for evil-mode. Use it as a
       ;; ;; reference for your own modules.
       ;; (default +bindings +evil-commands))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("96990b05dd2b002a7e1a44b2a6ed0c84358386055e4a0e916651c0cdd1a950fd" "28a251f97fcad38d9262087ca7a1ec135e332b557b4609a134ca4d0b4bdfbf4c" "34c99997eaa73d64b1aaa95caca9f0d64229871c200c5254526d0062f8074693" "cb477d192ee6456dc2eb5ca5a0b7bd16bdb26514be8f8512b937291317c7b166" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "9efd000a42191dcbdb4bab132eec45f098d779b5eb743a4a256a553aaacab1e8" default)))
 '(safe-local-variable-values
   (quote
    ((eval remove-hook
           (quote poporg-edit-hook)
           (quote org-mode))
     (eval add-hook
           (quote poporg-edit-hook)
           (quote sh-mode))
     (eval set
           (make-local-variable
            (quote flycheck-emacs-lisp-check-form))
           +emacs-lisp-reduced-flycheck-emacs-lisp-check-form)
     (eval modify-syntax-entry 43 "'")
     (eval modify-syntax-entry 36 "'")
     (eval modify-syntax-entry 126 "'")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
