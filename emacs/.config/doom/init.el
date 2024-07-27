;;; init.el -*- lexical-binding: t; -*-
;; Copy me to ~/.doom.d/init.el or ~/.config/doom/init.el, then edit me!

(doom! :input
       ;;chinese
       ;;japanese

       :completion
       vertico
       (corfu +orderless)

       :ui
       deft                   ; notational velocity for Emacs
       doom                   ; what makes DOOM look the way it does
       doom-dashboard         ; a nifty splash screen for Emacs
       doom-quit              ; DOOM quit-message prompts when you quit Emacs
       ;; (emoji +unicode)    ; 🙂
       hl-todo                ; highlight TODO/FIXME/NOTE tags
       indent-guides          ; highlighted indent columns
       ;;ligatures            ; ligatures and symbols to make your code pretty again
       ;;minimap              ; show a map of the code on the side
       modeline               ; snazzy, Atom-inspired modeline, plus API
       nav-flash              ; blink the current line after jumping
       ;; neotree             ; a project drawer, like NERDTree for vim
       ophints                ; highlight the region an operation acts on
       treemacs               ; a project drawer, like neotree but cooler
       (popup                 ; tame sudden yet inevitable temporary windows
        +all                  ; catch all popups that start with an asterix
        +defaults)            ; default popup rules
       ;; tabs                ; an tab bar for Emacs
       ;;unicode              ; extended unicode support for various languages
       vc-gutter              ; vcs diff in the fringe
       vi-tilde-fringe        ; fringe tildes to mark beyond EOB
       window-select          ; visually switch windows
       workspaces             ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere)     ; come to the dark side, we have cookies
       file-templates         ; auto-snippets for empty files
       fold                   ; (nigh) universal code folding
       ;;(format +onsave)     ; automated prettiness
       lispy                  ; vim for lisp, for people who dont like vim
       multiple-cursors       ; editing in many places at once
       ;;parinfer             ; turn lisp into python, sort of
       rotate-text            ; cycle region at point between text candidates
       snippets               ; my elves. They type so I don't have to
       word-wrap

       :emacs
       (dired                 ; making dired pretty [functional]
        ;; +dirvish
        ;; +ranger            ; bringing the goodness of ranger to dired
        ;; +icons             ; colorful icons for dired-mode
        )
       electric               ; smarter, keyword-based electric-indent
       undo                   ; persistent, smarter undo for your inevitable mistakes
       vc                     ; version-control and Emacs, sitting in a tree

       :term
       eshell                 ; a consistent, cross-platform shell (WIP)
       ;;term                 ; terminals in Emacs
       vterm                  ; another terminals in Emacs

       :checkers
       syntax                 ; tasing you for every semicolon you forget
       (spell                 ; tasing you for misspelling mispelling
        +flyspell)            ; it's slower than spell-fu but support non-english languages
       grammar                ; tasing grammar mistake every you make

       :tools
       ansible
       direnv
       ;; debugger            ; FIXME stepping through code, to help you add bugs
       docker
       editorconfig           ; let someone else argue about tabs vs spaces
       ;;ein                  ; tame Jupyter notebooks with emacs
       eval                   ; run code, run (also, repls)
       ;;gist                 ; interacting with github gists
       (lookup                ; helps you navigate your code and documentation
        +docsets)             ; ...or in Dash docsets locally
       lsp
       ;;macos                ; MacOS-specific commands
       make                   ; run make tasks from Emacs
       magit                  ; a git porcelain for Emacs
       (pass                  ; password manager for nerds
        +auth)
       pdf                    ; pdf enhancements
       ;;prodigy              ; FIXME managing external services & code builders
       ;;terraform            ; infrastructure as code
       ;;tmux                 ; an API for interacting with tmux
       ;;upload               ; map local to remote projects via ssh/ftp
       ;;wakatime

       :lang
       (cc +lsp)              ; C/C++/Obj-C madness
       ;;clojure              ; java with a lisp
       ;;common-lisp          ; if you've seen one lisp, you've seen them all
       ;;coq                  ; proofs-as-programs
       ;;crystal              ; ruby at the speed of c
       ;;csharp               ; unity, .NET, and mono shenanigans
       data                   ; config/data formats
       ;;erlang               ; an elegant language for a more civilized age
       ;;elixir               ; erlang done right
       ;;elm                  ; care for a cup of TEA?
       emacs-lisp             ; drown in parentheses
       ;;ess                  ; emacs speaks statistics
       (go +lsp)              ; the hipster dialect
       ;;(haskell +intero)    ; a language that's lazier than I am
       ;;hy                   ; readability of scheme w/ speed of python
       ;;idris             ;
       json                   ; At least it ain't XML
       ;;(java +meghanada)    ; the poster child for carpal tunnel syndrome
       (javascript +lsp)      ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia                ; a better, faster MATLAB
       ;;latex                ; writing papers in Emacs has never been so fun
       ledger                 ; an accounting system in Emacs
       ;;lua                  ; one-based indices? one-based indices
       markdown               ; writing docs for people to ignore
       ;;nim                  ; python + lisp at the speed of c
       ;; nix                 ; I hereby declare "nix geht mehr!"
       ;;ocaml                ; an objective camel
       (org                   ; organize your plain life in plain text
        +attach               ; custom attachment system
        +babel                ; running code in org
        +capture              ; org-capture in and outside of Emacs
        +export               ; Exporting org to whatever you want
        ;; +roam2
        +present)             ; Emacs for presentations
       ;;perl                 ; write code no one else can comprehend
       php                    ; perl's insecure younger brother
       ;;plantuml             ; diagrams for confusing people more
       ;;purescript           ; javascript, but functional
       (python +lsp)          ; beautiful is better than ugly
       ;;qt                   ; the 'cutest' gui framework ever
       ;;racket               ; a DSL for DSLs
       ;;rest                 ; Emacs as a REST client
       ;;ruby                 ; 1.step do {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp)            ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala                ; java, but good
       scheme                 ; a fully conniving family of lisps
       (sh +lsp)              ; she sells (ba|z|fi)sh shells on the C xor
       ;;solidity             ; do you need a blockchain? No.
       ;;swift                ; who asked for emoji variables?
       (web +lsp)             ; the tubes
       yaml                   ; JSON, but readable
       ;;vala                 ; GObjective-C

       :email
       ;; (mu4e +gmail)       ; WIP
       ;;notmuch              ; WIP
       ;;(wanderlust +gmail)  ; WIP

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
       ;;irc                  ; how neckbeards socialize
       (rss +org)             ; emacs as an RSS reader
       ;;twitter              ; twitter client https://twitter.com/vnought

       :collab
       ;;floobits             ; peer programming for a price
       ;;impatient-mode       ; show off code over HTTP

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
       ;; (selectrum +orderless
       evolix
       mu4e
       ;; (selectrum +prescient
       ;;            +childframe)
       gnus)
