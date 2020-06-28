(define xbanish
  (make <service>
    #:docstring "Hides idle cursor."
    #:provides '(xbanish)
    #:start (make-forkexec-constructor '("xbanish" "-i Mod4"))
    #:stop (make-kill-destructor)))

(register-services xbanish)

(start xbanish)
