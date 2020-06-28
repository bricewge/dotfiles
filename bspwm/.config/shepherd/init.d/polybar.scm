(use-modules ((srfi srfi-2) #:select (and-let*)))

;; TODO stop should delete all bars
;; TODO start should be able to start multiple bars at once
;; TODO Handle multiple DISPLAY

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

(define polybar
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

(register-services polybar)

(start polybar)
