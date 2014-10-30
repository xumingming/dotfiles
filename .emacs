;; emacs 24 does not have this function
;; so we define it ourself
(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
  alist))


;; encoding settings
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

;; setup load-path
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/powerline"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/projectile"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/rainbow-delimiters.el"))


(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; specify custom theme load path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'solarized-dark t)

;; global settings
;; customize the initial scratch message
(setq initial-scratch-message ";; Xiao Ming, Have a good day！")
;; inhibit startup message
(setq inhibit-startup-message t)
;; always follow symlinks without asking
(setq vc-follow-symlinks t)
;; display "lambda" as “λ"
(global-prettify-symbols-mode 1)
;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)
;; Highlight matching parentsis
(show-paren-mode t)
;; spaces instead of tabs
(setq-default indent-tabs-mode nil)
;; if there is a tab, make it size of 4 spaces
(setq-default tab-width 4)
;; set font
(set-default-font "WenQuanYi Zen Hei Mono-14")
;; set chinese font
(set-fontset-font t 'han (font-spec :name "WenQuanYi Zen Hei Mono-14"))
;; enable linum-mode
(global-linum-mode)
;;; set command key as meta
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)
;; enable electric-pair-mode by default
(electric-pair-mode)
;; put the backup file in seperate folder
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
;; require tramp to sudo edit file in emacs
(require 'tramp)
;; place the backup files in temp folder
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; buffer related things
;;(defalias 'list-buffers 'ido-switch-buffer)
(defalias 'list-buffers 'grizzl)


;; hooks
;; enable rainbow
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;; enable paredit
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'go-mode-hook (lambda () (paredit-mode +1)))

;; disable the line-wrap character
;; http://emacswiki.org/emacs/LineWrap
(set-display-table-slot standard-display-table 'wrap ?\ )

;; ido mode
(ido-mode t)
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have
(setq ido-enable-last-directory-history nil) ; forget latest selected directory names
(require 'flx-ido)
(flx-ido-mode 1)
(setq ido-use-faces nil)
(setq flx-ido-threshhold 10000)
(setq ido-everywhere t)

;; set the dir for yasnippet
(add-to-list 'load-path
              "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; ==== markdown BEGIN ====
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;; ==== markdown END   ====


;; map C-x C-g to magit-status
;;(global-set-key (kbd "C-x C-g") 'magit-status)

;; enable html-mode when open *.vm files
(add-to-list 'auto-mode-alist '("\\.vm$" . html-mode))


;; enable projectile globally
(require 'projectile)
;;(projectile-global-mode)
;; use native indexing method -- to enable .projectile ignore files
(setq projectile-use-native-indexing t)
;; enable projectile caching
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)

;; hide toolbar
(tool-bar-mode -1)

;; smart-tab
(require 'smart-tab)
(global-smart-tab-mode 1)
(add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand) ;put yasnippet in hippie-expansion list
(setq smart-tab-using-hippie-expand t)


;; emacs lisp
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
;;(add-hook 'emacs-lisp-mode-hook (lambda () (lisp-interaction-mode)))

;; set eshell PATH
(setenv "PATH" 
        (concat 
         "/usr/local/hadoop/bin/:/Users/xumingmingv/Desktop/ssh/:/usr/local/groovy/bin:/Users/xumingmingv/bin:/Users/xumingmingv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/opt/local/bin:/usr/local/zookeeper/bin:/Users/xumingmingv/local/svn/boost:/Users/xumingmingv/local/self/clojurescript/bin:/usr/alibaba/antx/bin:/Users/xumingmingv/local/self/go/bin:/usr/local/java/bin:/usr/local/hadoop/bin:/usr/local/hive/bin:/usr/local/storm/bin:/Users/xumingmingv/local/self/dotfiles/:/usr/local/btrace/bin:/usr/local/jmeter/bin:/Users/xumingmingv/local/self/odpscmd/bin:/Users/xumingmingv/local/self/odps-cli/bin" ":"
         (getenv "PATH")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(delete-selection-mode t)
 '(ergoemacs-ctl-c-or-ctl-x-delay 0.2)
 '(ergoemacs-handle-ctl-c-or-ctl-x (quote both))
 '(ergoemacs-ini-mode t)
 '(ergoemacs-keyboard-layout "us")
 '(ergoemacs-mode nil)
 '(ergoemacs-smart-paste nil)
 '(ergoemacs-theme "standard")
 '(ergoemacs-theme-options nil)
 '(ergoemacs-use-menus t)
 '(initial-scratch-message
   #(";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with ^O,
;; then enter the text in that file's own buffer." 131 133
                                                       (face ergoemacs-pretty-key)))
 '(org-CUA-compatible t)
 '(org-special-ctrl-a/e t)
 '(org-support-shift-select t)
 '(recentf-menu-before "Close")
 '(recentf-mode t)
 '(scroll-error-top-bottom t)
 '(set-mark-command-repeat-pop t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
