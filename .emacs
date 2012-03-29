(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'euc-cn)
(set-clipboard-coding-system 'euc-cn)
(set-terminal-coding-system 'euc-cn)
(set-buffer-file-coding-system 'euc-cn)
(set-selection-coding-system 'euc-cn)
(modify-coding-system-alist 'process "*" 'euc-cn)
(setq default-process-coding-system 
            '(euc-cn . euc-cn))
(setq-default pathname-coding-system 'euc-cn)
(setq-default tab-width 4)


;(setq load-path (cons "/home/james/.emacs.d" load-path))
(load "/home/james/.emacs.d/rainbow-delimiters.el")
(when
      (load
             (expand-file-name "~/.emacs.d/elpa/package.el"))
        (package-initialize))


; hook
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(global-linum-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(customize-variable (quote tab-stop-list))
(define-key global-map (kbd "RET") 'newline-and-indent)
