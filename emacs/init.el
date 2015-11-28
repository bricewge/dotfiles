;;  This file is needed to bootstrap the Emacs' configuration.

;;; Interface
; Turn off the mouse interface early to avoid momentary displaying it
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))


;;; Package management
;;;; ELPA
(require 'package)
;; List of elpa repository
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)
(setq package-enable-at-startup nil)

;;;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
;; Packaged called with use-package are installed automaticaly
(setq use-package-always-ensure t)

;;;; Quelpa
; [[https://github.com/quelpa/quelpa][Quelpa]] is usefull when a
; package is not yet in MELPA or need a patch. It can be build from source and installed with =package.el= seamlessly.
(use-package quelpa
  :ensure t)

; Enable the use of Quelpa with use-package.
(use-package quelpa-use-package
  :ensure t
  :config
  (quelpa-use-package-activate-advice))


;;; org-mode
(use-package org
  :ensure org-plus-contrib
  :pin org)

;;; org-babel
; The actual configuration in a literate programming style
(org-babel-load-file (expand-file-name "bricewge.org" user-emacs-directory))
