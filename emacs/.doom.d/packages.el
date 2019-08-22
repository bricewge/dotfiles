;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! vue-mode)
(package! systemd)

(package! evil-lion)

(package! yasnippet-snippets)
(package! webpaste)

(package! esh-autosuggest)
(package! alert)

(package! guix)
(package! geiser)
(package! gitpatch)
(package! mu4e-patch
  :recipe (:host github :repo "seanfarley/mu4e-patch"))

(package! ascii-art-to-unicode)

;; WAITING https://github.com/hlissner/emacs-doom-themes/pull/286
(package! doom-themes
  :recipe
  (:host github
         :repo "hlissner/emacs-doom-themes"
         :fork (:host nil
                      :repo "git@github.com:bricewge/emacs-doom-themes.git"
                      :branch "bricewge"
                      :remote "bricewge")
         :files ("*.el" "themes/*.el")))

(package! vimgolf :recipe (:host github :repo "timvisher/vimgolf.el"))
