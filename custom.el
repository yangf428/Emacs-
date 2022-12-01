
;;; Author： fan yang
;;; 我自己的私人配置
(require 'package)


;;; 设置外观
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ; 添加主题包到路径
(load-theme 'monokai t) ; 设置主题
(set-frame-font "Monaco-16");设置字体大小
;(set line-spacing 1.5)

(setq-default dotspacemacs-themes
              '(spacemacs-dark
                leuven
                (zenburn :location (recipe :fetcher github
                                           :repo "bbatsov/zenburn-emacs"))
                ))

(global-linum-mode 1)



;(setq dotspacemacs-mode-line-theme '(all-the-icons :separator-scale 1.5))

;;好看一点的mode-line



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-XeTeX-command "xelatex -synctex=1")
 '(TeX-engine 'xetex)
 '(blink-cursor-mode nil)
 '(package-selected-packages
   '(monokai-theme spacemacs-theme use-package zenburn-theme yaml-mode visual-regexp textmate solarized-theme smex smartparens rainbow-delimiters r-autoyas powerline poly-R pandoc-mode org-ac multiple-cursors maxframe magit latex-pretty-symbols idle-highlight-mode flycheck flx-ido expand-region exec-path-from-shell emmet-mode elpy ein csv-mode company-web company-statistics company-quickhelp company-math company-auctex browse-kill-ring anti-zenburn-theme ag adaptive-wrap))
 '(text-mode-hook '(text-mode-hook-identify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
