(add-to-list 'load-path "~/.emacs.d/elpa/magit/lisp")
(require 'magit)

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/elpa/magit/Documentation/"))


(setq insert-directory-program (executable-find "gls"))

(setq sentence-end-double-space nil)

(add-hook 'latex-mode-hook 
          (lambda ()
            (set-face-attribute 'font-latex-sectioning-5-face nil :inherit nil :foreground "#b58900")
            (set-face-attribute 'font-latex-sectioning-0-face nil :height 3)
            (set-face-attribute 'font-latex-sectioning-1-face nil :height 2)
            (set-face-attribute 'font-latex-sectioning-2-face nil :height 1.5)
            (set-face-attribute 'font-latex-sectioning-3-face nil :height 1.2)
            (set-face-attribute 'font-latex-sectioning-4-face nil :height 1.0)))

 (add-hook 'org-mode-hook 
           (lambda ()
             (set-face-attribute 'org-level-1 nil :height 1.5)
             (set-face-attribute 'org-level-2 nil :height 1.2)
             (set-face-attribute 'org-level-3 nil :height 1.1)
             (set-face-attribute 'org-level-4 nil :height 1.1)
             (set-face-attribute 'org-level-5 nil :height 1.1)))

(defun fullscreen (&optional f)
  (interactive)
  (set-frame-parameter f 'fullscreen
                       (if (frame-parameter f 'fullscreen) nil 'fullboth)))
(global-set-key (kbd "C-c f") 'fullscreen)
(add-hook 'after-make-frame-functions 'fullscreen)

(load "dired-x")

(eval-after-load "dired"
'(progn
   (define-key dired-mode-map "F" 'my-dired-find-file)
   (defun my-dired-find-file (&optional arg)
     "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
     (interactive "P")
     (let* ((fn-list (dired-get-marked-files nil arg)))
       (mapc 'find-file fn-list)))))

(require 'stripe-buffer)
(add-hook 'org-mode-hook 'org-table-stripes-enable)
(add-hook 'dired-mode-hook 'stripe-listify-buffer)

(setq compilation-scroll-output t)

(setq TeX-open-quote "“")
(setq TeX-close-quote "”")

;; Synctex with Skim
  (add-hook 'TeX-mode-hook
  (lambda ()
  (add-to-list 'TeX-output-view-style
  '("^pdf$" "."
   "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")))
   )

(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

  ;; Make emacs aware of multi-file projects
  ;; (setq-default TeX-master nil)

  ;; Auto-raise Emacs on activation (from Skim, usually)
  (defun raise-emacs-on-aqua()
  (shell-command "osascript -e 'tell application \"Emacs\" to activate' &"))
  (add-hook 'server-switch-hook 'raise-emacs-on-aqua)

;; Make RefTex able to find my local bib files
(setq reftex-bibpath-environment-variables
'("/Users/kjhealy/Library/texmf/bibtex/bib"))

;; Default bibliography
(setq reftex-default-bibliography
'("/Users/kjhealy/Documents/bibs/socbib.bib"))

(fset 'run-vc-then-xelatex
[?\M-! ?v ?c return ?\C-c ?\C-c return])
(global-set-key (kbd "C-c c") 'run-vc-then-xelatex);; Run the VC command before running xelatex
(fset 'run-vc-then-xelatex
[?\M-! ?v ?c return ?\C-c ?\C-c return])
(global-set-key (kbd "C-c c") 'run-vc-then-xelatex)

(global-set-key (kbd "C-c v")
                    (lambda ()
                      (interactive)
                      (shell-command "vc")))

(load "pandoc-mode")
(add-hook 'markdown-mode-hook 'pandoc-mode)
(add-hook 'TeX-mode-hook 'pandoc-mode)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
(global-set-key (kbd "C-c p") 'pandoc-main-hydra/body)

(setq ibuffer-saved-filter-groups
    '(("home"
       ("emacs-config" (or (filename . ".emacs.d")
			   (filename . "emacs-config")))
       ("Org" (or (mode . org-mode)
		  (filename . "OrgMode")))
       ("Web Dev" (or (mode . html-mode)
		      (mode . css-mode)))
       ("Magit" (name . "\*magit"))
       ("ESS" (mode . ess-mode))
       ("LaTeX" (mode . latex-mode))
       ("Help" (or (name . "\*Help\*")
		   (name . "\*Apropos\*")
		   (name . "\*info\*"))))))

      (add-hook 'ibuffer-mode-hook 
	           '(lambda ()
	           (ibuffer-switch-to-saved-filter-groups "home")))
     (setq ibuffer-show-empty-filter-groups nil)                     
     (setq ibuffer-expert t)
     (add-hook 'ibuffer-mode-hook 
     '(lambda ()
     (ibuffer-auto-mode 1)
     (ibuffer-switch-to-saved-filter-groups "home")))

(setq org-archive-location "~/Dropbox/Org/archive.org::From %s")

;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/Org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")
;; Set to the files (or directory of files) you want sync'd
(setq org-agenda-files (quote ("~/Dropbox/Org")))
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/Org/from-mobile.org")

(setq org-src-window-setup 'current-window)

;; Choose either listings or minted for exporting source code blocks.
  ;; Using minted (as here) requires pygments be installed. To use the
  ;; default listings package instead, use
  ;; (setq org-latex-listings t)
  ;; and change references to "minted" below to "listings"
  (setq org-latex-listings 'minted)

  ;; default settings for minted code blocks.
  ;; bg will need to be defined in the preamble of your document. It's defined in  org-preamble-xelatex.sty below.
  (setq org-latex-minted-options
        '(;("frame" "single")
          ("bgcolor" "bg") 
          ("fontsize" "\\small")
          ))

;; turn off the default toc behavior; deal with it properly in headers to files.
(defun org-latex-no-toc (depth)  
  (when depth
      (format "%% Org-mode is exporting headings to %s levels.\n"
              depth)))
(setq org-latex-format-toc-function 'org-latex-no-toc)

;; note the insertion of the \input statement for the vc information 
(add-to-list 'org-latex-classes
               '("memarticle"
                 "\\documentclass[11pt,oneside,article]{memoir}\n\\input{vc} % vc package"
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
               '("membook"
                 "\\documentclass[11pt,oneside]{memoir}\n\\input{vc} % vc package"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

;; LaTeX compilation command. For orgmode docs we just always use xelatex for convenience.
;; You can change it to pdflatex if you like, just remember to make the adjustments to the packages-alist below.
(setq org-latex-pdf-process '("latexmk -pdflatex='xelatex -synctex=1 --shell-escape' -pdf %f"))

;; Default packages included in the tex file. As before, org-preamble-xelatex is part of latex-custom-kjh.
;; There's org-preamble-pdflatex as well, if you wish to use that instead.
(setq org-latex-default-packages-alist nil)     
(setq org-latex-packages-alist
        '(("minted" "org-preamble-xelatex" t)
          ("" "graphicx" t)
          ("" "longtable" nil)
          ("" "float" )))

(org-add-link-type "ebib" 'ebib)

 (org-add-link-type 
   "cite" 'ebib
   (lambda (path desc format)
     (cond
      ((eq format 'latex)
       (if (or (not desc) (equal 0 (search "cite:" desc)))
             (format "\\cite{%s}" path)
             (format "\\cite[%s]{%s}" desc path)
             )))))

 (org-add-link-type 
   "parencite" 'ebib
   (lambda (path desc format)
     (cond
      ((eq format 'latex)
       (if (or (not desc) (equal 0 (search "parencite:" desc)))
             (format "\\parencite{%s}" path)
             (format "\\parencite[%s]{%s}" desc path)
)))))

(org-add-link-type 
   "textcite" 'ebib
   (lambda (path desc format)
     (cond
      ((eq format 'latex)
       (if (or (not desc) (equal 0 (search "textcite:" desc)))
             (format "\\textcite{%s}" path)
             (format "\\textcite[%s]{%s}" desc path)
)))))

(org-add-link-type 
   "autocite" 'ebib
   (lambda (path desc format)
     (cond
      ((eq format 'latex)
       (if (or (not desc) (equal 0 (search "autocite:" desc)))
             (format "\\autocite{%s}" path)
         (format "\\autocite[%s]{%s}" desc path)
)))))

(org-add-link-type 
 "footcite" 'ebib
 (lambda (path desc format)
   (cond
    ((eq format 'latex)
     (if (or (not desc) (equal 0 (search "footcite:" desc)))
         (format "\\footcite{%s}" path)
       (format "\\footcite[%s]{%s}" desc path)
       )))))

(org-add-link-type 
 "fullcite" 'ebib
 (lambda (path desc format)
   (cond
    ((eq format 'latex)
     (if (or (not desc) (equal 0 (search "fullcite:" desc)))
         (format "\\fullcite{%s}" path)
       (format "\\fullcite[%s]{%s}" desc path)
       )))))

(org-add-link-type 
 "citetitle" 'ebib
 (lambda (path desc format)
   (cond
    ((eq format 'latex)
     (if (or (not desc) (equal 0 (search "citetitle:" desc)))
         (format "\\citetitle{%s}" path)
       (format "\\citetitle[%s]{%s}" desc path)
       )))))

(org-add-link-type 
 "citetitles" 'ebib
 (lambda (path desc format)
   (cond
    ((eq format 'latex)
     (if (or (not desc) (equal 0 (search "citetitles:" desc)))
         (format "\\citetitles{%s}" path)
       (format "\\citetitles[%s]{%s}" desc path)
       )))))

(org-add-link-type 
   "headlessfullcite" 'ebib
   (lambda (path desc format)
     (cond
      ((eq format 'latex)
       (if (or (not desc) (equal 0 (search "headlessfullcite:" desc)))
             (format "\\headlessfullcite{%s}" path)
             (format "\\headlessfullcite[%s]{%s}" desc path)
)))))

(setq org-publish-project-alist
       '(("org"
          :base-directory "~/.emacs.d/"
          :publishing-directory "~/Documents/websites/esk/"
          :publishing-function org-html-publish-to-html
          :auto-sitemap t            
          :sitemap-filename "index.org"
          :sitemap-title "Emacs Starter Kit for the Social Sciences: Documentation"
          :section-numbers t
          :table-of-contents t
          :html-head "<link rel=\"stylesheet\"
                 href=\"http://kieranhealy.org/css/org.css\"
                 type=\"text/css\"/>"            )))

(setq org-html-postamble nil)

;; connect to irc on invocation but don't autojoin any channels
(require 'rcirc)
(add-to-list 'rcirc-server-alist
                     '("irc.freenode.net"))

;; minimize fringe
(setq-default indicate-empty-lines nil)

;; Add keybindings for commenting regions of text
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-'") 'comment-or-uncomment-region)

;; Base dir
(cd "~/")

;; custom variables kludge. Why can't I get these to work via setq?
(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(LaTeX-XeTeX-command "xelatex -synctex=1")
'(TeX-engine (quote xetex))
;; '(TeX-view-program-list (quote (("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b"))))
;; '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "Skim") (output-html "xdg-open"))))
'(blink-cursor-mode nil)
'(text-mode-hook (quote (text-mode-hook-identify)))
)

(message "Starter Kit User File loaded.")
