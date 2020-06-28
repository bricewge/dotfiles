(use-modules (srfi srfi-2))

;; TODO add sxhkd service
;; TODO add tmux
;; TODO get rid off zombies processes

(define* (strings->symbol #:rest r)
  "Return the symbol whose name is the concatenation of strings."
  (string->symbol (string-concatenate r)))

(define (make-polybar monitor)
  "Return a service that start a polybar on a specific MONITOR."
  (let ((name (strings->symbol "polybar-" monitor)))
    (make <service>
      #:provides (list name)
      #:start (make-forkexec-constructor
               '("polybar" "--reload" "bspwm")
               #:environment-variables
               ((lambda _
                  (setenv "MONITOR" monitor)
                  (environ))))
      #:stop (make-kill-destructor))))

(define (polybar-register monitor)
  "Register a polybar service for MONITOR."
  (and-let* ((service (make-polybar monitor))
             (registered? (null? (lookup-services service))))
    (register-services service)))

(register-services
 (make <service>
   #:docstring "Emacs daemon."
   #:provides '(emacs)
   #:start (make-forkexec-constructor
            '("emacs" "--fg-daemon"))
   #:stop (make-system-destructor
           "emacsclient --eval '(kill-emacs)'"))

 (make <service>
   #:docstring "Secret key management for GnuPG."
   #:provides '(gpg-agent)
   #:start (make-system-constructor
            "gpg-agent --daemon --pinentry-program "
            (getenv "HOME") "/.guix-profile/bin/pinentry-gtk-2")
   #:stop (make-system-destructor
           "gpg-connect-agent killagent /bye"))

 (make <service>
   #:docstring "Hides idle cursor."
   #:provides '(xbanish)
   #:start (make-forkexec-constructor '("xbanish" "-i Mod4"))
   #:stop (make-kill-destructor))

 (make <service>
   #:doctring "Adjust the color temperature of the screen."
   #:provides '(redshift)
   #:start (make-forkexec-constructor '("redshift" "-P"))
   #:stop (make-kill-destructor SIGKILL))

 (make <service>
   #:docstring "Compositor for X11."
   #:provides '(picom compositor)
   #:start (make-forkexec-constructor
            '("picom" "--experimental-backends"))
   #:stop (make-kill-destructor)
   #:actions (make-actions
              (reload "Reload configuration."
                      (make-kill-destructor SIGUSR1))))

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
                     (make-kill-destructor SIGHUP))))

 (make <service>
   #:docstring "Automounter for removable media."
   #:provides '(udiskie auto-mount)
   #:start (make-forkexec-constructor '("udiskie"))
   #:stop (make-kill-destructor))

 (make <service>
   #:docstring "Bluetooth MPRIS proxy."
   #:provides '(mpris-proxy)
   #:start (make-forkexec-constructor '("mpris-proxy"))
   #:stop (make-kill-destructor))

 ;; TODO stop should delete all bars
 ;; TODO start should be able to start multiple bars at once
 ;; TODO Handle multiple DISPLAY
 (make <service>
   #:docstring "Manage status bar."
   #:provides '(polybar status-bar)
   #:actions
   ;; TODO Refactor actions to pass around the service name istead of
   ;; derivating it from the monitor name in sperate functions
   (make-actions
    (create "Register and start a status bar for MONITOR."
            (lambda* (running #:optional monitor)
              (polybar-register monitor)
              (start (strings->symbol "polybar-" monitor))))
    (delete "Delete the status bar for MONITOR."
            (lambda* (running #:optional monitor)
              (and-let* (monitor
                         (service (string-append "polybar-" monitor)))
                (action 'root 'unload service)))))))

;; Send shepherd into the background
(action 'shepherd 'daemonize)

;; Services to start when shepherd starts:
;; Add the name of each service that should be started to the list
;; below passed to 'for-each'.
(for-each start '(xbanish
                  redshift
                  polybar
                  picom
                  gpg-agent
                  xss-lock
                  emacs
                  udiskie
                  mpris-proxy))
