(define udiskie
  (make <service>
   #:docstring "Automounter for removable media."
   #:provides '(udiskie auto-mount)
   #:start (make-forkexec-constructor '("udiskie"))
   #:stop (make-kill-destructor)))

(register-services udiskie)

(start udiskie)
