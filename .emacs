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


(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

; hook
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
;;(global-linum-mode)

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
(color-theme-hober)

(require 'auto-complete-config)
(ac-config-default)

(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'slime-repl-mode))
(add-hook 'slime-mode-hook 'set-up-slime-ac)

;; slime-repl syntax highlight
(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (require 'clojure-mode)
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

;; change the "Mark Set" command to use Ctrl+x M
(define-key global-map "\C-xm" 'set-mark-command)

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

;; enable winner-mode
(when (fboundp 'winner-mode)
      (winner-mode 1))

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
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

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
      '("~/.emacs.d/snippets/clojure-mode"))

;; set font size
(set-default-font "Consolas-16")