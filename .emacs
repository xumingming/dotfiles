;;  emacs 24 does not have this function
;3q/wr; so we define it ourself
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
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/weibo.emacs"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/powerline"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/nrepl.el"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/projectile"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/rainbow-delimiters.el"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/undo-tree"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/go-autocomplete.el"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/hy-mode"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/go-mode.el"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/emacs-eclim"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/solarized.el"))


;; specify custom theme load path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'solarized-dark t)
;;(load-theme 'solarized-light t)
;;(load-theme 'zenburn t)
;;(load-theme 'adwaita t)

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

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'slime-repl-mode))


;; hooks
;; enable rainbow
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;; enable paredit
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'hy-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'go-mode-hook (lambda () (paredit-mode +1)))

;;(require 'ac-slime)
;;(add-hook 'slime-mode-hook 'set-up-slime-ac)
;;(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;;(add-hook 'slime-mode-hook 'set-up-slime-ac)

;; slime-repl syntax highlight
;;(add-hook 'slime-repl-mode-hook
;;          (defun clojure-mode-slime-font-lock ()
;;            (require 'clojure-mode)
;;            (let (font-lock-mode)
;;              (clojure-mode-font-lock-setup))))

;; put the backup file in seperate folder
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; window-numbering
;;(require 'window-number)
(autoload 'window-number-mode "window-number" "..." t)
(autoload 'window-number-meta-mode "window-number" "..." t)
(window-number-mode 1)
(window-number-meta-mode 1)

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

;; Dont show startup screen
(setq inhibit-startup-message t)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight matching parentsis
(show-paren-mode t)

;; Delete trailing whitespaces
;;(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; if there is a tab, make it size of 4 spaces
(setq-default tab-width 4)


;; set the dir for yasnippet
(add-to-list 'load-path
              "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs
  '("/Users/xumingmingv/local/self/dotfiles/.emacs.d/snippets/clojure-mode"
    "/Users/xumingmingv/local/self/dotfiles/.emacs.d/snippets/go-mode"
    ))

;; set font size
(if (string= system-type "darwin")
	(set-default-font "WenQuanYi Zen Hei Mono-14")
  (set-default-font "WenQuanYi Zen Hei Mono-14"))
;; set chinese font
(set-fontset-font t 'han (font-spec :name "WenQuanYi Zen Hei Mono-14"))

;; replace string
;; (global-set-key (kbd "C-x C-r") 'replace-string)


;; ====  kibit related config BEGIN ====
;; Teach compile the syntax of the kibit output
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
         '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
(add-to-list 'compilation-error-regexp-alist 'kibit)

;; A convenient command to run "lein kibit" in the project to which
;; the current emacs buffer belongs to.
(defun kibit ()
  "Run kibit on the current project.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile "lein kibit"))
;; ====  kibit related config END   ====


;; ==== org-mode BEGIN ====
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/org/book/home.org"
                             "~/org/book/work.org"
                             "~/org/book/emacsbook.org"))
;; ==== org-mode END   ====


;; ==== nrepl BEGIN ====
(require 'nrepl)
;; enable the eldoc mode for clojure buffers
(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)
;; dont popup error buffer
(setq nrepl-popup-stacktraces nil)
;; hide special buffers
(setq nrepl-hide-special-buffers t)
;; auto-select error buffer when displayed
(setq nrepl-auto-select-error-buffer t)
;; show port on buffer name
(setq nrepl-buffer-name-show-port t)
;; change 'back' key to M-[
(define-key nrepl-interaction-mode-map (kbd "M-[") 'nrepl-jump-back)

;;
;;(add-to-list 'same-window-buffer-names "*nrepl*")
;; ==== nrepl END   ====

;; ==== markdown BEGIN ====
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(eval-after-load 'markdown-mode
  '(progn
     (define-key markdown-mode-map (kbd "C-c C-v") 'markdown-preview)
     ))
;; ==== markdown END   ====

;; ==== weibo BEGIN ====
(require 'weibo)
;; ==== weibo END   ====

;; ==== TAG BEGIN ====
(setq tags-file-name "~/local/svn/dotfiles/TAGS")
;; ==== TAG END   ====
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; enable linum-mode
(global-linum-mode)

;;; set command key as meta
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; powerline
(require 'powerline)
(powerline-default)

;; column highlight
(require 'col-highlight)
(column-highlight-mode 0)

;; show bookmarks at startup
(setq inhibit-splash-screen t)
(require 'bookmark)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")


;; convenient cut/paste line
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (message "Current line is copied.")
       (list (line-beginning-position) (line-beginning-position 2)) ) ) ))

(defadvice kill-region (before slick-copy activate compile)
  "When called interactively with no active region, cut the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (list (line-beginning-position) (line-beginning-position 2)) ) ) ))

;; enable electric-pair-mode by default
(electric-pair-mode)

;; undo-tree
;;(require 'undo-tree)
;;(global-undo-tree-mode 1)
;;(defalias 'redo 'undo-tree)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)
(global-set-key (kbd "M-/") 'auto-complete)
;;(global-set-key (kbd "TAB") 'yas-expand)

;; bind C-o to imenu for clojure/java mode
(global-set-key (kbd "M-o") 'imenu)

;; refheap
(require 'refheap)

;; buffer related things
;;(defalias 'list-buffers 'ido-switch-buffer)
(defalias 'list-buffers 'grizzl)

;; map C-x C-b to ido-switch-buffer
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
;; map C-x C-b to ido-switch-buffer
;;(global-set-key (kbd "C-x C-b") 'ibuffer)

;; map C-x C-g to magit-status
(global-set-key (kbd "C-x C-g") 'magit-status)

;; enable html-mode when open *.vm files
(add-to-list 'auto-mode-alist '("\\.vm$" . html-mode))

;; (global-hl-line-mode)

;; window manager keys
;; C-x r w <register-name> : save current window configuration into the register
;; C-x r j <register-name> : restore the window configuration from the register

;; bound pop-tag-mark to M-,
(global-set-key (kbd "M-,") 'pop-tag-mark)


;; enable projectile globally
;;(require 'projectile)
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

;; require tramp to sudo edit file in emacs
(require 'tramp)

;; shift-tab to un-indent
(global-set-key (kbd "<S-tab>") 'un-indent-by-removing-4-spaces)
(defun un-indent-by-removing-4-spaces ()
  "remove 4 spaces from beginning of of line"
  (interactive)
  (save-excursion
    (save-match-data
      (beginning-of-line)
      ;; get rid of tabs at beginning of line
      (when (looking-at "^\\s-+")
        (untabify (match-beginning 0) (match-end 0)))
      (when (looking-at "^    ")
        (replace-match "")))))
