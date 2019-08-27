;;; private/org/config.el -*- lexical-binding: t; -*-

;; * org-mode
;; ** org-agenda
;; https://www.reddit.com/r/emacs/comments/9v7ut1/screenshot_showcase_2018/e9a3h99/

(after! org
  (setq org-agenda-block-separator ?\u2015
        ;; org-todo-keyword-faces
        ;; `(("WAITING"   :foreground "#fabd2f" :weight bold)
        ;;   ("DELEGATED" :foreground "#fabd2f" :weight bold)
        ;;   ("NOTE"      :foreground "#83a598" :weight bold)
        ;;   ("MEETING"   :foreground "#83a598" :weight bold)
        ;;   ("LATER"     :foreground "#83a598" :weight bold)
        ;;   ("NEXT"      :foreground "#b8bb26" :weight bold))
        org-agenda-custom-commands
        '(("n" "Agenda"
           ((agenda "" nil)
            (todo "NEXT"
                  ((org-agenda-overriding-header
                    (concat (all-the-icons-faicon "bolt" :v-adjust 0.01)
                            " Next Tasks"))
                   (org-agenda-sorting-strategy
                    '(priority-down category-up))))
            (todo "TODO"
                  ((org-agenda-files '("~/Dropbox/org/test.org"))
                   (org-agenda-overriding-header
                    (concat (all-the-icons-faicon "tasks" :v-adjust 0.01)
                            " Tasks"))))
            (todo "WAITING|DELEGATED"
                  ((org-agenda-overriding-header
                    (concat (all-the-icons-faicon "hourglass" :v-adjust 0.01)
                            " Waiting/Delegated"))
                   (org-agenda-sorting-strategy '(todo-state-up))))
            (todo "LATER"
                  ((org-agenda-overriding-header
                    (concat (all-the-icons-faicon "thumb-tack" :v-adjust 0.01)
                            " Later"))))
            (todo "NOTE"
                  ((org-agenda-overriding-header
                    (concat (all-the-icons-faicon "sticky-note" :v-adjust 0.01)
                            " Notes"))))))

          ))

  (set-face-attribute 'org-agenda-structure nil :inherit 'default :height 1.50)
  ;; (set-face-attribute 'org-agenda-date-weekend nil :slant 'italic :height 1.00 :weight 'light)
  ;; (set-face-attribute 'org-agenda-calendar-event nil :foreground "#fabd2f")
  ;; (set-face-attribute 'org-agenda-date nil :foreground "#d5c4a1" :inherit 'default :height 1.25)
  ;; (set-face-attribute 'org-agenda-date-today nil :slant 'normal :weight 'bold :height 1.25)


  (set-popup-rule! "^\\*Org Agenda*" :slot -1 :vslot -1 :size '+popup-shrink-to-fit :side 'right)
  ;; +org-capture/open-frame
  ;; (after! ivy-postframe
  ;; ;; (push '(+org-capture/open-frame . ivy-display-function-fallback)
  ;; ;;       ivy-display-functions-alist)
  ;;   (setf (alist-get +org-capture/open-frame ivy-display-functions-alist)
  ;;         #'ivy-display-function-fallback)
  ;;   )

  ;; ** capture
  (add-to-list 'org-capture-templates
             '("l" "Logbook" entry (file+olp+datetree "~/org/logbook.org")
               "* %<%R: >%? %^g\n%t" :prepend t))
  ;; * old
  (setq org-ellipsis "⤵") ; Replace the "..." of folded headings by something more fancy

  (setq org-export-backends '(ascii
                              html
                              latex
                              md
                              odt
                              ;; Not part of Emacs
                              koma-letter
                              ))
  ;; Set task states sequences as http://doc.norang.ca/org-mode.html#TodoKeywordTaskStates
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))
  (setq org-log-done (quote time)) ;; Log the time when a task is marked as DONE
  (setq org-log-into-drawer t)     ;; Keep the log info in the :LOGBOOK: drawer
  (setq org-log-reschedule 'note)  ;; Log the change when rescheduling
  )

(defun +bricewge/capture ()
  "Capture something."
  (interactive)
  (require 'org-capture)
  (ivy-read "Capture template: "
            (delq nil
                  (mapcar
                   (lambda (x)
                     (when (> (length x) 2)
                       (format "%-5s %s" (nth 0 x) (nth 1 x))))
                   ;; We build the list of capture templates as in
                   ;; `org-capture-select-template':
                   (or (org-contextualize-keys
                        (org-capture-upgrade-templates org-capture-templates)
                        org-capture-templates-contexts)
                       '(("t" "Task" entry (file+headline "" "Tasks")
                          "* TODO %?\n  %u\n  %a")))))
            :require-match t
            :action (lambda (x)
                      (org-capture nil (car (split-string x))))
            :caller '+bricewge/capture))

(after! ivy
  ;; (setf (alist-get '+org-capture/open-frame ivy-display-functions-alist)
  ;;       #'ivy-display-function-fallback)
  (setf (alist-get 'counsel-org-capture ivy-display-functions-alist)
        #'ivy-display-function-fallback)
  )

(load! "+outshine")
