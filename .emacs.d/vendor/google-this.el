;;; google-this.el --- A set of functions and bindings to google under point.

;; Copyright (C) 2012 Artur Malabarba <bruce.connor.am@gmail.com>

;; Author: Artur Malabarba <bruce.connor.am@gmail.com>
;; URL: http://github.com/Bruce-Connor/emacs-google-this
;; Version: 1.6
;; Keywords: convenience hypermedia
;; Prefix: google-this
;; Separator: -

;;; Commentary:

;; google-this is a package that provides a set of functions and
;; keybindings for launching google searches from within emacs.

;; The main function is `google-this' (bound to C-c / g). It does a
;; google search using the currently selected region, or the
;; expression under point. All functions are bound under "C-c /"
;; prefix, in order to comply with emacs' standards. If that's a
;; problem see `google-this-keybind'. To view all keybindings type "C-c
;; / C-h".
;;
;; If you don't like this keybind, just reassign the
;; `google-this-mode-submap' variable.
;; My personal preference is "C-x g":
;;
;;        (global-set-key (kbd "C-x g") 'google-this-mode-submap)
;;
;; Or, if you don't want google-this to overwrite the default ("C-c /")
;; key insert the following line BEFORE everything else (even before
;; the `require' command):
;;
;;        (setq google-this-keybind (kbd "C-x g"))
;;

;; To start a blank search, do `google-search' (C-c / RET). If you
;; want more control of what "under point" means for the `google-this'
;; command, there are the `google-word', `google-symbol',
;; `google-line' and `google-region' functions, bound as w, s, l and space,
;; respectively. They all do a search for what's under point.

;; If the `google-wrap-in-quotes' variable is t, than searches are
;; enclosed by double quotes (default is NOT). If a prefix argument is
;; given to any of the functions, invert the effect of
;; `google-wrap-in-quotes'.

;; There is also a `google-error' (C-c / e) function. It checks the
;; current error in the compilation buffer, tries to do some parsing
;; (to remove file name, line number, etc), and googles it. It's still
;; experimental, and has only really been tested with gcc error
;; reports.

;; Finally there's also a google-cpp-reference function (C-c / r).

;;; Instructions:

;; INSTALLATION

;;  Make sure "google-this.el" is in your load path, then place
;;      this code in your .emacs file:
;;		(require 'google-this)
;;              (google-this-mode 1)

;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;

;;; Change Log:
;; 1.6 - 20130822 - Activated google-instant, so you can navigate straight for the keyboard
;; 1.5 - 20130718 - added keybinding for google region.
;; 1.5 - 20130718 - Fixed cpp-reference.
;; 1.4 - 20130603 - Added parent groups.
;; 1.4 - 20130603 - Renamed some functions and variables. Is backwards incompatible if you were using functions you shouldn't be.
;; 1.4 - 20130603 - Fixed quoting.
;; 1.3 - 20130531 - Merged fix for google-forecast. Thanks to ptrv.
;; 1.3 - 20130531 - More robust google-translate command.
;; 1.2.1 - 20130426 - Created an error parser for the google-error function. It works with c-like errors and is extendable to other types of errors using the varible `google-error-regexp'.
;; 1.2.1 - 20130426 - autoloaded any functions that the user might want to call directly.
;; 1.2 - 20130421 - Fixed docs.
;; 2013-05-04 -- Changed the keybinding to be standards compliant.
;; 2013-03-03 -- Fixed problem with backslash.
;; 2013-02-27 -- Added support for google-translate and google-maps packages. And added `google-forecast' function. And added `google-location-suffix' so we're not constrained to google.com anymore.
;;; Code:


