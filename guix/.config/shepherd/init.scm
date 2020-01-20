(use-modules (srfi srfi-2))

;; TODO add sxhkd service
;; TODO maybe add xsecurelock service
;; TODO fix zombies processes

(define* (strings->symbol #:rest r)
  "Return the symbol whose name is the concatenation of strings."
  (string->symbol (string-concatenate r)))

(define (make-polybar monitor)
  "Return a service that start a polybar on a specific MONITOR."
  (let ((sym (strings->symbol "polybar-" monitor)))
    (make <service>
      #:provides (list sym)
      #:start (make-forkexec-constructor
               '("polybar" "--reload" "bspwm")
               #:environment-variables
               ((lambda _
                  (setenv "MONITOR" monitor)
                  (environ))))
      #:stop (make-kill-destructor))))

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
            '("picom" "--config=/dev/null" "--experimental-backends"
              "--backend=xrender" "--vsync"))
   #:stop (make-kill-destructor)
   #:actions (make-actions
              (reload "Reload configuration."
                      (make-kill-destructor SIGUSR1))))
 (make <service>
   #:docstring "Automounter for removable media."
   #:provides '(udiskie auto-mount)
   #:start (make-forkexec-constructor '("udiskie"))
   #:stop (make-kill-destructor))

 ;; TODO stop should delete all bars
 ;; TODO start should be able to start multiple bars at once
 ;; TODO Handle multiple DISPLAY
 (make <service>
   #:docstring "Manage status bar."
   #:provides '(polybar bar)
   #:actions
   (make-actions
    (create "Create the status bar for MONITOR."
            (lambda* (running #:optional monitor)
              (and-let* (monitor
                         (service (make-polybar monitor)))
                (register-services service)
                (start service))))
    (delete "Delete the status bar for MONITOR."
            (lambda* (running #:optional monitor)
              (and-let* (monitor
                         (service (string-append "polybar-" monitor))
                         (running? (string->symbol service)))
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
                  emacs
                  udiskie))