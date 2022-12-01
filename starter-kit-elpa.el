
(require 'package)
(setq package-archives '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
                         ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")
                         ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
;(package-initialize)

(defvar starter-kit-packages (list
                              'adaptive-wrap
                              'ag
                              'anti-zenburn-theme
                              'org-ac
                              'browse-kill-ring
                              'company
                              'company-auctex
                              'company-math
                              'company-web
                              'company-statistics
                              'company-quickhelp
                              'css-mode
                              'csv-mode
                              'ein
                              'elpy
                              'emmet-mode
                              'exec-path-from-shell
                              'expand-region
                              'flycheck
                              'flx-ido
                              'idle-highlight-mode
                              'latex-pretty-symbols
                              'magit
                              'markdown-mode
                              'maxframe
                              'multiple-cursors
                              'pandoc-mode
                              'polymode
                              'poly-R
                              'poly-markdown
                              'pos-tip
                              'powerline
                              'rainbow-delimiters
                              'smartparens
                              'smex
                              'solarized-theme
                              'textmate
                              'visual-regexp
                              'yaml-mode
                              'yasnippet
                              'zenburn-theme
                              'auctex
                              'ess
                              'r-autoyas
                              )
  "Libraries that should be installed by default.")

(defun starter-kit-elpa-install ()
  "Install all starter-kit packages that aren't installed."
  (interactive)
  (dolist (package starter-kit-packages)
    (unless (or (member package package-activated-list)
                (functionp package))
      (message "Installing %s" (symbol-name package))
      (package-install package))))

(defun esk-online? ()
  "See if we're online.

Windows does not have the network-interface-list function, so we
just have to assume it's online."
  ;; TODO how could this work on Windows?
  (if (and (functionp 'network-interface-list)
           (network-interface-list))
      (some (lambda (iface) (unless (equal "lo" (car iface))
                         (member 'up (first (last (network-interface-info
                                                   (car iface)))))))
            (network-interface-list))
    t))

(when (esk-online?)
  (unless package-archive-contents (package-refresh-contents))
  (starter-kit-elpa-install))

(when (memq window-system '(mac ns))
(exec-path-from-shell-initialize))

(message "Starter Kit ELPA loaded.")
