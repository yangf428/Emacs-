(require 'ess-site)

;; smart-underscore and ess-smart-S-assign-key have been removed in ESS 19.04 so we need to set them up manually
  (define-key ess-r-mode-map "_" #'ess-insert-assign)
  (define-key inferior-ess-r-mode-map "_" #'ess-insert-assign)

(add-hook 'ess-mode-hook 'run-starter-kit-coding-hook)
  (add-hook 'ess-R-post-run-hook 'smartparens-mode)

(setq ess-swv-processor "'knitr")

(require 'poly-R)
(require 'poly-markdown)

(setq ess-ask-for-ess-directory nil)
  (setq ess-local-process-name "R")
  (setq ansi-color-for-comint-mode 'filter)
  (setq comint-scroll-to-bottom-on-input t)
  (setq comint-scroll-to-bottom-on-output t)
  (setq comint-move-point-for-output t)
  (defun my-ess-start-R ()
    (interactive)
    (unless (mapcar (lambda (s) (string-match "*R" (buffer-name s))) (buffer-list))
;;    (unless (string-match "*R" (mapcar (function buffer-name) (buffer-list)))
      (progn
	(delete-other-windows)
	(setq w1 (selected-window))
	(setq w1name (buffer-name))
	(setq w2 (split-window w1 nil t))
	(R)
	(set-window-buffer w2 "*R*")
	(set-window-buffer w1 w1name))))
  (defun my-ess-eval ()
    (interactive)
    (my-ess-start-R)
    (if (and transient-mark-mode mark-active)
	(call-interactively 'ess-eval-region)
      (call-interactively 'ess-eval-line-and-step)))
  (add-hook 'ess-mode-hook
	    '(lambda()
	       (local-set-key [(shift return)] 'my-ess-eval)))
  (add-hook 'inferior-ess-mode-hook
	    '(lambda()
	       (local-set-key [C-up] 'comint-previous-input)
	       (local-set-key [C-down] 'comint-next-input)))
 (add-hook 'Rnw-mode-hook 
          '(lambda() 
             (local-set-key [(shift return)] 'my-ess-eval))) 
  (require 'ess-site)

(defun my_pipe_operator ()
  "R/ESS %>% operator"
  (interactive)
  (just-one-space 1)
  (insert "%>%")
  (reindent-then-newline-and-indent))
(define-key ess-mode-map (kbd "M-_") 'my_pipe_operator)
(define-key inferior-ess-mode-map (kbd "M-_") 'my_pipe_operator)

;;;Insert new chunk for Rmarkdown
(defun kjh-insert-r-chunk (header) 
  "Insert an r-chunk in markdown mode." 
  (interactive "sLabel: ") 
  (insert (concat "```{r " header "}\n\n```")) 
  (forward-line -1))

(global-set-key (kbd "C-c i") 'kjh-insert-r-chunk)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'ess-mode-hook
            (lambda () (flycheck-mode t)))
