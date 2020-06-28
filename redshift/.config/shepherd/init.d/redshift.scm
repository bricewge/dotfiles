(define redshift
  (make <service>
    #:doctring "Adjust the color temperature of the screen."
    #:provides '(redshift)
    #:start (make-forkexec-constructor '("redshift" "-P"))
    #:stop (make-kill-destructor SIGKILL)))

(register-services redshift)

(start redshift)
