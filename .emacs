(require 'package)
  (when (>= emacs-major-version 24)
  (add-to-list 
	'package-archives 
	'("melpa" . "http://melpa.org/packages/")
	t))
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t))

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/cedet-1.1")
(setq server-use-tcp t)
;;---------------------------------------------
;;minimap keyset and line numbers in c/c++ files
(global-set-key (kbd "M-m") 'minimap-mode)
(defun my-c-mode-common-hook ()
     (linum-mode t))
;;------------------------------------------------
;;sr-speedbar behavior
;;(add-hook 'after-init-hook 'sr-speedbar-open)
(global-set-key (kbd "M-s") 'sr-speedbar-toggle)
;;-----------------------------------------------------------
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;(split-window-right)

(setq tab-width 4)
(setq auto-mode-alist (cons '("\\.gpl$" . c-mode) auto-mode-alist))

(load "bison-mode")
(add-hook 'bison-mode-hook 'imenu-add-menubar-index)
(add-hook 'c-mode-common-hook 'imenu-add-menubar-index)

(load-theme 'tango-dark)
;;---------------------------------------------------------------
;;ggtags setup
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(setq-local imenu-create-index-function #'ggtags-build-imenu-index)
(setq speedbar-show-unknown-files t)

;;---------------------------------------------------------------
;;company hooks
(defun trivialfis/local-set-keys (key-commands)
  "Set multiple local bindings with KEY-COMMANDS list."
  (let ((local-map (current-local-map)))
    (dolist (kc key-commands)
      (define-key local-map
	(kbd (car kc))
	(cdr kc)))))
;;(add-hook 'c++-mode-hook '(lambda()
;;		(cmake-ide-setup)
;;		(trivialfis/local-set-keys
;;			`("C-c C-a" . cmake-ide-compile)
;;		)))
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'c++-mode-hook '(lambda()
	(setf company-backends '())
	(add-to-list 'company-backends 'company-keywords)
	(add-to-list 'company-backends 'company-irony)
	(add-to-list 'company-backends 'company-irony-c-headers)
))
;;------------------------------------------------------------------
;;call graph key set
(global-set-key (kbd "C-c g") 'call-graph)

(setq linum-format "%4d \u2502 ")
(set-face-background 'vertical-border "gray")
(set-face-foreground 'vertical-border (face-background 'vertical-border))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(minimap-hide-scroll-bar nil)
 '(minimap-minimum-width 15)
 '(minimap-mode nil)
 '(minimap-width-fraction 0.1)
 '(package-selected-packages
   (quote
    (free-keys company-c-headers company sr-speedbar ggtags call-graph use-package tide srefactor projectile minimap irony-eldoc helm-rtags flycheck-rtags flycheck-irony ecb disaster company-rtags company-irony-c-headers company-irony cmake-mode cmake-ide clang-format ace-window)))
 '(sr-speedbar-default-width 25)
 '(sr-speedbar-max-width 35)
 '(sr-speedbar-right-side nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
