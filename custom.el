
;;; Author： fan yang
;;; 我自己的私人配置
(require 'package)


;;; 设置外观
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ; 添加主题包到路径
(load-theme 'monokai t) ; 设置主题
(set-frame-font "Monaco-17");设置字体大小
;(set-default line-spacing 1.25)
;(set line-spacing 1.5)
(setq-default cursor-type 'bar); 设置光标为竖线

;(setq-default dotspacemacs-themes
;              '(spacemacs-dark
;                leuven
;                (zenburn :location (recipe :fetcher github
;                                           :repo "bbatsov/zenburn-emacs"))
;                ))
(global-linum-mode 1) ; 设置行号
;(setq dotspacemacs-mode-line-theme '(all-the-icons :separator-scale 1.5))
;;好看一点的mode-line

;日历中添加中国节日
(Add-to-list 'load-path "~/.emacs.d/elpa/cal-china-x-20200924.1837")
(require 'cal-china-x)

;; Set up bbdb
;(require 'bbdb)
;(bbdb-initialize 'message)
;(bbdb-insinuate-message)
;(add-hook 'message-setup-hook 'bbdb-insinuate-mail)
;; set up calendar
(require 'calfw)
(require 'calfw-ical)
;; Set this to the URL of your calendar. Google users will use
;; the Secret Address in iCalendar Format from the calendar settings
;; 这个是日历
;(cfw:open-ical-calendar "<https://path/to/my/ics/file.ics>")
;; Set up notmuch
(require 'notmuch)
;; set up mail sending using sendmail
(setq send-mail-function (quote sendmail-send-it))
(setq user-mail-address "[yangfff428@163.com][9]"
      user-full-name "fan yang")






(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-XeTeX-command "xelatex -synctex=1")
 '(TeX-engine 'xetex)
 '(blink-cursor-mode nil)
 '(package-selected-packages
   '(cal-china-x notmuch-labeler notmuch-addr notmuch-maildir notmuch calfw-ical calfw bbdb-vcard bbdb monokai-theme spacemacs-theme use-package zenburn-theme yaml-mode visual-regexp textmate solarized-theme smex smartparens rainbow-delimiters r-autoyas powerline poly-R pandoc-mode org-ac multiple-cursors maxframe magit latex-pretty-symbols idle-highlight-mode flycheck flx-ido expand-region exec-path-from-shell emmet-mode elpy ein csv-mode company-web company-statistics company-quickhelp company-math company-auctex browse-kill-ring anti-zenburn-theme ag adaptive-wrap))
 '(text-mode-hook '(text-mode-hook-identify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
