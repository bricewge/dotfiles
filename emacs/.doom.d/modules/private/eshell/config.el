;;; private/eshell/config.el -*- lexical-binding: t; -*-

;; NOTE This is a copy of doom/modules/emacs/eshell/autoload.prompts.el
;; TODO Port [[https://github.com/sindresorhus/pure][pure]] prompt theme to eshell
;; TODO Tryout https://github.com/manateelazycat/aweshell

(after! eshell
;;; prompt
;;;###autoload
  (defface +eshell-prompt-pwd '((t :inherit font-lock-constant-face))
    "TODO"
    :group 'eshell)

;;;###autoload
  (defface +eshell-prompt-git-branch '((t :inherit font-lock-builtin-face))
    "TODO"
    :group 'eshell)


  (defun +eshell--current-git-branch ()
    (let ((branch (car (cl-loop for match in (split-string (shell-command-to-string "git branch") "\n")
                                if (string-match-p "^\*" match)
                                collect match))))
      (if (not (eq branch nil))
          (format " [%s]" (substring branch 2))
        "")))

;;;; end of the copy
  (defun +eshell-default-prompt ()
    "Generate the prompt string for eshell. Use for `eshell-prompt-function'."
    (concat (if (bobp) "" "\n")
            (let ((pwd (eshell/pwd)))
              (propertize (if (equal pwd "~")
                              pwd
                            (abbreviate-file-name (shrink-path-file pwd)))
                          'face '+eshell-prompt-pwd))
            (propertize (+eshell--current-git-branch)
                        'face '+eshell-prompt-git-branch)
            (propertize "\n❯" 'face (if (zerop eshell-last-command-status) 'success 'error))
            " "))

  (setq eshell-prompt-regexp "^❯ ")
;;; aliases
  (set-eshell-alias!
   "q"    "exit"
   "f"    "find-file $1"
   "bd"     "eshell-up $1"
   "l"      "ls -lh"
   "ll"     "ls -lah"
   "d"      "dired $1"
   "gl"     "(call-interactively 'magit-log-current)"
   "gs"     "magit-status"
   "gc"     "magit-commit"
   "rg"     "rg --color=always"
   "ag"     "ag --color=always"
   "clear"  "clear-scrollback"
   "yt"     "youtube-dl"
   )

  )
;;; autosuggest
(use-package! esh-autosuggest
  ;; :commands (esh-autosuggest-mode)
  :hook (eshell-mode . 'esh-autosuggest-mode)
  ;; :ensure t
  )

;; ;;; fix for nixos
;; ;; https://github.com/hlissner/doom-emacs/issues/913
;; (after! em-term
;;   (setq eshell-visual-commands (delete "bash" eshell-visual-commands)))

;;; alert
(use-package! alert
  :config
  (setq alert-default-style 'libnotify))

;; https://blog.hoetzel.info/post/eshell-notifications/
(defun eshell-command-alert (process status)
  "Send `alert' with severity based on STATUS when PROCESS finished."
  (let* ((cmd (process-command process))
         (buffer (process-buffer process))
         (msg (format "%s: %s" (mapconcat 'identity cmd " ")  status)))
    (if (string-prefix-p "finished" status)
        (alert msg :buffer buffer :severity  'normal)
      (alert msg :buffer buffer :severity 'urgent))))

(add-hook 'eshell-kill-hook #'eshell-command-alert)
(alert-add-rule :status   '(buried)     ;only send alert when buffer not visible
                :mode     'eshell-mode
                :style 'notifications)
