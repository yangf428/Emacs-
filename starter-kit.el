(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

(defun starter-kit-loadable-p (package)
  "Check if PACKAGE is loadable from a directory in `load-path'."
  (let ((load-file (concat (symbol-name package) ".el")))
    (catch 'file-found
      (dolist (dir load-path)
        (let ((path (expand-file-name load-file dir)))
          (when (file-exists-p path)
            (throw 'file-found path)))))))

(defun starter-kit-load (file)
  "This function is to be used to load starter-kit-*.org files."
  (org-babel-load-file (expand-file-name file
                                         dotfiles-dir)))

(defun starter-kit-compile (&optional arg)
  "Tangle and Byte compile all starter-kit files."
  (interactive "P")
  (cl-flet ((age (file)
              (float-time
               (time-subtract (current-time)
                              (nth 5 (or (file-attributes (file-truename file))
                                         (file-attributes file)))))))
    (mapc
     (lambda (file)
       (when (string= "org" (file-name-extension file))
         (let ((el-file (concat (file-name-sans-extension file) ".el")))
           (when (or arg
                     (not (and (file-exists-p el-file)
                               (> (age file) (age el-file)))))
             (org-babel-tangle-file file el-file "emacs-lisp")
             (byte-compile-file el-file)))))
     (apply #'append
            (mapcar
             (lambda (d)
               (when (and (file-exists-p d) (file-directory-p d))
                 (mapcar (lambda (f) (expand-file-name f d)) (directory-files d))))
             (list (concat dotfiles-dir user-login-name) dotfiles-dir))))))

(starter-kit-load "starter-kit-aspell.org")

(require 'package)
  (setq package-archives
            '(
          ("gnu"         . "http://elpa.gnu.org/packages/")
          ("melpa"   . "https://melpa.org/packages/")))


;;; Add support to package.el for pre-filtering available packages
(defvar package-filter-function nil
  "Optional predicate function used to internally filter packages used by package.el.

The function is called with the arguments PACKAGE VERSION ARCHIVE, where
PACKAGE is a symbol, VERSION is a vector as produced by `version-to-list', and
ARCHIVE is the string name of the package archive.")


(defadvice package--add-to-archive-contents

  (around filter-packages (package archive) activate)

  "Add filtering of available packages using `package-filter-function', if non-nil."

  (when (or (null package-filter-function)

(funcall package-filter-function
         (car package)
         (funcall (if (fboundp 'package-desc-version)
                      'package--ac-desc-version
                    'package-desc-vers)
                  (cdr package))
         archive))
    ad-do-it))

(defvar melpa-exclude-packages
      '()
  "Don't install Melpa versions of these packages.")

;; Don't take Melpa versions of certain packages
(setq package-filter-function
      (lambda (package version archive)
        (and
         (not (memq package '(eieio)))
         (or (not (string-equal archive "melpa"))
             (not (memq package melpa-exclude-packages))))))

  (package-initialize)
  (starter-kit-load "starter-kit-elpa.org")

(if (eq system-type 'darwin)
    (setq system-name (car (split-string system-name "\\."))))

(setq system-specific-config (concat dotfiles-dir system-name ".el")
      system-specific-literate-config (concat dotfiles-dir system-name ".org")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-literate-config (concat dotfiles-dir user-login-name ".org")
      user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

(setq elisp-source-dir (concat dotfiles-dir "src"))
(add-to-list 'load-path elisp-source-dir)

(starter-kit-load "starter-kit-defuns.org")

(starter-kit-load "starter-kit-bindings.org")

(starter-kit-load "starter-kit-misc.org")

(starter-kit-load "starter-kit-completion.org")

(starter-kit-load "starter-kit-org.org")

(starter-kit-load "starter-kit-eshell.org")

(starter-kit-load "starter-kit-lisp.org")

(starter-kit-load "starter-kit-python.org")

(starter-kit-load "starter-kit-latex.org")

(starter-kit-load "starter-kit-stats.org")

(starter-kit-load "starter-kit-text.org")

(load custom-file 'noerror)

(if (file-exists-p elisp-source-dir)
    (let ((default-directory elisp-source-dir))
      (normal-top-level-add-subdirs-to-load-path)))
(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p system-specific-literate-config)
    (org-babel-load-file system-specific-literate-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-literate-config)
    (org-babel-load-file user-specific-literate-config))
(when (file-exists-p user-specific-dir)
  (let ((default-directory user-specific-dir))
    (mapc #'load (directory-files user-specific-dir nil ".*el$"))
    (mapc #'org-babel-load-file (directory-files user-specific-dir nil ".*org$"))))

(message "Starter Kit main file loaded.")
