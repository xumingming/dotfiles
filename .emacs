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
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/weibo.emacs"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/erc-hl-nicks"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/powerline"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/undo-tree"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/nrepl.el"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/projectile"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/hy-mode"))



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

;; color-theme
;;(load-theme 'wombat)
;;(load-theme 'tsdh-dark)
(load-theme 'misterioso)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'slime-repl-mode))


;; hooks
;; enable rainbow
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
;; enable paredit
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'hy-mode-hook (lambda () (paredit-mode +1)))

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
;;(yas-global-mode 1)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets/clojure-mode"))

;; set font size
(if (string= system-type "darwin")
  (set-default-font "Monaco-14")
  (set-default-face "default")
  (set-default-font "Ubuntu Mono-13"))


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

;; ==== workgroup BEGIN ====
;;(require 'workgroups)
;;(setq wg-prefix-key (kbd "C-c w"))
;;(workgroups-mode 1)
;;(wg-load "~/.emacs.d/workgroups")
;; ==== workgroup END   ====

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
 )
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

;; ERC hightlight nicks
(require 'erc-hl-nicks)

;; powerline
(require 'powerline)
(powerline-default)

;; column highlight
;;(require 'col-highlight)
;;(column-highlight-mode 1)

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
(require 'undo-tree)
(global-undo-tree-mode 1)
(defalias 'redo 'undo-tree)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)

;; bind C-o to imenu for clojure/java mode
(global-set-key (kbd "M-o") 'imenu)

;; erc config
;; auto connect to freenode.net
;;(erc :server "irc.freenode.net" :port 6667 :nick "xumingmingv")
;; auto-join channels
;;(setq erc-autojoin-channels-alist
;;      '(("freenode.net" "#emacs" "#clojure")))


;; refheap
(require 'refheap)

;; map C-x C-b to ido-switch-buffer
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

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
(require 'projectile)
(projectile-global-mode)

;; hide toolbar
(tool-bar-mode -1)

;; hy-mode
(require 'hy-mode)
