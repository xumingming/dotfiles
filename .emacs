(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'euc-cn)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'euc-cn)
(set-selection-coding-system 'euc-cn)
(modify-coding-system-alist 'process "*" 'euc-cn)
(setq default-process-coding-system 
            '(euc-cn . euc-cn))
(setq-default pathname-coding-system 'euc-cn)
(setq-default tab-width 4)


(add-to-list 'load-path (expand-file-name "/home/james/.emacs.d"))


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
(eval-after-load "auto-complete"                                                                                                      
  '(add-to-list 'ac-modes 'slime-repl-mode)) 

(add-hook 'slime-mode-hook 'set-up-slime-ac)


(global-set-key (kbd "TAB") 'auto-complete)