;;; private/dired/config.el -*- lexical-binding: t; -*-

(after! dired-k
  (setq dired-k-style nil))

(use-package! dired-git-info
  :general
  (:states 'normal
           :keymaps 'dired-mode-map
           ")" #'dired-git-info-mode))
