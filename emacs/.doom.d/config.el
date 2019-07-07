;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; TODO TRAMP use controlmaster
;; TODO TRAMP remote sudo

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
 :n "U"		#'undo-tree-redo
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
      :desc "M-x"							:nv "\\"		#'execute-extended-command

      (:prefix "w"
        :desc "Ace window"					:n "TAB" 		#'ace-window
        :desc "Ace swap window"			:n "<backtab>"	#'ace-swap-window)
      (:prefix "f"
        :desc "Change file mode"			:n "m"			#'chmod-current-file
        :desc "Make symbolic link"			:n "s"			#'make-symbolic-link-current-file
        :desc "Add file variable"			:n "v"			#'add-file-local-variable
        :desc "Delete file variable"		:n "V"			#'delete-file-local-variable)
      (:desc "application" :prefix "a"
        :desc "Package list"				:n "p"			#'package-show-package-list)
      (:prefix "o"
        :desc "Pass"						:n "p"			#'pass
        :desc "Project sidebar"			:n "s"			#'+neotree/open
        :desc "Open URL"					:n "u"			#'open-url
        :desc "Open URL in popup"			:n "U"			#'browse-url-emacs)
      )


;; * outshine
(add-hook 'prog-mode-hook #'outshine-mode)
(add-hook 'conf-mode-hook #'outshine-mode)
(def-package! outshine
  ;; TODO binding for evil
  :bind (:map outline-minor-mode-map
          ("<S-iso-lefttab>" . outshine-cycle-buffer))
  :config
  (setq outshine-org-style-global-cycling-at-bob-p t)
  (setq outshine-startup-folded-p nil)
  ;; test
  (setq  +emacs-lisp-outline-regexp "[ \t]*;; \\*+"))

(def-package! poporg
  :commands (poporg-dwim)
  :init
  (map!
   :n "C-c \""	#'poporg-dwim
   (:leader
     :prefix "t"
     :desc "Edit in org buffer"	:n "o"	#'poporg-dwim)))

;;
;;
;; NOTE Next the structure follows doom's
;;
;;

;; * core

;; ** project
(after! projectile
  ;; https://github.com/hlissner/doom-emacs/issues/1087#issuecomment-450757249
  (advice-remove #'projectile-locate-dominating-file
                 #'doom*projectile-locate-dominating-file))

;; (def-package-hook! projectile
;;   :post-config
;;   (defun bw/projectile-project-root (&optional dir)
;;     "Retrieves the root directory of a project if available.
;; If DIR is not supplied its set to the current directory by default."
;;     ;; the cached value will be 'none in the case of no project root (this is to
;;     ;; ensure it is not reevaluated each time when not inside a project) so use
;;     ;; cl-subst to replace this 'none value with nil so a nil value is used
;;     ;; instead
;;     (let ((dir (or dir (directory-file-name default-directory))))
;;       (cl-subst nil 'none
;;                 (or (cl-some
;;                      (lambda (func)
;;                        (let* ((cache-key (format "%s-%s" func dir))
;;                               (cache-value (gethash cache-key projectile-project-root-cache)))
;;                          (if (and cache-value (file-exists-p cache-value))
;;                              cache-value
;;                            (let ((value (funcall func (file-truename dir))))
;;                              (puthash cache-key value projectile-project-root-cache)
;;                              value))))
;;                      projectile-project-root-files-functions)
;;                     ;; set cached to none so is non-nil so we don't try
;;                     ;; and look it up again
;;                     'none))))
;;   ;; (add-function :override (projectile-project-root dir) #'bw/projectile-project-root)
;;   (advice-add 'projectile-project-root :override 'bw/projectile-project-root)
;; )

;; ** ui
;; TODO Port solarized dark to doom-themes
;; (setq doom-theme 'doom-solarized-dark)

;; * completion
;; ** ivy
;; (map! :after ivy
;;       (:map ivy-minibuffer-map
;;         "C-c C-c"	#'+bricewge/ivy-few-chars))

;; * ui
;; TODO fix face, ¿remove me?
;; (def-package! hl-fill-column
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
(def-package! evil-lion
  :commands (evil-lion-left evil-lion-right)
  :init
  (map! :prefix "g"
        :nv "l" #'evil-lion-left
        :nv "L" #'evil-lion-right))

;; * emacs
;; ** dired
(setq delete-by-moving-to-trash t)
;; (def-package! ranger
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
          (nil "\\`root\\'" "/sshx:%h:"))))

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

;; ** magit
(after! magit
  (magit-wip-mode))

;; ** pass
(def-package! auth-source-pass
  :config
  (setq auth-sources '(password-store))
  (auth-source-forget-all-cached))

;; ** epub
(def-package! nov
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
;; ** org
(load! "+org")

;; ** sh
(after! company-shell
  (setq company-shell-clean-manpage t))

;; ** systemd
(def-package! systemd
  :defer t
  :init
  (setq systemd-use-company-p (featurep! :completion company))
  :config
  (map! :map systemd-mode-map
        :localleader
        :desc "Systemd directives" :nve "d" #'systemd-doc-directives
        :desc "Systemd doc open"   :nve "o" #'systemd-doc-open))

;; ** vuejs
(def-package! vue-mode
  :commands (vue-mode)
  :mode "\\.vue"
  :config
  (set-face-background 'mmm-default-submode-face nil))

;; * email
(after! mu4e
(set-email-account! "gmail"
  '((mu4e-sent-folder       . "/gmail/sent")
    (mu4e-drafts-folder     . "/gmail/draft")
    (mu4e-trash-folder      . "/gmail/trash")
    (mu4e-refile-folder     . "/gmail/all")
    (smtpmail-smtp-user     . "brice.wge@gmail.com")
    (user-mail-address      . "brice.wge@gmail.com")
    (mu4e-compose-signature . "---\nbricewge ~ 8929 BBC5 73CD 9206 3DDD  979D 3D36 CAA0 116F 0F99"))
  t))
;; * app

;; * collab

;; * config
(after! epa
  ;; I prefer seeing a popup window with the correct message. Not asking for the
  ;; "Passpharse" for a key while just wanting the PIN for it
  (setq epa-pinentry-mode 'ask))
