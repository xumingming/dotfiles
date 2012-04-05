;;; highline-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (highline-split-window-horizontally highline-split-window-vertically
;;;;;;  highline-view-mode highline-mode global-highline-mode highline-customize)
;;;;;;  "highline" "highline.el" (20349 18653))
;;; Generated autoloads from highline.el

(autoload 'highline-customize "highline" "\
Customize highline group.

\(fn)" t nil)

(defvar global-highline-mode nil "\
Non-nil if Global-Highline mode is enabled.
See the command `global-highline-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-highline-mode'.")

(custom-autoload 'global-highline-mode "highline" nil)

(autoload 'global-highline-mode "highline" "\
Toggle global minor mode to highlight line about point (HL on modeline).

If ARG is null, toggle global highline mode.
If ARG is a number and is greater than zero, turn on
global highline mode; otherwise, turn off global highline mode.
Only useful with a windowing system.

\(fn &optional ARG)" t nil)

(autoload 'highline-mode "highline" "\
Toggle local minor mode to highlight the line about point (hl on modeline).

If ARG is null, toggle local highline mode.
If ARG is a number and is greater than zero, turn on
local highline mode; otherwise, turn off local highline mode.
Only useful with a windowing system.

\(fn &optional ARG)" t nil)

(autoload 'highline-view-mode "highline" "\
Toggle indirect mode to highlight current line in buffer (Ihl on modeline).

If ARG is null, toggle indirect highline mode.
If ARG is a number and is greater than zero, turn on
indirect highline mode; otherwise, turn off indirect highline mode.
Only useful with a windowing system.

Indirect highline (`highline-view-mode') is useful when you wish
to have various \"visions\" of the same buffer.

Indirect highline uses an indirect buffer to get the \"vision\" of the buffer.
So, if you kill an indirect buffer, the base buffer is not affected; if you
kill the base buffer, all indirect buffer related with the base buffer is
automagically killed.  Also, any text insertion/deletion in any indirect or base
buffer is updated in all related buffers.

See `highline-view-prefix'.

\(fn &optional ARG)" t nil)

(autoload 'highline-split-window-vertically "highline" "\
Split window vertically then turn on indirect highline mode.

See `split-window-vertically' for explanation about ARG and for
documentation.

See also `highline-view-mode' for documentation.

\(fn &optional ARG)" t nil)

(autoload 'highline-split-window-horizontally "highline" "\
Split window horizontally then turn on indirect highline mode.

See `split-window-horizontally' for explanation about ARG and for
documentation.

See also `highline-view-mode' for documentation.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("highline-pkg.el") (20349 18653 170194))

;;;***

(provide 'highline-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; highline-autoloads.el ends here
