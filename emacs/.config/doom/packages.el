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

(package! guix)
(package! debbugs)
(package! daemons)

(package! ascii-art-to-unicode)

(package! sed-mode)

(package! bluetooth)

(package! vimgolf :recipe (:host github :repo "timvisher/vimgolf.el"))
(package! denote)
(package! denote-menu)

(package! erc-scrolltoplace)

;; TODO Fixes https://github.com/doomemacs/themes/issues/668
(unpin! doom-themes)
(package! doom-themes
  :recipe (:host github :repo "bricewge/emacs-doom-themes")
  :pin nil)
