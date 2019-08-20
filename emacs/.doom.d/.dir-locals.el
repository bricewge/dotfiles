;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((emacs-lisp-mode . ((flycheck-disabled-checkers . 'emacs-lisp-checkdoc)
                     (eval . (set (make-local-variable 'flycheck-emacs-lisp-check-form)
                                  +emacs-lisp-reduced-flycheck-emacs-lisp-check-form-h)))))
