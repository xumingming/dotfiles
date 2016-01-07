;; turn on debug
;;(setq debug-on-error t)

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
(add-to-list 'load-path (expand-file-name "/usr/local/bin"))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; specify custom theme load path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/darcula-theme-20141022.652/")
(load-theme 'solarized-dark t)
;;(load-theme 'solarized-light t)
;;(load-theme 'light-blue)
;;(load-theme 'misterioso)
;;(load-theme 'leuven)
;;(load-theme 'wheatgrass)
;;(load-theme 'darcula t)
;;(load-theme 'deeper-blue)

;; global settings
;; customize the initial scratch message
(setq initial-scratch-message ";; Xiao Ming, Have a good day£¡")
;; inhibit startup message
(setq inhibit-startup-message t)
;; always follow symlinks without asking
(setq vc-follow-symlinks t)
;; display "lambda" as ¡°¦Ë"
(global-prettify-symbols-mode 1)
;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)
;; Highlight matching parentsis
(show-paren-mode t)

;; set font

;;(set-default-font "Monaco-15")
;; set chinese font
(set-default-font "WenQuanYi Zen Hei Mono-16")
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

;;(defalias 'list-buffers 'grizzl)

;; enable paredit
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

;; disable the line-wrap character
;; http://emacswiki.org/emacs/LineWrap
(set-display-table-slot standard-display-table 'wrap ?\ )

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
(projectile-global-mode)
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("18e89f93cbaaac214202142d910582354d36639f21f32b04718ca6425dbc82a2" "d4814f7fae129a9d1339c375f0236620a7e725d32f868cf88417f59b7078bf7f" "941bc214a26ed295e68bbeaadcd279475a3d6df06ae36b0b2872319d58b855f7" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(delete-selection-mode t)
 '(initial-scratch-message nil)
 '(org-CUA-compatible nil)
 '(recentf-menu-before nil)
 '(recentf-mode t)
 '(scroll-error-top-bottom nil)
 '(set-mark-command-repeat-pop nil)
 '(shift-select-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; auto-complete related settings
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode)

;; go related settings
(require 'go-autocomplete)
(require 'lazy-set-key) ;; init-golang depends on this
(require 'init-golang)
;;(add-hook 'go-mode-hook (lambda () (auto-complete-mode +1)))
;;(require 'go-mode)

(setenv "GOROOT" "/usr/local/Cellar/go/1.3/libexec")
(setenv "PATH" 
        (concat 
		 "/bin"
		 ":/sbin"		 
		 ":/usr/bin"
		 ":/usr/sbin"		 
		 ":/usr/local/bin"
		 ":" (getenv "GOROOT") "/bin"
		 ":/Users/xumingmingv/local/self/go/bin"
		 ":" (getenv "PATH")))
(setenv "GOPATH" "/Users/xumingmingv/local/self/go")
(setq exec-path (split-string (getenv "PATH") ":"))

(defun xumingmingv-go-mode-hook ()
  "Modify keymaps used by `go-mode'."
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "C-c C-d") 'godoc-at-point)  
  (add-hook 'before-save-hook #'gofmt-before-save)
  ;; enable auto-complete
  (auto-complete-mode +1)
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")  
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  (go-oracle-mode)
  )

(add-hook 'go-mode-hook 'xumingmingv-go-mode-hook)


;; undo redo
(require 'undo-tree)
(global-undo-tree-mode 1)
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)

;; window-number mode
(require 'window-number)
(window-number-mode 1)
(window-number-meta-mode 1)

(add-hook 'after-change-major-mode-hook 
          '(lambda () 
             (setq-default indent-tabs-mode nil)
             (setq c-basic-indent 4)
             (setq tab-width 4)))

;; helm related
;; (require 'helm-config)
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-x C-b") 'helm-mini)
;; (setq helm-M-x-fuzzy-match t
;; 	  helm-buffers-fuzzy-match t
;;   	  helm-imenu-fuzzy-match t
;; 	  helm-recentf-fuzzy-match t)

;; ido mode
(ido-mode t)
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have
(setq ido-enable-last-directory-history nil) ; forget latest selected directory names
(require 'flx-ido)
(flx-ido-mode 1)
(setq ido-use-faces nil)
(setq flx-ido-threshhold 10000)
(setq ido-everywhere t)


;; ido-ubiquitous-mode
(ido-ubiquitous-mode t)

;; vertical ido mode
(require 'ido-vertical-mode)
(ido-vertical-mode 1)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(defalias 'list-buffers 'ido-switch-buffer)

(defun align-repeat (start end regexp)
    "Repeat alignment with respect to 
     the given regular expression."
    (interactive "r\nsAlign regexp: ")
    (align-regexp start end 
        (concat "\\(\\s-*\\)" regexp) 1 1 t))

(defun align-table (start end)
  (interactive "r")
;;  (replace-string "	" "" start end)
  (align-repeat start end "|"))


(defun clean-whitespace-region (start end)
  "Untabifies, removes trailing whitespace, and re-indents the region"
  (interactive "r")
  (save-excursion
    (untabify start end)
    (c-indent-region start end)
    (replace-regexp "[  ]+$" "" nil start end))) ;
