;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(defun chmod-current-file ()
  (interactive)
  (chmod buffer-file-name
         (read-file-modes nil buffer-file-name)))
;;  TODO Rename file in current buffer

(defun make-symbolic-link-current-file ()
  (interactive)
  (make-symbolic-link buffer-file-name
                      (read-file-name (concat "Make symbolic link to file "
                                              buffer-file-name
                                              ": "))))
;; TODO `browse-url-interactive-arg' should be better:
;; - no invalid URL
;; - prefill if kill-ring is an URL
;; (require! 'browse-url)
;; (defun open-url (url &optional _new-window)
;;   "Ask Emacs to load URL into a buffer"
;;   (interactive (browse-url-interactive-arg "URL: "))
;;   (require 'url-handlers)
;;   (let ((file-name-handler-alist
;;          (cons (cons url-handler-regexp 'url-file-handler)
;;                file-name-handler-alist)))
;;     (find-file url)))

;; ** personal information
(setq user-mail-address "brice@waegenei.re"
      user-full-name "Brice Waegeneire")

(setq copyright-names-regexp user-mail-address)

;; * keybindings
(map!
 :n "U"     #'undo-tree-redo
 ;; Easier window navigation
 :n "C-h"   #'evil-window-left
 :n "C-j"   #'evil-window-down
 :n "C-k"   #'evil-window-up
 :n "C-l"   #'evil-window-right

 ;; (:after treemacs-evil
 ;;   (:map evil-treemacs-state-map
 ;;     "C-h" #'evil-window-left
 ;;     "C-l" #'evil-window-right))
 )
(map! :leader
      :desc "M-x"
      :nv "\\"        #'execute-extended-command

      (:prefix "w"
        :desc "Ace window"
        :n "TAB"        #'ace-window
        :desc "Ace swap window"
        :n "<backtab>"  #'ace-swap-window)
      (:prefix "f"
        :desc "Change file mode"
        :n "m"          #'chmod-current-file
        :desc "Make symbolic link"
        :n "s"          #'make-symbolic-link-current-file
        :desc "Add file variable"
        :n "v"          #'add-file-local-variable
        :desc "Delete file variable"
        :n "V"          #'delete-file-local-variable)
      (:prefix "o"
        :desc "Password manager"
        :n "w"          #'pass
        :desc "Open URL"
        :n "u"          #'open-url
        :desc "Open URL in popup"
        :n "U"          #'browse-url-emacs)
      )

;;
;;
;; NOTE Next the structure follows doom's
;;
;;

;; * core

;; ** project
(after! projectile
  ;; Enable the use of projectile through TRAMP
  ;; https://github.com/hlissner/doom-emacs/issues/1087#issuecomment-450757249
  (advice-remove #'projectile-locate-dominating-file
                 #'doom*projectile-locate-dominating-file))

;; ** ui
(setq doom-theme
      (intern
       (let* ((theme-file (file-chase-links
                           (concat (getenv "XDG_CONFIG_HOME")
                                   "/theme/current-theme")))
              (theme-variant (file-name-base theme-file))
              (theme (file-name-nondirectory
                      (directory-file-name
                       (file-name-directory theme-file)))))
         (concat "doom-" theme "-" theme-variant))))

(setq doom-font "Meslo LG S-11")

(when (getenv "MANWIDTH")
  (setq-default fill-column (string-to-number (getenv "MANWIDTH"))))

;; * completion
;; ** selectrum

;; ** ivy
;; (map! :after ivy
;;       (:map ivy-minibuffer-map
;;         "C-c C-c"	#'+bricewge/ivy-few-chars))

;; * ui
;; TODO fix face, ¿remove me?
;; (use-package! hl-fill-column
;;   :config
;;   (global-hl-fill-column-mode)
;;   )

;; ** hl-todo
(after! hl-todo
  (add-to-list 'hl-todo-keyword-faces
               `("WAITING" . ,(face-foreground 'default)) t))

;; ** popup
;; ~+popup-shrink-to-fit~ doesn't shrink enough the =*Customize Group*= buffer
(set-popup-rule! "^\\*Customize"
  :slot 2 :side 'right :size 80 :select t :quit t)

;; * editor
;; ** evil
;; *** lion
(use-package! evil-lion
  :commands (evil-lion-left evil-lion-right)
  :init
  (map! :prefix "g"
        :nv "l" #'evil-lion-left
        :nv "L" #'evil-lion-right))

;; * emacs
;; ** dired
(setq delete-by-moving-to-trash t)

;; ** man
(map! :leader (:prefix "h" :desc "Call WoMan" :n "W" #'woman))
(after! woman
  (setq woman-fill-column fill-column)
  (set-popup-rule! "^\\*WoMan "
    :slot 2 :side 'right :size (+ 5 woman-fill-column) :select t :quit t))

;; ** tramp
(after! tramp
  (setq tramp-histfile-override t)
  ;; use config from ~/.ssh/config
  (setq tramp-use-ssh-controlmaster-options nil)
  ;; access remote sudo hosts with =/sudo:remote:/path=
  (setq tramp-default-proxies-alist
        '(((regexp-opt (cons (system-name) '("localhost"))) nil nil)
          (nil "\\`root\\'" "/sshx:%h:")))
  ;; GUIX specific
  (setq tramp-remote-path
        (append tramp-remote-path
                '("~/.guix-profile/bin" "~/.guix-profile/sbin"
                  "/run/current-system/profile/bin"
                  "/run/current-system/profile/sbin"))))

;; * term
;; ** eshell

;; * tools
;; ** direnv
(after! direnv
  (setq direnv-always-show-summary nil))

;; ** flyspell
(after! flyspell
  (setq ispell-dictionary "english")
  (setq flyspell-issue-message-flag nil) ;; make it quite. Huge speed up!!
  (add-hook 'git-commit-setup-hook 'git-commit-turn-on-flyspell))

;; ** gitpatch
(after! gitpatch
  (map! :leader
        (:prefix "g"
          :desc "Mail a patch"    :n "m" #'gitpatch-mail
          :desc "Attach patch to mail"   :n "M" #'gitpatch-mail-attach-patch))
  (setq gitpatch-mail-function #'+mu4e/compose)
  (setq gitpatch-mail-database
        '("guix-devel@gnu.org")))

;; ** magit
(after! magit
  (magit-wip-mode)
  ;; don't use the fringe to indicate section visibility
  (setq magit-section-visibility-indicator '("…" . t))

  ;; force english language in magit
  (defadvice magit-call-process (around lang-en_US activate)
    "Set environment variable LANGUAGE to C."
    (let ((process-environment process-environment))
      (setenv "LANGUAGE" "C")
      ad-do-it))
  (defadvice magit-start-process (around lang-en_US activate)
    "Set environment variable LANGUAGE to C."
    (let ((process-environment process-environment))
      (setenv "LANGUAGE" "C")
      ad-do-it)))

;; ** pass
(after! auth-source-pass
  ;; force pass as auth sources
  (setq auth-sources '(password-store))
  (auth-source-forget-all-cached))

;; ** debbugs
(after! debbugs
  (setq debbugs-gnu-persistency-file (concat doom-cache-dir "debbugs")
        debbugs-gnu-default-packages '("guix" "guix-patches")))

;; ** rgb
;; TODO add support for rainbow-mode in alacritty config
;; variable: rainbow-hexadecimal-colors-font-lock-keywords
;; example value: '0x073642'

;; * lang
;; ** guile
(after! guix
  (setq guix-directory "~/project/guix")
  (add-hook 'after-init-hook 'global-guix-prettify-mode)
  (add-hook 'scheme-mode-hook 'guix-devel-mode)
  (with-eval-after-load 'geiser-guile
    ;; NOTE: "~/.config/guix/latest/" is invaild,
    ;; use "~/.config/guix/latest" instead.
    (add-to-list 'geiser-guile-load-path
                 (concat (file-name-directory (locate-library "geiser.el"))
                         "scheme/guile"))
    (add-to-list 'geiser-guile-load-path "~/.config/guix/latest")))

;; ** org

;; ** sh
(after! company-shell
  (setq company-shell-clean-manpage t))

;; ** systemd
(use-package! systemd
  :defer t
  :init
  (setq systemd-use-company-p (featurep! :completion company))
  :config
  (map! :map systemd-mode-map
        :localleader
        :desc "Systemd directives" :nve "d" #'systemd-doc-directives
        :desc "Systemd doc open"   :nve "o" #'systemd-doc-open))

;; ** texinfo
(after! texinfo
  :config
  (add-hook 'texinfo-mode-hook (lambda () (flyspell-mode 1))))

;; ** vuejs
(use-package! vue-mode
  :commands (vue-mode)
  :mode "\\.vue"
  :config
  (set-face-background 'mmm-default-submode-face nil))

;; * email

;; * app

;; ** erc
(after! erc
  (add-to-list 'erc-modules 'notifications)

  (after! erc-scrolltoplace
    (add-to-list 'erc-modules 'scrolltoplace))
  (erc-update-modules)

  ;; *** behaviour
  (persp-def-auto-persp "erc"
                        :parameters '((dont-save-to-file . t))
                        :mode 'erc-mode)
  (setq erc-query-display 'buffer)


  ;; *** style
  (setq erc-prompt
        (lambda ()
          (let ((prompt (if (and (boundp 'erc-default-recipients)
                                 (erc-default-target))
                            (concat (if (erc-query-buffer-p) "@" "")
                                    (erc-default-target)
                                    ">")
                          "ERC>")))
            (erc-propertize prompt 'read-only t 'rear-nonsticky t
                            'front-nonsticky t)))))

;; * collab

;; * config
(after! epa
  ;; I prefer seeing a popup window with the correct message. Not asking for the
  ;; "Passpharse" for a key while just wanting the PIN for it
  (setq epa-pinentry-mode 'ask))
