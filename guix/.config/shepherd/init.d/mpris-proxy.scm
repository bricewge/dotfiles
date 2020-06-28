(define mpris-proxy
  (make <service>
    #:docstring "Bluetooth MPRIS proxy."
    #:provides '(mpris-proxy)
    #:start (make-forkexec-constructor '("mpris-proxy"))
    #:stop (make-kill-destructor)))

(register-services mpris-proxy)

(start mpris-proxy)
