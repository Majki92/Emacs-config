;;; emacs-init --- My init file
;;; Commentary:

;;; Code:
(add-to-list 'load-path "~/.emacs.d/modules")
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(setq backup-directory-alist '(("." . "~/.emacs_saves"))
      backup-by-copying t)

(ido-mode 1) ; enable ido mode
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x r") 'revert-buffer)

;; window size
(setq default-frame-alist '((top . 0) (left . 0) (width . 200) (height . 55)))

(setq package-archives
      '(("gnu"       . "http://elpa.gnu.org/packages/")
        ("marmalade" . "https://marmalade-repo.org/packages/")
        ("elpa"      . "http://tromey.com/elpa/")
        ("melpa"     . "http://melpa.org/packages/")))

(package-initialize)
(require 'use-package)

;; zenburn theme
(use-package zenburn-theme
  :ensure t
  :demand
  :config (progn
          (add-hook 'after-init-hook '(lambda () (interactive) (load-theme 'zenburn)))
          (setq frame-background-mode 'dark)))

;; syntax error highliting
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode 1))

;; project management
(use-package projectile
  :ensure t
  :init (projectile-global-mode 1))

;; easy lisp editing, brackets balancing
(use-package paredit
  :ensure t
  :init (add-hook 'emacs-lisp-mode-hook
		  (lambda ()
		    (paredit-mode 1))))
		    
;; apply cmake parameters to company mode
(use-package cpputils-cmake
  :ensure t
  :init (add-hook 'c-mode-common-hook
		  (lambda()
		    (when (derived-mode-p 'c-mode 'c++-mode)
			(cppcm-reload-all)))))

;; code autocompletion tool
(use-package company
  :ensure t
  :defer 5
  :config (progn
            (setq company-idle-delay 0.25)
            (add-hook 'c++-mode-hook
                      #'(lambda ()
                          (make-local-variable 'company-clang-arguments)
                          (setq company-clang-arguments '("-std=c++11"))
			  (cppcm-reload-all)))
            (add-hook 'eshell-mode-hook '(lambda () (company-mode 0)))
            (add-hook 'org-mode-hook '(lambda () (company-mode 0)))
            (global-company-mode 1))
  :bind ("C-c v" . company-complete))
