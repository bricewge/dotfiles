;;; ~/.doom.d/+mail.el -*- lexical-binding: t; -*-

;; * sendmail
(setq sendmail-program "msmtp"
      send-mail-function 'smtpmail-send-it
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-send-mail-function 'message-send-mail-with-sendmail)

;; * mu4e
(after! mu4e
  (setq mu4e-get-mail-command "PASSWORD=$(pass email/brice.wge@gmail.com | sed -n '4p') mbsync -a")
  (set-email-account!
   "gmail"
   '((mu4e-sent-folder       . "/gmail/sent")
     (mu4e-drafts-folder     . "/gmail/draft")
     (mu4e-trash-folder      . "/gmail/trash")
     (mu4e-refile-folder     . "/gmail/all")
     (smtpmail-smtp-user     . "brice.wge@gmail.com")
     (user-mail-address      . "brice.wge@gmail.com")
     (mu4e-compose-signature . "bricewge ~ 8929 BBC5 73CD 9206 3DDD  979D 3D36 CAA0 116F 0F99"))
   t)
  ;; fixes https://github.com/hlissner/doom-emacs/issues/1167
  (remove-hook 'mu4e-compose-mode-hook #'org-mu4e-compose-org-mode)
  (add-hook 'mu4e-view-mode-hook #'mu4e-patch-highlight)
  )
