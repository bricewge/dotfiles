;;; private/org/+outshine.el -*- lexical-binding: t; -*-

(add-hook 'prog-mode-hook #'outshine-mode)
(add-hook 'conf-mode-hook #'outshine-mode)
(use-package! outshine
  ;; TODO binding for evil
  :bind (:map outline-minor-mode-map
          ("<S-iso-lefttab>" . #'outshine-cycle-buffer))
  :config
  (setq outshine-org-style-global-cycling-at-bob-p t)
  (setq outshine-startup-folded-p nil)
  ;; test
  (setq  +emacs-lisp-outline-regexp "[ \t]*;; \\*+"))

(use-package! poporg
  :commands (poporg-dwim)
  :init
  (map!
   :n "C-c \"" #'poporg-dwim
   (:leader :prefix "t"
     :desc "Edit in org buffer"
     :n "o" #'poporg-dwim)))
