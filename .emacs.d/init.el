(require 'package)
(require 'rainbow-delimiters)
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; hooks
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

