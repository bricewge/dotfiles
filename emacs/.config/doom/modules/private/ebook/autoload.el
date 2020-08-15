;;; private/ebook/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +nov-window-configuration-change-h ()
  (+nov-post-html-render-h)
  (remove-hook 'window-configuration-change-hook
               '+nov-window-configuration-change-h
               t))
;;;###autoload
(defun +nov-post-html-render-h ()
  (if (get-buffer-window)
      (let ((max-width (pj-line-width))
            buffer-read-only)
        (save-excursion
          (goto-char (point-min))
          (while (not (eobp))
            (when (not (looking-at "^[[:space:]]*$"))
              (goto-char (line-end-position))
              (when (> (shr-pixel-column) max-width)
                (goto-char (line-beginning-position))
                (pj-justify)))
            (forward-line 1))))
    (add-hook 'window-configuration-change-hook
              '+nov-window-configuration-change-h
              nil t)))

;;;###autoload
(defun +nov-font-setup-h ()
  (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                           :height 1.4))
