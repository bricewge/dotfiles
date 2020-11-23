(define redshift
  (make <service>
    #:doctring "Adjust the color temperature of the screen."
    #:provides '(redshift)
    #:start (make-forkexec-constructor '("redshift" "-P"))
    #:stop (lambda (pid . args)
             (apply (make-kill-destructor SIGKILL) pid args)
             (action 'redshift 'reset))
    #:actions (make-actions
               (toggle "Pause or resume the color temperature adjustement"
                       (make-kill-destructor SIGUSR1))
               (reset "Remove adjustment from screen"
                      (make-forkexec-constructor '("redshift" "-x"))))))

(register-services redshift)

(start redshift)
