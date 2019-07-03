;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! vue-mode)
(package! systemd)

(package! outshine)
(package! poporg)
(package! evil-lion)

(package! solarized-theme)

(package! yasnippet-snippets)
(package! webpaste)

(package! esh-autosuggest)
(package! alert)

(package! org-caldav
  :recipe (:fetcher github :repo "grauschnabel/org-caldav")) ;; VTODO support

(package! org-noter)  ;; annotate documents
(package! nov)        ;; epub reader

(package! guix)
(package! geiser)

(package! ascii-art-to-unicode)

;; WAITING https://github.com/hlissner/emacs-doom-themes/pull/286
(package! doom-themes
  :recipe
  (:fetcher github
            :repo "bricewge/emacs-doom-themes"
            :branch "hl-fill-column"
            :files ("*.el" "themes/*.el")
            ))
