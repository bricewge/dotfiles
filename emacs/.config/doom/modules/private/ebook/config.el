;;; app/ebook/config.el -*- lexical-binding: t; -*-

(use-package! justify-kp)
(after! visual-fill-column
  (setq visual-fill-column-center-text t)
  (setq visual-fill-column-width 70)
  )
(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :requires (justify-kp)
  :hook ((nov-mode . +nov-font-setup-h)
         (nov-mode . visual-line-mode)
         (nov-mode . visual-fill-column-mode)
         ;; (nov-mode . +nov-post-html-render-h)
         )
  :config
  (setq nov-text-width t)
  (setq nov-save-place-file (concat doom-cache-dir "nov-places"))
  )
