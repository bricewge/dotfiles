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
(setq user-mail-address "brice.wge@gmail.com"
      user-full-name "Brice Waegeneire")

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


;; * outshine
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
(setq doom-theme 'doom-solarized-dark)
(setq doom-font "Meslo LG S-11")

;; * completion
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
;; (use-package! ranger
;;    :config
;;    (setq ranger-footer-delay nil))

;; ** man
(after! man
  (set-face-attribute 'Man-overstrike nil
                      :inherit font-lock-type-face :bold t)
  (set-face-attribute 'Man-underline nil
                      :inherit font-lock-keyword-face :underline t))

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
(load! "+eshell")

;; * tools
;; ** direnv
(after! direnv
  (setq direnv-always-show-summary nil))

;; ** flyspell
(after! flyspell
  (setq ispell-dictionary "english"))

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
  (magit-wip-mode))

;; ** pass
(use-package! auth-source-pass
  :config
  (setq auth-sources '(password-store))
  (auth-source-forget-all-cached))

;; ** epub
(use-package! nov
  :mode ("\\.epub" . nov-mode)
  :config
  ;; (defun my-nov-font-setup ()
  ;;   (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
  ;;                            :height 1.0))
  ;; (add-hook 'nov-mode-hook 'my-nov-font-setup)
  (setq nov-text-width 80)
  ;; (require 'justify-kp)
  ;; (setq nov-text-width most-positive-fixnum)

  ;; (defun my-nov-window-configuration-change-hook ()
  ;;   (my-nov-post-html-render-hook)
  ;;   (remove-hook 'window-configuration-change-hook
  ;;                'my-nov-window-configuration-change-hook
  ;;                t))

  ;; (defun my-nov-post-html-render-hook ()
  ;;   (if (get-buffer-window)
  ;;       (let ((max-width (pj-line-width))
  ;;             buffer-read-only)
  ;;         (save-excursion
  ;;           (goto-char (point-min))
  ;;           (while (not (eobp))
  ;;             (when (not (looking-at "^[[:space:]]*$"))
  ;;               (goto-char (line-end-position))
  ;;               (when (> (shr-pixel-column) max-width)
  ;;                 (goto-char (line-beginning-position))
  ;;                 (pj-justify)))
  ;;             (forward-line 1))))
  ;;     (add-hook 'window-configuration-change-hook
  ;;               'my-nov-window-configuration-change-hook
  ;;               nil t)))

  ;; (add-hook 'nov-post-html-render-hook 'my-nov-post-html-render-hook)
  )

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
(load! "+org")

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

;; ** vuejs
(use-package! vue-mode
  :commands (vue-mode)
  :mode "\\.vue"
  :config
  (set-face-background 'mmm-default-submode-face nil))

;; * email
(load! "+mail")

;; * app

;; * collab

;; * config
(after! epa
  ;; I prefer seeing a popup window with the correct message. Not asking for the
  ;; "Passpharse" for a key while just wanting the PIN for it
  (setq epa-pinentry-mode 'ask))
