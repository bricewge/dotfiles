;; -*- no-byte-compile: t; -*-
;;; private/ebook/packages.el

(package! nov)
(package! justify-kp
  :recipe (:host github
                 :repo "Fuco1/justify-kp"
                 :fork (:host github
                              :repo "terlar/justify-kp"
                              :branch "updates")
                 :files ("justify-kp.el")
                 ))
(package! visual-fill-column)

