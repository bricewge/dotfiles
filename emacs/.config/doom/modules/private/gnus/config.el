;;; private/gnus/config.el -*- lexical-binding: t; -*-

;; TODO add http://bewatermyfriend.org/p/2011/00a/
;; TODO add https://www.emacswiki.org/emacs/GnusFormatting#toc4


(after! message
  (setq message-auto-save-directory
      (concat doom-cache-dir "message")))

(after! sendmail
  (setq sendmail-program "msmtp"))
