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
;;(color-theme-oswald)
(color-theme-xp)
;;(color-theme-gnome)
;;(color-theme-gtk-ide)
;;(color-theme-gnome2)



(require 'auto-complete-config)
(ac-config-default)


(require 'ac-slime)                                                                                                                   
(add-hook 'slime-mode-hook 'set-up-slime-ac)                                                                                          
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1))) 
(eval-after-load "auto-complete"                                                                                                      
  '(add-to-list 'ac-modes 'slime-repl-mode)) 

(add-hook 'slime-mode-hook 'set-up-slime-ac)


;;(global-set-key (kbd "TAB") 'auto-complete)
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

;; slime-repl syntax highlight
(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (require 'clojure-mode)
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

;;; I prefer cmd key for meta
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil)