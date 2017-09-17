;;; packages.el --- 42 layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author:  <bricewge@noisette>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `42-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `42/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `42/pre-init-PACKAGE' and/or
;;   `42/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst 42born2code-packages
  '((c-42 :location local)))

(defun 42born2code/init-c-42 ()
    (require 'list)
    (require 'string)
    (require 'comments)
    (require 'header)
    )


(defun header-insert-once ()
  "Insert the header only one time"
  (interactive)
  (save-excursion
    (progn
      (goto-char 699)
      (if (not (looking-at-p "    ###   ########.fr    "))
          (header-insert)))))


;; 42 style
(c-add-style "42"
             '("linux"
               (indent-tabs-mode . t)
               (c-basic-offset . 4)
               (tab-width . 4)
               (tab-stop-list . (4 8 12))))

(push '(other . "42") c-default-style)

;;; packages.el ends here
