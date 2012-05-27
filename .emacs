(set-language-environment 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'euc-cn)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'euc-cn)
(set-selection-coding-system 'euc-cn)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system 
            '(euc-cn . euc-cn))
(setq-default pathname-coding-system 'utf-8)
(setq-default tab-width 4)


(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/weibo.emacs"))


; hook
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(global-linum-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/package.el"))
  (package-initialize))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(require 'color-theme)
(color-theme-oswald)

(require 'auto-complete-config)
(ac-config-default)


(require 'ac-slime)                                                                                                                   
(add-hook 'slime-mode-hook 'set-up-slime-ac)                                                                                          
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1))) 
(eval-after-load "auto-complete"                                                                                                      
  '(add-to-list 'ac-modes 'slime-repl-mode)) 

(add-hook 'slime-mode-hook 'set-up-slime-ac)


(global-set-key (kbd "TAB") 'auto-complete)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.

  ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.bmk"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;; weibo.emacs
(require 'weibo)
