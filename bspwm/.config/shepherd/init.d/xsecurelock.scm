(define xsecurelock
  (make <service>
    #:docstring "Screen locker for X11."
    #:provides '(xsecurelock xss-lock screen-locker)
    #:start
    (make-forkexec-constructor
     (list "xss-lock" "--transfer-sleep-lock" "--"
           "envfile"
           (string-append (getenv "HOME") "/.config/xsecurelock/theme.env") "--"
           "xsecurelock" "--"
           "xdotool" "key" "0")
     ;; TODO write an environment-file procedure
     ;; '("xss-lock" "--transfer-sleep-lock" "xsecurelock")
     ;; #:environment-variables
     ;; ((lambda _
     ;;    (environment-file (string-append
     ;;                       (getenv "HOME")
     ;;                       "/.config/xsecurelock/theme.env"))
     ;;    (environ)))
     )
    #:stop (make-kill-destructor)
    #:actions (make-actions
               (reset "Reset the screensaver, if the screen isn't locked yet."
                      (make-kill-destructor SIGHUP)))))

(register-services xsecurelock)

(start xsecurelock)
