(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa")
(setq custom-safe-themes t)
(load-theme 'zenburn t)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (tool-bar-mode -1)
  (blink-cursor-mode -1))

(mouse-wheel-mode t)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq visible-bell t
      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      font-lock-verbose nil
      inhibit-startup-message t
      transient-mark-mode t
      delete-by-moving-to-trash t
      shift-select-mode nil
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 100
      ediff-window-setup-function 'ediff-setup-windows-plain
      ediff-split-window-function 'split-window-horizontally
      oddmuse-directory (concat dotfiles-dir "oddmuse")
      xterm-mouse-mode t
      save-place-file (concat dotfiles-dir "places"))

(minimal-mode)

(auto-compression-mode t)

(global-font-lock-mode t)

(if window-system
    (menu-bar-mode t)
    (menu-bar-mode -1)
    )

(require 'saveplace)
(setq-default save-place t)

(when (> emacs-major-version 21)
  (require 'flx-ido)
  (ido-mode t)
  (ido-everywhere 1)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point nil
        ido-use-faces nil
        ido-max-prospects 10))

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
(add-hook 'markdown-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-flyspell)

(defvar starter-kit-coding-hook nil
  "Hook that gets run on activation of any programming mode.")

(defalias 'yes-or-no-p 'y-or-n-p)
;; Seed the random-number generator
(random t)

(defun starter-kit-pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(\\(lambda\\>\\)"
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))

(require 'powerline)
(powerline-default-theme)

(delete 'try-expand-line hippie-expand-try-functions-list)
(delete 'try-expand-list hippie-expand-try-functions-list)

(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

(setq diff-switches "-u")

(message "Starter Kit Misc loaded.")

(add-hook 'org-mode-hook #'rainbow-delimiters-mode)
(add-hook 'ess-mode-hook #'rainbow-delimiters-mode)
