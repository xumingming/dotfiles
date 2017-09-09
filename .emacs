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
;;(load-theme 'darcula t)
(load-theme 'adwaita t)

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

;; disable the line-wrap character
;; http://emacswiki.org/emacs/LineWrap
(set-display-table-slot standard-display-table 'wrap ?\ )

;; markdown
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

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

;; emacs lisp
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))

;;
;; recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


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

;; define some colors
(setq ido-use-faces t)
(set-face-attribute 'ido-vertical-first-match-face nil
                    :background nil
                    :foreground "orange")
(set-face-attribute 'ido-vertical-only-match-face nil
                    :background nil
                    :foreground nil)
(set-face-attribute 'ido-vertical-match-face nil
                    :foreground nil)
(ido-vertical-mode 1)

;; use C-n & C-p rather than C-s & C-r
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
;; use C-X C-b to switch buffer
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

;; dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)

;; company-mode
(add-hook 'after-init-hook 'global-company-mode)


;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; smart-tab
(require 'smart-tab)
(global-smart-tab-mode 1)
(setq smart-tab-using-hippie-expand t)

;; windmove
(windmove-default-keybindings 'meta)

;; winner-mode
(when (fboundp 'winner-mode)
  (winner-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c697b65591ba1fdda42fae093563867a95046466285459bd4e686dc95a819310" "40c66989886b3f05b0c4f80952f128c6c4600f85b1f0996caa1fa1479e20c082" "18e89f93cbaaac214202142d910582354d36639f21f32b04718ca6425dbc82a2" "d4814f7fae129a9d1339c375f0236620a7e725d32f868cf88417f59b7078bf7f" "941bc214a26ed295e68bbeaadcd279475a3d6df06ae36b0b2872319d58b855f7" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(delete-selection-mode t)
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#9876aa" :underline
	  (:style wave :color "yellow"))
     (val :foreground "#9876aa")
     (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (implicitConversion :underline
			 (:color "#808080"))
     (implicitParams :underline
		     (:color "#808080"))
     (operator :foreground "#cc7832")
     (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832")
     (deprecated :strike-through "#a9b7c6"))))
 '(initial-scratch-message nil)
 '(org-replace-disputed-keys nil)
 '(package-selected-packages
   (quote
    (smex browse-kill-ring dashboard yaml-mode workgroups window-number windata whitespace-cleanup-mode web-mode tidy tabbar ssh rainbow-delimiters python-mode projectile phi-rectangle paredit multi-term markdown-mode+ magit lex less-css-mode ioccur idomenu ido-yes-or-no ido-vertical-mode ido-ubiquitous ido-select-window highline highlight-parentheses helm grizzl go-autocomplete git-rebase-mode git-commit-mode flx-ido eyebrowse etags-table elscreen editorconfig dsvn dired+ desktop darcula-theme company column-marker color-theme col-highlight bison-mode all-ext 2048-game)))
 '(recentf-menu-before nil)
 '(recentf-mode t)
 '(scroll-error-top-bottom nil)
 '(set-mark-command-repeat-pop nil)
 '(shift-select-mode nil)
 '(truncate-partial-width-windows nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
