(define picom
  (make <service>
    #:docstring "Compositor for X11."
    #:provides '(picom compositor)
    #:start (make-forkexec-constructor
             '("picom" "--experimental-backends"))
    #:stop (make-kill-destructor)
    #:actions (make-actions
               (reload "Reload configuration."
                       (lambda (pid . args)
                         (kill (- pid) SIGUSR1))))))

(register-services picom)

(start picom)
