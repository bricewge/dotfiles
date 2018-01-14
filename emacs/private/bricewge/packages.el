(defconst bricewge-packages
  '(org))

(defun bricewge/post-init-org ()
    ;;;;;;;;;;;;;;;;;;;;;;;
  ;; OLD CONFIGURATION ;;
    ;;;;;;;;;;;;;;;;;;;;;;;
  (setq org-modules '(org-habit
                      org-protocol
                      org-bibtex
                      org-crypt
                      ;; Modules not built-in
                      org-drill
                      org-bullets))

  ;; Use fancy UTF-8 bullets for the headings.
  (add-hook 'org-mode-hook 'org-bullets-mode)
  ;; Soft wrapped line at word boundary.
  (add-hook 'org-mode-hook 'visual-line-mode)

  ;; Display entities as UTF-8 characters.
  (setq org-pretty-entities t)

  ;; Show decent width image at startup.
  (setq org-image-actual-width '(600))
  (setq org-startup-with-inline-images t)

                                        ;(setq org-startup-with-latex-preview t)

                                        ; Set tags not to far from the headline because the font size reduce the space
                                        ; availaible
  (setq org-tags-column -63)

                                        ; Replace the "..." of folded headings by something more fancy
  (setq org-ellipsis "⤵")

  (setq org-drill-scope 'file) ; Other value: directory

  (setq org-directory "~/org")

  ;; Does not set a indentation level when moving heading
  (setq org-adapt-indentation nil)

  ;; Encrypt all entries before saving
  (eval-after-load 'org-crypt
    '(org-crypt-use-before-save-magic))
  (setq org-tags-exclude-from-inheritance (quote ("crypt")))
                                        ; GPG key to use for encryption: brice.wge@gmail.com
  (setq org-crypt-key "116F0F99")

  (setq org-entities-user '(
                                        ;			  ("space" "\\ " nil " " " " " " " ")
                            ("male" "\\male " t "&#9794" "[male symbol]" "[male symbol]" "♂")
                            ("female" "\\female " t "&#9792" "[female symbol]" "[female symbol]" "♀")
                            ("ohm" "\\ohm " t "&&Omega" "[Omega]" "[Omega]" "Ω")
                            ))

  (setq org-mobile-directory "~/ownCloud")
                                        ;(setq org-mobile-files "~/org")
  (setq org-mobile-inbox-for-pull "~/ownCloud/mobileorg.org")

  ;; Add exporter
  (setq org-export-backends '(ascii
                              latex
                              md
                              odt
                                        ; Not part of Emacs
                              koma-letter
                              ))

  (use-package htmlize
    :ensure t)

  (setq org-latex-pdf-process
        '("xelatex -interaction nonstopmode -output-directory %o %f"
          "biber %b"
          "xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"))

  (setq org-latex-default-packages-alist
        '(
          ("" "fontspec" t)
          ("" "polyglossia" t)
          ;; ("AUTO" "inputenc" t)
          ;; ("T1" "fontenc" t)
          ("" "fixltx2e" nil)
          ("" "graphicx" t)
          ("" "longtable" nil)
          ("" "float" nil)
          ("" "wrapfig" nil)
          ("" "rotating" nil)
          ("normalem" "ulem" t)
          ("" "amsmath" t)
          ("" "textcomp" t)
          ("" "marvosym" t)
          ("" "wasysym" t)
          ("" "amssymb" t)
          ("" "capt-of" nil)
          ("" "hyperref" nil)
          ("" "unicode-math" t) ;; Need to be after all math packages
          "\\tolerance=1000"
          "\\setdefaultlanguage{french}")
        )

  (setq org-latex-packages-alist
        '(("" "chemfig" t)
          ))

  (eval-after-load 'ox-latex
    '(add-to-list 'org-latex-classes
                  '("compte-rendu"
                    "\\documentclass[a4paper, 11pt, titlepage]{scrartcl}
     [DEFAULT-PACKAGES]
     [PACKAGES]
     \\usepackage{csquotes}
     \\usepackage[stylee, backendbiber]{biblatex}
     \\defaultfontfeatures{LigatureseX}
     \\setmainfont[Mappingex-text]{Linux Libertine O}
     \\setsansfont{Linux Biolinum O}
     \\setdefaultlanguage{french}
     [EXTRA]"
                    ("\\section{%s}" . "\\section*{%s}")
                    ("\\subsection{%s}" . "\\subsection*{%s}")
                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                    ("\\paragraph{%s}" . "\\paragraph*{%s}")
                    ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

  (eval-after-load 'ox-latex
    '(add-to-list 'org-latex-classes
                  '("letter"
                    "\\documentclass\[%
    DIV=14,
    fontsize=12pt,
    parskip=half,
    subject=titled,
    backaddress=false,
    fromalign=left,
    fromemail=true,
    fromphone=false\]\{scrlttr2\}
    \[DEFAULT-PACKAGES]
    \[PACKAGES]
    \[EXTRA]")))

  (setq org-koma-letter-default-class "letter")

  (defun org-latex-filter-textsuperscript (text backend info)
    "Export \"^string\" as \"textsuperscript{string}\"."
    (when (org-export-derived-backend-p backend 'latex)
      (replace-regexp-in-string "\\$\\^{\\\\text{\\([^\"]+?\\)}}\\$" "\\\\textsuperscript{\\1}" text)))

  (eval-after-load 'ox-latex
    '(add-to-list 'org-export-filter-superscript-functions
                  'org-latex-filter-textsuperscript))

  (defun org-latex-filter-textsubscript (text backend info)
    "Export \"^string\" as \"textsubscript{string}\"."
    (when (org-export-derived-backend-p backend 'latex)
      (replace-regexp-in-string "\\$_{\\\\text{\\([^\"]+?\\)}}\\$" "\\\\textsubscript{\\1}" text)))

  (eval-after-load 'ox-latex
    '(add-to-list 'org-export-filter-subscript-functions
                  'org-latex-filter-textsubscript))

  (setq org-latex-create-formula-image-program 'imagemagick)

  (setq org-format-latex-options
        '(:foreground default
                      :background default
                      :scale 1.5
                      :html-foreground "Black"
                      :html-background "Transparent"
                      :html-scale 1.0
                      :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))

  (setq org-latex-preview-ltxpng-directory
        (expand-file-name "org/ltxpng/" user-emacs-directory))

  (setq org-html-doctype "html5")

  (setq org-html-mathjax-template "<script type=\"text/x-mathjax-config\">\nMathJax.Hub.Config({\n  \"HTML-CSS\": {\nlinebreaks: { automatic: true } },\n         SVG: { linebreaks: { automatic: true } }\n});\n</script>\n<script type=\"text/javascript\" src=\"http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML\"></script>\n<script type=\"text/javascript\">\n<!--/*--><![CDATA[/*><!--*/\n    MathJax.Hub.Config({\n        // Only one of the two following lines, depending on user settings\n        // First allows browser-native MathML display, second forces HTML/CSS\n        :MMLYES: config: [\"MMLorHTML.js\"], jax: [\"input/TeX\"],\n        :MMLNO: jax: [\"input/TeX\", \"output/HTML-CSS\"],\n        extensions: [\"tex2jax.js\",\"TeX/AMSmath.js\",\"TeX/AMSsymbols.js\",\n                     \"TeX/noUndefined.js\", \"TeX/mhchem.js\"],\n        tex2jax: {\n            inlineMath: [ [\"\\\\(\",\"\\\\)\"] ],\n            displayMath: [ ['$$','$$'], [\"\\\\[\",\"\\\\]\"], [\"\\\\begin{displaymath}\",\"\\\\end{displaymath}\"] ],\n            skipTags: [\"script\",\"noscript\",\"style\",\"textarea\",\"pre\",\"code\"],\n            ignoreClass: \"tex2jax_ignore\",\n            processEscapes: false,\n            processEnvironments: true,\n            preview: \"TeX\"\n        },\n        showProcessingMessages: true,\n        displayAlign: \"%ALIGN\",\n        displayIndent: \"%INDENT\",\n\n        \"HTML-CSS\": {\n             scale: %SCALE,\n             availableFonts: [\"STIX\",\"TeX\"],\n             preferredFont: \"TeX\",\n             webFont: \"TeX\",\n             imageFont: \"TeX\",\n             showMathMenu: true,\n        },\n        MMLorHTML: {\n             prefer: {\n                 MSIE:    \"MML\",\n                 Firefox: \"MML\",\n                 Opera:   \"HTML\",\n                 other:   \"HTML\"\n             }\n        }\n    });\n/*]]>*///-->\n</script>")

  ;; (use-package ox-ioslide
  ;;   :ensure t
  ;;   ;; :requires (makey)
  ;;   :config (require 'ox-ioslide-helper))

  ;; (use-package ox-twbs
  ;;   :ensure t
  ;;   :config
  ;;   (setq org-twbs-mathjax-template org-html-mathjax-template))

  (setq org-publish-use-timestamps-flag nil)

  (setq org-export-allow-bind-keywords t)

                                        ; Inline images in HTML instead of producting links to the image
  (setq org-html-inline-images t)
  (setq org-html-head-include-default-style nil)
                                        ; Do not generate internal css formatting for HTML exports
  (setq org-html-htmlize-output-type 'css)

  (defvar bwge-uni-base "~/Dropbox/Université/"
    "Path to the uni directory.")
  (defvar bwge-uni-htmlroot "~/repos/uni.bricewge.fr"
    "Where to export the uni website.")

  ;; (add-to-list 'org-publish-project-alist
  ;;              '("uni" :components ("uni-html" "uni-source" "uni-extra"))
  ;;              t)

  ;; (add-to-list 'org-publish-project-alist
  ;;              `("uni-html"
  ;;                :base-directory ,bwge-uni-base
  ;;                :publishing-directory ,bwge-uni-htmlroot
  ;;                :exclude "\\(Fiches\\|TP\\|TD\\|S[0-9].org\\)"
  ;;                :recursive t
  ;;                :base-extension "org"
  ;;                :publishing-function org-html-publish-to-html
  ;;                :section-numbers nil
  ;;                :language "fr"
  ;;                :headline-levels 6
  ;;                :with-toc nil
  ;;                :html-postamble nil
  ;;                :html-head  "<link rel=\"stylesheet\" href=\"/home/bricewge/repos/uni.bricewge.fr/static/normalize.css\" type=\"text/css\"/>\n<link rel=\"stylesheet\" href=\"/home/bricewge/repos/uni.bricewge.fr/static/style.css\" type=\"text/css\"/>\n<link href='http://fonts.googleapis.com/css?family=Cardo:400,400italic,700&subset=latin,latin-ext' rel='stylesheet' type='text/css'>\n"
  ;;                :html-link-home "/index.html"
  ;;                :html-doctype "html5"
  ;;                :html-html5-fancy t
  ;;                :auto-sitemap t
  ;;                :sitemap-filename "/index.org"
  ;;                :sitemap-title "Notes de cours")
  ;;              t)

  ;; (add-to-list 'org-publish-project-alist
  ;;              `("uni-extra"
  ;;                :base-directory ,bwge-uni-base
  ;;                :publishing-directory ,bwge-uni-htmlroot
  ;;                :exclude "\\(Fiches\\|TP\\|TD\\|S[0-9].org\\)"
  ;;                :base-extension "css\\|png\\|svg"
  ;;                :publishing-function org-publish-attachment
  ;;                :recursive t)
  ;;              t)

  ;; (add-to-list 'org-publish-project-alist
  ;;              `("uni-source"
  ;;                :base-directory ,bwge-uni-base
  ;;                :publishing-directory ,bwge-uni-htmlroot
  ;;                :exclude "\\(Fiches\\|TP\\|TD\\|S[0-9].org\\)"
  ;;                :base-extension "org"
  ;;                :publishing-function org-org-publish-to-org;org-publish-attachment
  ;;                :recursive t
  ;;                :htmlized-source t
  ;;                :plain-source t)
  ;;              t)

  ;; (add-to-list 'org-publish-project-alist
  ;;              '("pelican" :components ("pelican-md" "pelican-extra"))
  ;;              t)

  ;; (add-to-list 'org-publish-project-alist
  ;;              '("pelican-md"
  ;;                :base-directory "~/Pelican"
  ;;                :publishing-directory "~/git/bricewge.fr/content/Blog"
  ;;                :recursive t
  ;;                :base-extension "org"
  ;;                :publishing-function org-md-publish-to-md
  ;;                :with-toc nil
  ;;                :section-numbers nil
  ;;                :with-tags nil
  ;;                :with-timestamps nil)
  ;;              t)

  ;; (add-to-list 'org-publish-project-alist
  ;;              '("pelican-extra"
  ;;                :base-directory "~/Pelican/Images"
  ;;                :publishing-directory "~/git/bricewge.fr/content/images"
  ;;                :recursive t
  ;;                :base-extension "css\\|png\\|svg"
  ;;                :publishing-function org-publish-attachment)
  ;;              t)

  ;; (defvar bwge-blog-base "~/org/blog"
  ;;   "Path to the blog directory.")
  ;; (defvar bwge-blog-htmlroot "~/repos/bricewge.fr"
  ;;   "Where to export the blog website.")

  ;; (add-to-list 'org-publish-project-alist
  ;;              '("blog" :components ("blog-content" "blog-static"))
  ;;              t)

  ;; (add-to-list 'org-publish-project-alist
  ;;              `("blog-content"
  ;;                :base-directory ,bwge-blog-base
  ;;                :base-extension "org"
  ;;                :publishing-directory ,bwge-blog-htmlroot
  ;;                :html-extension "html"
  ;;                :publishing-function org-html-publish-to-html
  ;;                :auto-sitemap t
  ;;                :sitemap-filename "archive.org"
  ;;                :sitemap-title "Archive"
  ;;                :sitemap-sort-files anti-chronologically
  ;;                :sitemap-style list
  ;;                :makeindex t
  ;;                :recursive t
  ;;                :section-numbers nil
  ;;                :with-toc nil
  ;;                :with-latex t
  ;;                :with-author nil
  ;;                :with-creator nil
  ;;                :html-doctype "html5"
  ;;                :html-html5-fancy t
  ;;                :html-head-include-default-style nil
  ;;                :html-head-include-scripts nil
  ;;                :html-preamble org-mode-blog-preamble
  ;;                :html-postamble nil
  ;;                :html-head  "<link rel=\"stylesheet\" href=\"static/style.css\" type=\"text/css\"/>\n")

  ;;              t)

  ;; (add-to-list 'org-publish-project-alist
  ;;              `("blog-rss"
  ;;                :base-directory ,bwge-blog-base
  ;;                :base-extension "org"
  ;;                :publishing-directory ,bwge-blog-htmlroot
  ;;                :publishing-function org-rss-publish-to-rss
  ;;                :html-link-home "https://bricewge.fr/"
  ;;                :html-link-use-abs-url t)
  ;;              t)

  ;; (add-to-list 'org-publish-project-alist
  ;;              `("blog-static"
  ;;                :base-directory ,bwge-blog-base
  ;;                :publishing-directory ,bwge-blog-htmlroot
  ;;                :base-extension "css\\|js\\|png\\|jpg\\|gif\\|ico"
  ;;                :publishing-directory org-mode-blog-publishing-directory
  ;;                :recursive t
  ;;                :publishing-function org-publish-attachment)
  ;;              t)

  (defun org-mode-blog-preamble (options)
    "The function that creates the preamble (sidebar) for the blog.
OPTIONS contains the property list from the org-mode export."
    (let ((base-directory (plist-get options :base-directory)))
      (org-babel-with-temp-filebuffer (expand-file-name "html/preamble.html" base-directory) (buffer-string))))

  ;; Changing a task state is done with C-c C-t KEY
  (setq org-use-fast-todo-selection t)
  ;; Change a todo state with S- rigth and left arrows
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)

  ;; Set task states sequences as http://doc.norang.ca/org-mode.html#TodoKeywordTaskStates
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))
  ;; Set the faces of the todo keywords
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "#dc322f" :weight bold)
                ("NEXT" :foreground "#268bd2" :weight bold)
                ("DONE" :foreground "#859900" :weight bold)
                ("WAITING" :foreground "#cb4b16" :weight bold)
                ("HOLD" :foreground "#d33682" :weight bold)
                ("CANCELLED" :foreground "#859900" :weight bold)
                )))

  (setq org-log-done (quote time)) ;; Log the time when a task is marked as DONE
  (setq org-log-into-drawer t)  ;; Keep the log info in the :LOGBOOK: drawer
                                        ; Log the change when rescheduling
  (setq org-log-reschedule 'note)

  (use-package org-checklist)

  (use-package org-agenda
    :bind (:map org-agenda-mode-map
                ("Y" . org-agenda-todo-yesterday))
    :config
    (setq org-agenda-start-on-weekday nil)
    )

  (when (daemonp)
    (run-at-time "4:30am" (* 3600 24) 'org-agenda nil "a"))

  (setq org-habit-graph-column 85
        org-habit-show-habits-only-for-today nil
        org-habit-show-done-always-green t
        org-log-repeat 'time
        org-habit-show-habits nil)

  (setq org-default-notes-file (concat org-directory "/inbox.org"))

  ;; Needed to add others items to the list, prefer using "add-to-list".
  (setq org-capture-templates '())

  (defadvice org-capture-finalize
      (after delete-capture-frame activate)
    "Advise capture-finalize to close the frame"
    (if (equal "capture" (frame-parameter nil 'name))
        (delete-frame)))

  (defadvice org-capture-select-template (around delete-capture-frame activate)
    "Advise org-capture-select-template to close the frame on abort"
    (unless (ignore-errors ad-do-it t)
      (setq ad-return-value "q"))
    (if (and
         (equal "q" ad-return-value)
         (equal "capture" (frame-parameter nil 'name)))
        (delete-frame)))

  ;; https://cestlaz.github.io/posts/using-emacs-24-capture-2/
  (use-package noflet
    :ensure t )
  (defun make-capture-frame ()
    "Create a new frame and run org-capture."
    (interactive)
    ;; (make-frame '((name . "capture")))
    (select-frame-by-name "capture")
    (delete-other-windows)
    (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
            (org-capture)))

  (add-to-list 'org-capture-templates
               '("w" "Journal de musculation")
               t)

  (add-to-list 'org-capture-templates
               '("w2"
                 "II deuxième niveau"
                 entry
                 (file+headline "~/org/lafay.org" "Niveau II")
                 (file "~/.emacs.d/org/template/lafay-2.tpl.org")
                 :clock-in t :clock-resume t :unnarrowed t :empty-lines 1)
               t)

  (add-to-list 'org-capture-templates
               '("w3"
                 "III troisième niveau"
                 entry
                 (file+headline "~/org/lafay.org" "Niveau III")
                 (file "~/.emacs.d/org/template/lafay-3.tpl.org")
                 :clock-in t :clock-resume t :unnarrowed t :empty-lines 1)
               t)

  (add-to-list 'org-capture-templates
               '("j"
                 "Journal personnel"
                 plain
                 (file+datetree "~/org/journal.org.gpg")
                 "%U\n%?"
                 :kill-buffer t)
               t)

  (add-to-list 'org-capture-templates
               '("t"
                 "TODO"
                 entry
                 (file "~/org/inbox.org")
                 "* TODO %?\n%U\n"
                 :clock-in t :clock-resume t)
               t)

  (add-to-list 'org-capture-templates
               '("n"
                 "Note"
                 entry
                 (file "~/org/inbox.org")
                 "* %? :NOTE:\n%U\n"
                 )
               t)

  (add-to-list 'org-capture-templates
               '("a"
                 "Achat"
                 checkitem
                 (file+olp "~/org/listes.org" "Achats" "Besoins")
                 )
               t)

  (defun bwge/capture-blog-draft-file (path)
    (let ((name (read-string "Name: ")))
      (expand-file-name (format "%s-%s.org"
                                (format-time-string "%Y-%m-%d")
                                name) path)))

  (add-to-list 'org-capture-templates
               '("p"
                 "Billet de blog"
                 plain
                 (file (bwge/capture-blog-draft-file "~/projet/blog.bricewge.fr/posts"))
                 (file "~/.emacs.d/org/template/blog.tpl.org")
                 )
               t)

  (add-to-list 'org-capture-templates
               '("b"
                 "Entrée bibliographique"
                 entry
                 (file "~/org/biblio.org")
                 (file "~/.emacs.d/org/template/bibliography.tpl.org")
                 )
               t)

  (setq org-attach-directory "attachment/")

  (setq org-refile-targets  '((org-agenda-files :maxlevel . 6)))

  (setq org-archive-location (concat org-directory "/archive/%s_archive::* Archived Tasks"))
  (setq org-archive-mark-done nil)
  (setq org-archive-reversed-order t)

  (setq org-src-fontify-natively t)
  (setq org-src-window-setup 'current-window)
  )
