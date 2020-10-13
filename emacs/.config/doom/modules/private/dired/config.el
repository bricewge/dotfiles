;;; private/dired/config.el -*- lexical-binding: t; -*-

(after! dired-k
  (setq dired-k-style nil))

(after! all-the-icons-dired
  ;; Don't display icons in remote folders.
  ;; From: https://github.com/seagle0128/.emacs.d/commit/334d9afaedd67bc10f207ca72d6daff5ac6469cf
  (defun bricewge/all-the-icons-dired--refresh ()
    "Display the icons of files in a dired buffer."
    (all-the-icons-dired--remove-all-overlays)
    ;; NOTE: don't display icons it too many items
    (if (<= (count-lines (point-min) (point-max)) 1000)
        (save-excursion
          (goto-char (point-min))
          (while (not (eobp))
            (when (dired-move-to-filename nil)
              (let ((file (file-local-name
                           (dired-get-filename 'relative 'noerror))))
                (when file
                  (let ((icon (if (file-directory-p file)
                                  (all-the-icons-icon-for-dir
                                   file
                                   :face 'all-the-icons-dired-dir-face
                                   :height 0.9
                                   :v-adjust all-the-icons-dired-v-adjust)
                                (all-the-icons-icon-for-file
                                 file
                                 :height 0.9
                                 :v-adjust all-the-icons-dired-v-adjust))))
                    (if (member file '("." ".."))
                        (all-the-icons-dired--add-overlay (point) "  \t")
                      (all-the-icons-dired--add-overlay (point) (concat icon "\t")))))))
            (forward-line 1)))
      (message "Not display icons because of too many items.")))
  (advice-add #'all-the-icons-dired--refresh
              :override #'bricewge/all-the-icons-dired--refresh))

(use-package! dired-git-info
  :general
  (:states 'normal
           :keymaps 'dired-mode-map
           ")" #'dired-git-info-mode))
