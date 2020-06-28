(use-modules (shepherd service)
             ((ice-9 ftw) #:select (scandir)))

;; TODO add sxhkd service
;; TODO add tmux
;; TODO get rid off zombies processes

;; Load all the files in the directory 'init.d' with a suffix '.scm'.
(let* ((xdg-config (getenv "XDG_CONFIG_HOME"))
       (config-dir (string-append
                    (if xdg-config
                        (string-append xdg-config "/shepherd")
                        (dirname (current-filename)))
                    "/init.d")))
  (for-each
   (lambda (file)
     (load (string-append config-dir "/" file)))
   (scandir config-dir
            (lambda (file)
              (string-suffix? ".scm" file)))))

;; Send shepherd into the background
(action 'shepherd 'daemonize)
