;;; private/selectrum/config.el -*- lexical-binding: t; -*-

;; Features:
;; - +childframe
;; - +prescient)

(use-package! selectrum
  :config
  (selectrum-mode +1)
  (marginalia-mode)
  (when (featurep! +childframe)
    (mini-frame-mode +1))
  (when (featurep! +prescient)
    (selectrum-prescient-mode +1)
    (prescient-persist-mode +1)))

(use-package! marginalia
  :config
  (setq marginalia-annotators '(marginalia-annotators-heavy
                                marginalia-annotators-light nil))

  ;; When using Selectrum, ensure that Selectrum is refreshed when cycling
  ;; annotations.
  (advice-add #'marginalia-cycle :after
              (lambda () (when (bound-and-true-p selectrum-mode)
                           (selectrum-exhibit)))))

(use-package! mini-frame
  :when (featurep! +childframe)
  :config
  (setq selectrum-display-action nil)

  ;; WAITING for https://github.com/raxod502/selectrum/issues/169 to be
  ;; properly fixed.
  (define-advice fit-frame-to-buffer
      (:around (f &rest args) dont-skip-ws-for-mini-frame)
    (cl-letf* ((orig (symbol-function #'window-text-pixel-size))
               ((symbol-function #'window-text-pixel-size)
                (lambda (win from to &rest args)
                  (apply orig
                         (append (list win from
                                       (if (and (window-minibuffer-p win)
                                                (frame-root-window-p win)
                                                (eq t to))
                                           nil
                                         to))
                                 args)))))
      (apply f args)))
  (custom-set-variables
   '(mini-frame-show-parameters
     '((top . 0.5)
       (width . 0.7)
       (height . 0.1)
       (left . 0.6)))))
