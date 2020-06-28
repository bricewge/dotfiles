(define emacs
  (make <service>
    #:docstring "Emacs daemon."
    #:provides '(emacs)
    #:start (make-forkexec-constructor
             '("emacs" "--fg-daemon"))
    #:stop (make-system-destructor
            "emacsclient --eval '(kill-emacs)'")))

(register-services emacs)

(start emacs)
