;; Autocomplete for orgmode
;; (require 'org-ac)
;; (org-ac/config-default)

;; Markdown exporter
(require 'ox-md)

(setq org-completion-use-ido t)
;; (require 'org-special-blocks)
;; (if window-system (require 'org-mouse))

;; Compatibility with WindMove
;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
;; (if window-system (require 'org-mouse))

;;  (defun yas/org-very-safe-expand ()
;;    (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(defun yas-org-very-safe-expand ()
  (let ((yas-fallback-behavior 'return-nil))
    (and (fboundp 'yas-expand) (yas-expand))))

(add-hook 'org-mode-hook
          (lambda ()
            (add-to-list 'org-tab-first-hook
                         'yas-org-very-safe-expand)
            ))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\M-\C-n" 'outline-next-visible-heading)
            (local-set-key "\M-\C-p" 'outline-previous-visible-heading)
            (local-set-key "\M-\C-u" 'outline-up-heading)
            ;; table
            (local-set-key "\M-\C-w" 'org-table-copy-region)
            (local-set-key "\M-\C-y" 'org-table-paste-rectangle)
            (local-set-key "\M-\C-l" 'org-table-sort-lines)
            ;; display images
            (local-set-key "\M-I" 'org-toggle-iimage-in-org)
            ;; yasnippet (using the new org-cycle hooks)
            ;;(make-variable-buffer-local 'yas/trigger-key)
            ;;(setq yas/trigger-key [tab])
            ;;(add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            ;;(define-key yas/keymap [tab] 'yas/next-field)
            ))

(setq org-use-speed-commands t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
 (shell . t)))

(add-to-list 'org-src-lang-modes
             '("r" . ess-mode))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(setq org-confirm-babel-evaluate nil)

(unless (boundp 'Info-directory-list)
  (setq Info-directory-list Info-default-directory-list))
(setq Info-directory-list
      (cons (expand-file-name
             "doc"
             (expand-file-name
              "org"
              (expand-file-name "src" dotfiles-dir)))
            Info-directory-list))

(message "Starter Kit Org loaded.")
