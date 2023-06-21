;;; private/gnus/config.el -*- lexical-binding: t; -*-

;; TODO add https://www.emacswiki.org/emacs/GnusFormatting#toc4
;; Take inspiration from https://upload.wikimedia.org/wikipedia/commons/c/c3/Gnus-reading-news.png
;; TODO colorize summary
;; TODO use columns in summary
;; TODO Try out https://git.sr.ht/%7Edsemy/nnatom for atom feeds
;; TODO Paginate summary buffer when too much items


(after! message
  (setq message-auto-save-directory
        (concat doom-cache-dir "message")))

(after! sendmail
  (setq send-mail-function 'sendmail-send-it)
  (setq sendmail-program "msmtp"))

(after! gnus
  (set-popup-rule! "^\\*Group" :ignore t)
  (set-popup-rule! "^\\*Summary" :ignore t)
  (set-popup-rule! "^\\*Article" :ignore t)
  (set-popup-rule! "^\\*unsent" :ignore t)
  (setq gnus-use-full-window nil)

  (persp-def-auto-persp "gnus"
                        :parameters '((dont-save-to-file . t))
                        :mode-name "^gnus-.*")

  (setq-default
   gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B%s%)\n"
   gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
   gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
   gnus-thread-sort-functions '(gnus-thread-sort-by-date)
   gnus-sum-thread-tree-false-root ""
   gnus-sum-thread-tree-indent " "
   gnus-sum-thread-tree-leaf-with-other "├► "
   gnus-sum-thread-tree-root ""
   gnus-sum-thread-tree-single-leaf "╰► "
   gnus-sum-thread-tree-vertical "│")

  (setq gnus-select-method
        '(nnimap "dovecot"
          (nnimap-stream shell)
          (nnimap-shell-program "dovecot-imap"))))

(use-package! git-email
  :commands (git-email-send-email git-email-format-patch))

(use-package! piem
  :commands (piem-dispatch))
