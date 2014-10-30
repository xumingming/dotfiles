;;; ergoemacs-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ergoemacs-extras" "ergoemacs-extras.el" (21585
;;;;;;  4024 0 0))
;;; Generated autoloads from ergoemacs-extras.el

(autoload 'ergoemacs-ghpages "ergoemacs-extras" "\
Generate github pages with o-blog.

\(fn)" t nil)

(autoload 'ergoemacs-bash "ergoemacs-extras" "\
Generates `~/.inputrc' to use ergoemacs-keys in bash.  This is
based on ergoemacs' current theme and layout.

\(fn)" t nil)

(autoload 'ergoemacs-extras "ergoemacs-extras" "\
Generate layout diagram, and other scripts for system-wide ErgoEmacs keybinding.

The following are generated:
• SVG Diagram for ErgoEmacs command layouts in SVG format.
• Bash 〔.inputrc〕 code.
• Mac OS X 〔DefaultKeyBinding.dict〕 code.
• AutoHotkey script for Microsoft Windows.

Files are generated in the dir 〔ergoemacs-extras〕 at `user-emacs-directory'.

\(fn &optional LAYOUTS)" t nil)

(autoload 'ergoemacs-keyfreq-image "ergoemacs-extras" "\
Create heatmap keyfreq images, based on the current layout.

\(fn)" t nil)

(autoload 'ergoemacs-svgs "ergoemacs-extras" "\
Generate SVGs for all the defined layouts and themes.

\(fn &optional LAYOUTS)" t nil)

;;;***

;;;### (autoloads nil "ergoemacs-functions" "ergoemacs-functions.el"
;;;;;;  (21585 4024 0 0))
;;; Generated autoloads from ergoemacs-functions.el

(autoload 'ergoemacs-paste-cycle "ergoemacs-functions" "\
Run `yank-pop' or`yank'.
This is `yank-pop' if `ergoemacs-smart-paste' is nil.
This is `yank' if `ergoemacs-smart-paste' is t.

If `browse-kill-ring' is enabled and the last command is not a
paste, this will start `browse-kill-ring'.

When in `browse-kill-ring-mode', cycle backward through the key ring.

\(fn)" t nil)

(autoload 'ergoemacs-paste "ergoemacs-functions" "\
Run `yank' or `yank-pop' if this command is repeated.
This is `yank' if `ergoemacs-smart-paste' is nil.
This is `yank-pop' if `ergoemacs-smart-paste' is t and last command is a yank.
This is `browse-kill-ring' if `ergoemacs-smart-paste' equals 'browse-kill-ring and last command is a yank.

When in `browse-kill-ring-mode', cycle forward through the key ring.

This does the same thing in `iseach-mode' using `isearch-yank-pop' and  `isearch-yank-kill'

\(fn)" t nil)

(autoload 'ergoemacs-unaccent-word "ergoemacs-functions" "\
Move curseur forward NUM (prefix arg) words, removing accents.
Guillemet -> quote, degree -> @, s-zed -> ss, upside-down ?! -> ?!.

\(fn NUM)" t nil)

(autoload 'ergoemacs-unaccent-region "ergoemacs-functions" "\
Replace accented chars between START and END by unaccented chars.
Guillemet -> quote, degree -> @, s-zed -> ss, upside-down ?! -> ?!.
When called from a program, third arg DISPLAY-MSGS non-nil means to
display in-progress messages.

\(fn START END DISPLAY-MSGS)" t nil)

(autoload 'ergoemacs-unaccent-char "ergoemacs-functions" "\
Replace accented char at curser by corresponding unaccented char(s).
Guillemet -> quote, degree -> @, s-zed -> ss, upside-down ?! -> ?!.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "ergoemacs-macros" "ergoemacs-macros.el" (21585
;;;;;;  4024 0 0))
;;; Generated autoloads from ergoemacs-macros.el

(autoload 'ergoemacs-sv "ergoemacs-macros" "\
Error free `symbol-value'.
If SYMBOL is void, return nil

\(fn SYMBOL)" nil t)

(autoload 'ergoemacs-with-ergoemacs "ergoemacs-macros" "\
With basic `ergoemacs-mode' mode keys.
major-mode, minor-mode, and global keys are ignored.

\(fn &rest BODY)" nil t)

(autoload 'ergoemacs-with-overrides "ergoemacs-macros" "\
With the `ergoemacs-mode' mode overrides.
The global map is ignored, but major/minor modes keymaps are included.

\(fn &rest BODY)" nil t)

(autoload 'ergoemacs-with-global "ergoemacs-macros" "\
With global keymap, not ergoemacs keymaps.

\(fn &rest BODY)" nil t)

(autoload 'ergoemacs-with-major-and-minor-modes "ergoemacs-macros" "\
Without global keymaps and ergoemacs keymaps.

\(fn &rest BODY)" nil t)

(autoload 'ergoemacs-without-emulation "ergoemacs-macros" "\
Without keys defined at `emulation-mode-map-alists'.

Also temporarily remove any changes ergoemacs-mode made to:
- `overriding-terminal-local-map'
- `overriding-local-map'

Will override any ergoemacs changes to the text properties by temporarily
installing the original keymap above the ergoemacs-mode installed keymap.

\(fn &rest BODY)" nil t)

(autoload 'ergoemacs-theme-component--parse-remaining "ergoemacs-macros" "\
In parsing, this function converts
- `define-key' is converted to `ergoemacs-define-key' and keymaps are quoted
- `global-set-key' is converted to `ergoemacs-define-key' with keymap equal to `global-map'
- `global-unset-key' is converted to `ergoemacs-define-key' with keymap equal to `global-map' and function definition is `nil'
- `global-reset-key' is converted `ergoemacs-define-key'
- `setq' and `set' is converted to `ergoemacs-theme--set'
- `add-hook' and `remove-hook' is converted to `ergoemacs-theme--set'
- Mode initialization like (delete-selection-mode 1)
  or (delete-selection) is converted to
  `ergoemacs-theme--set'
- Allows :version statement expansion
- Adds with-hook syntax or (when -hook) or (when -mode)

\(fn REMAINING)" nil nil)

(autoload 'ergoemacs-component "ergoemacs-macros" "\
A component of an ergoemacs-theme.

\(fn &rest BODY-AND-PLIST)" nil t)

(put 'ergoemacs-component 'doc-string-elt '2)

(put 'ergoemacs-component 'lisp-indent-function '2)

(autoload 'ergoemacs-theme-component "ergoemacs-macros" "\
A component of an ergoemacs-theme.

\(fn &rest BODY-AND-PLIST)" nil t)

(put 'ergoemacs-theme-component 'doc-string-elt '2)

(put 'ergoemacs-theme-component 'lisp-indent-function '2)

(autoload 'ergoemacs-test-layout "ergoemacs-macros" "\


\(fn &rest KEYS-AND-BODY)" nil t)

(autoload 'ergoemacs-theme "ergoemacs-macros" "\
Define an ergoemacs-theme.
:components -- list of components that this theme uses. These can't be seen or toggled
:optional-on -- list of components that are optional and are on by default
:optional-off -- list of components that are optional and off by default
:options-menu -- Menu options list
:silent -- If this theme is \"silent\", i.e. doesn't show up in the Themes menu.

:based-on

The rest of the body is an `ergoemacs-theme-component' named THEME-NAME-theme

\(fn &rest BODY-AND-PLIST)" nil t)

(put 'ergoemacs-theme 'doc-string-elt '2)

(put 'ergoemacs-theme 'lisp-indent-function '2)

(autoload 'ergoemacs-deftheme "ergoemacs-macros" "\
Creates a theme layout for Ergoemacs keybindings -- Compatability layer.

NAME is the theme name.
_DESC is the theme description and is currently ignored.
BASED-ON is the base name theme that the new theme is based on.

DIFFERENCES are the differences from the layout based on the functions.  These are based on the following functions:

`ergoemacs-key' = defines/replaces variable key with function by (ergoemacs-key QWERTY-KEY FUNCTION DESCRIPTION ONLY-FIRST)
`ergoemacs-fixed-key' = defines/replace fixed key with function by (ergoemacs-fixed-key KEY FUNCTION DESCRIPTION)

\(fn NAME DESC BASED-ON &rest DIFFERENCES)" nil t)

(put 'ergoemacs-deftheme 'lisp-indent-function '1)

(autoload 'ergoemacs-save-buffer-state "ergoemacs-macros" "\
Eval BODY,
then restore the buffer state under the assumption that no significant
modification has been made in BODY.  A change is considered
significant if it affects the buffer text in any way that isn't
completely restored again.  Changes in text properties like `face' or
`syntax-table' are considered insignificant.  This macro allows text
properties to be changed, even in a read-only buffer.

This macro should be placed around all calculations which set
\"insignificant\" text properties in a buffer, even when the buffer is
known to be writeable.  That way, these text properties remain set
even if the user undoes the command which set them.

This macro should ALWAYS be placed around \"temporary\" internal buffer
changes (like adding a newline to calculate a text-property then
deleting it again), so that the user never sees them on his
`buffer-undo-list'.  

However, any user-visible changes to the buffer (like auto-newlines)
must not be within a `ergoemacs-save-buffer-state', since the user then
wouldn't be able to undo them.

The return value is the value of the last form in BODY.

This was stole/modified from `c-save-buffer-state'

\(fn &rest BODY)" nil t)

;;;***

;;;### (autoloads nil "ergoemacs-menus" "ergoemacs-menus.el" (21585
;;;;;;  4024 0 0))
;;; Generated autoloads from ergoemacs-menus.el

(autoload 'ergoemacs-preprocess-menu-keybindings "ergoemacs-menus" "\
Put `ergoemacs-mode' key bindings on menus.

\(fn MENU)" nil nil)

;;;***

;;;### (autoloads nil "ergoemacs-mode" "ergoemacs-mode.el" (21585
;;;;;;  4024 0 0))
;;; Generated autoloads from ergoemacs-mode.el

(defvar ergoemacs-mode nil "\
Non-nil if Ergoemacs mode is enabled.
See the command `ergoemacs-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ergoemacs-mode'.")

(custom-autoload 'ergoemacs-mode "ergoemacs-mode" nil)

(autoload 'ergoemacs-mode "ergoemacs-mode" "\
Toggle ergoemacs keybinding minor mode.
This minor mode changes your emacs keybinding.

Without argument, toggles the minor mode.
If optional argument is 1, turn it on.
If optional argument is 0, turn it off.

Home page URL `http://ergoemacs.github.io/'

The `execute-extended-command' is now \\[execute-extended-command].

The layout and theme changes the bindings.  For the current
bindings the keymap is:

\\{ergoemacs-keymap}

\(fn &optional ARG)" t nil)

(autoload 'ergoemacs-mode-start "ergoemacs-mode" "\
Start `ergoemacs-mode' if not already started.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "ergoemacs-test" "ergoemacs-test.el" (21585
;;;;;;  4024 0 0))
;;; Generated autoloads from ergoemacs-test.el

(autoload 'ergoemacs-test "ergoemacs-test" "\
Test ergoemacs issues.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "ergoemacs-theme-engine" "ergoemacs-theme-engine.el"
;;;;;;  (21585 4024 0 0))
;;; Generated autoloads from ergoemacs-theme-engine.el

(autoload 'ergoemacs-set "ergoemacs-theme-engine" "\
Sets VARIABLE to VALUE without disturbing customize or setq.
If FORCE is true, set it even if it changed.

\(fn VARIABLE VALUE &optional FORCE)" nil nil)

(autoload 'ergoemacs-save "ergoemacs-theme-engine" "\
Set VARIABLE to VALUE and tell customize it needs to be saved.

\(fn VARIABLE VALUE)" nil nil)

(autoload 'ergoemacs-theme-component--create-component "ergoemacs-theme-engine" "\


\(fn PLIST BODY)" nil nil)

(autoload 'ergoemacs-theme-option-off "ergoemacs-theme-engine" "\
Turns OPTION off.
Uses `ergoemacs-theme-option-on'.

\(fn OPTION &optional NO-CUSTOM)" nil nil)

(autoload 'ergoemacs-theme-option-on "ergoemacs-theme-engine" "\
Turns OPTION on.
When OPTION is a list turn on all the options in the list
If OFF is non-nil, turn off the options instead.

\(fn OPTION &optional NO-CUSTOM OFF)" nil nil)

(autoload 'ergoemacs-key "ergoemacs-theme-engine" "\
Defines KEY in ergoemacs keyboard based on QWERTY and binds to FUNCTION.
_DESC is ignored, as is _FIXED-KEY.

\(fn KEY FUNCTION &optional DESC ONLY-FIRST FIXED-KEY)" nil nil)

;;;***

;;;### (autoloads nil "ergoemacs-unbind" "ergoemacs-unbind.el" (21585
;;;;;;  4024 0 0))
;;; Generated autoloads from ergoemacs-unbind.el

(autoload 'ergoemacs-ignore-prev-global "ergoemacs-unbind" "\
Ignore previously defined global keys.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("ergoemacs-advices.el" "ergoemacs-layouts.el"
;;;;;;  "ergoemacs-modal.el" "ergoemacs-mode-pkg.el" "ergoemacs-shortcuts.el"
;;;;;;  "ergoemacs-themes.el" "ergoemacs-track.el" "ergoemacs-translate.el")
;;;;;;  (21585 4024 638812 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ergoemacs-mode-autoloads.el ends here
