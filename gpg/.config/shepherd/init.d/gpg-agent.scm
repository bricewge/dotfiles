(define gpg-agent
  (make <service>
    #:docstring "Secret key management for GnuPG."
    #:provides '(gpg-agent)
    #:start (make-system-constructor
             "gpg-agent --daemon --pinentry-program "
             (getenv "HOME") "/.guix-profile/bin/pinentry-gtk-2")
    #:stop (make-system-destructor
            "gpg-connect-agent killagent /bye")))

(register-services gpg-agent)

(start gpg-agent)
