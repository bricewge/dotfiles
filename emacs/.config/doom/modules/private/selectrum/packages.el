;; -*- no-byte-compile: t; -*-
;;; private/selectrum/packages.el

(package! selectrum)
(package! marginalia)
(package! consult)
(package! consult-selectrum)
(package! embark)


(when (featurep! +prescient)
  (package! prescient)
  (package! selectrum-prescient))

(when (featurep! +childframe)
  (package! mini-frame))