(defgroup google-this '()
  "Customization group for `google-this-mode'."
  :link '(url-link "http://github.com/Bruce-Connor/emacs-google-this")
  :group 'convenience
  :group 'comm)
(defconst google-this-version "1.6"
  "Version string of the `google-this' package.")
(defconst google-this-version-int 6
  "Integer version number of the `google-this' package (for comparing versions).")
(defcustom google-wrap-in-quotes nil
  "If not nil, searches are wrapped in double quotes.

If a prefix argument is given to any of the functions, the
opposite happens."
  :type 'boolean
  :group 'google-this)

(defcustom google-this-suspend-after-search nil
  "Whether emacs should be minimized after a search is launched (calls `suspend-frame')."
  :type 'boolean
  :group 'google-this)

(define-prefix-command 'google-this-mode-submap)
(define-key google-this-mode-submap [return] 'google-search)
(define-key google-this-mode-submap " " 'google-region)
(define-key google-this-mode-submap "t" 'google-this)
(define-key google-this-mode-submap "w" 'google-word)
(define-key google-this-mode-submap "s" 'google-symbol)
(define-key google-this-mode-submap "l" 'google-line)
(define-key google-this-mode-submap "e" 'google-error)
(define-key google-this-mode-submap "f" 'google-forecast)
(define-key google-this-mode-submap "r" 'google-cpp-reference)
(define-key google-this-mode-submap "m" 'google-maps)
;; "c" is for "convert language" :-P
(define-key google-this-mode-submap "c" 'google-translate-query-or-region)

(defun google-translate-query-or-region ()
  "If region is active `google-translate-at-point', otherwise `google-translate-query-translate'."
  (interactive)
  (unless (require 'google-translate nil t)
    (error "[google-this]: This command requires the 'google-translate' package."))
  (if (region-active-p)
      (if (functionp 'google-translate-at-point)
          (call-interactively 'google-translate-at-point)
        (error "[google-this]: `google-translate-at-point' function not found in `google-translate' package."))
    (if (functionp 'google-translate-query-translate)
        (call-interactively 'google-translate-query-translate)
      (error "[google-this]: `google-translate-query-translate' function not found in `google-translate' package."))))

(defcustom google-location-suffix "com"
  "The url suffix associated with your location (com, co.uk, fr, etc)."
  :type 'string
  :group 'google-this)

(defun google-url () "URL to google searches."
  (concat "https://www.google." google-location-suffix "/search?ion=1&q=%s"))

(defun google-quoted-url () "OBSOLETE
URL to quoted google searches."
  (concat "https://www.google." google-location-suffix "/search?ion=1&q=%22%s%22"))


(defcustom google-this-url-parser-regexps '(
                                ("%" "%25")
                                ("\\+" "%2B")
                                ("&" "%26")
                                ("\"" "%22")
                                ("/" "%2F")
                                ("\\\\" "\\\\\\\\")
                                ("[[:blank:]]+" "+")
                                ("^ " "")
                                (" $" "")
                                ("^\\+" "")
                                ("\\+$" "")
                                )
  "List of (REGEXP REPLACEMENT) used by `google-this-parse-and-search-string'.

You shouldn't have to edit this. If you are forced to edit this
for some reason, contact me and let me know."
  :type '(repeat (list regexp string))
  :group 'google-this)

(defcustom google-error-regexp '(("^[^:]*:[0-9 ]*:\\([0-9 ]*:\\)? *" ""))
  "List of (REGEXP REPLACEMENT) pairs to parse error strings."
  :type '(repeat (list regexp string))
  :group 'google-this)


(defun google-this-decide-url (&optional dummy)
  "Decide which url to use.

This used to be for quoting, now quoting is done differently but
we are keeping it for possible future plans. DUMMY is not supposed to be used, currently."
  ;; (if (if prefix (not google-wrap-in-quotes) google-wrap-in-quotes)
  ;;     (google-quoted-url)
  ;;   (google-url))
  (if (stringp dummy)
      dummy
    (google-url)))

;;;###autoload
(defun google-search (prefix)
  "Write and do a google search."
  (interactive "P")
  (let ((TEXT (replace-regexp-in-string
               "^\\s-+" ""
               (if (region-active-p)
                   (buffer-substring-no-properties (region-beginning) (region-end))
                 (or (thing-at-point 'symbol)
                     (thing-at-point 'word)
                     (buffer-substring-no-properties (line-beginning-position)
                                                     (line-end-position)))) )))
    (setq TEXT (read-string (concat "Googling [" TEXT "]: ") nil nil TEXT))
    (if (stringp TEXT)
        (google-this-parse-and-search-string TEXT prefix)
      (message "[google-string] Empty query."))))


(defun google-this-parse-and-search-string (text prefix &optional url-decider)
  "Converts illegal characters in TEXT to their %XX versions, and then googles.

Don't call this function directly, it could change depending on
version. Use `google-string' instead (or any of the other
google-\"something\" functions).

Also understands the \"site:example.com\" option, but not yet any
of the other options (mostly because I don't know what they are).
TODO"
  (unless url-decider (setq url-decider 'google-this-decide-url))
  (let* ((option-regexp "\\bsite:[^ ]+")
         (case-fold-search t)
         (brute-query (replace-regexp-in-string option-regexp "" text))
         (site-option (if (string-match option-regexp text) (match-string-no-properties 0 text) ""))
         (query-string (dolist (rp google-this-url-parser-regexps brute-query)
                         (setq brute-query (replace-regexp-in-string (car rp) (car (cdr rp)) brute-query)))))
    ;; Decide whether to quote the query.
    (if (if prefix (not google-wrap-in-quotes) google-wrap-in-quotes)
        (setq query-string (concat "\"" query-string "\"")))
    ;; Create the url and perform the actual search.
    (browse-url (replace-regexp-in-string "%s" (concat query-string
                                                       (when site-option
                                                         (concat "+" site-option)))
                                          (funcall url-decider))))
  ;; Maybe suspend emacs.
  (when google-this-suspend-after-search (suspend-frame)))

(defalias 'parse-and-google-string 'google-this-parse-and-search-string
  "OBSOLETE alias.")

;;;###autoload
(defun google-string (prefix &optional TEXT NOCONFIRM)
  "Google given TEXT, but ask the user first if NOCONFIRM is nil."
  (unless NOCONFIRM
    (setq TEXT (read-string "Googling: "
                            (if (stringp TEXT) (replace-regexp-in-string "^[[:blank:]]*" "" TEXT)))))
  (if (stringp TEXT)
      (google-this-parse-and-search-string TEXT prefix)
    (message "[google-string] Empty query.")))

;;;###autoload
(defun google-line (prefix)
  "Google the current line."
  (interactive "P")
  (let ((Line (buffer-substring (line-beginning-position) (line-end-position))))
    (google-string prefix Line)))

;;;###autoload
(defun google-word (prefix)
  "Google the current word."
  (interactive "P")
  (google-string prefix (thing-at-point 'word) t))

;;;###autoload
(defun google-symbol (prefix)
  "Google the current symbol."
  (interactive "P")
  (google-string prefix (thing-at-point 'symbol) t))


;;;###autoload
(defun google-region (prefix)
  "Google the current region."
  (interactive "P")
  (google-string
   prefix (buffer-substring-no-properties (region-beginning) (region-end))))

;;;###autoload
(defun google-this (prefix)
  "Automatically decide what the user wants to google (always something under point).

Unlike `google-search' (which presents an empty prompt with
\"this\" as the default value), this function inserts the query
in the minibuffer to be edited."
  (interactive "P")
  (cond
   ((region-active-p) (google-region prefix))
   ((thing-at-point 'symbol) (google-string prefix (thing-at-point 'symbol)))
   ((thing-at-point 'word) (google-string prefix (thing-at-point 'word)))
   (t (google-line prefix))))

;;;###autoload
(defun google-error (prefix)
  "Google the current error in the compilation buffer."
  (interactive "P")
  (unless (boundp 'compilation-mode-map)
    (error "No compilation active."))
  (save-excursion
    (let ((pt (point))
          (buffer-name (next-error-find-buffer)))
      (unless (compilation-buffer-internal-p)
        (set-buffer buffer-name))
      (google-string prefix
                     (google-this-clean-error-string
                      (buffer-substring (line-beginning-position) (line-end-position)))))))


;;;###autoload
(defun google-this-clean-error-string (s)
  "Parse error strings and turn them into googleable strings.

Removes unhelpful details like file names and line numbers from
simple error strings (such as c-like erros).

Uses replacements in `google-error-regexp' and stops at the first match."
  (interactive)
  (let (out)
    (dolist (cur google-error-regexp out)
      (when (string-match (car cur) s)
        (setq out (replace-regexp-in-string
                   (car cur) (car (cdr cur)) s))
        (return out)))))

;;;###autoload
(defun google-cpp-reference ()
  "Visit the most probable cppreference.com page for this word."
  (interactive)
  (google-this-parse-and-search-string (concat "site:cppreference.com " (thing-at-point 'symbol)) nil 'google-feeling-lucky-decider))

(defun google-feeling-lucky-decider (&optional obsolete)
  "Just returns the feeling lucky url.

The argument is obsolete and doesn't do anything, it is kept for
backwards compatibility."
  (concat "https://www.google." google-location-suffix "/search?btnI=I'm Feeling Lucky&q=%s"))

;;;###autoload
(defun google-forecast (prefix)
  "Just searches google for \"weather\"."
  (interactive "P")
  (if (not prefix) (google-this-parse-and-search-string "weather" nil)
    (google-this-parse-and-search-string (concat "weather " (read-string "Location: " nil nil "")) nil)))

(defcustom google-this-keybind (kbd "C-c /")
  "Keybinding under which `google-this-mode-submap' is assigned.

To change this do something like:
    (setq google-this-keybind (kbd \"C-x g\"))
BEFORE activating `google-this-mode' and BEFORE `require'ing the
`google-this' feature."
  :type 'string
  :group 'google-this
  :package-version '(google-this . "1.4"))

;;;###autoload
(define-minor-mode google-this-mode nil nil " Google"
  `((,google-this-keybind . ,google-this-mode-submap))
  :global t
  :group 'google-this)
;; (setq google-this-keybind (kbd \"C-x g\"))

(provide 'google-this)

;;; google-this.el ends here
