(define xsettingsd
  (make <service>
    #:docstring "Daemon that implements the XSETTINGS specification."
    #:provides '(xsettingsd xsettings)
    #:start (make-forkexec-constructor
             '("xsettingsd"))
    #:stop (make-kill-destructor)
    #:actions (make-actions
               (reload "Reload configuration."
                       (lambda (pid . args)
                         (kill (- pid) SIGHUP))))))

(register-services xsettingsd)

(start xsettingsd)
