google-this is a package that provides a set of functions and
keybindings for launching google searches from within Emacs.

The main function is `google-this' (bound to C-c / g). It does a
google search using the currently selected region, or the
expression under point. All functions are bound under "C-c /"
prefix, in order to comply with Emacs' standards. If that's a
problem see `google-this-keybind'. To view all keybindings type "C-c
/ C-h".

If you don't like this keybind, just reassign the
`google-this-mode-submap' variable.
My personal preference is "C-x g":

       (global-set-key (kbd "C-x g") 'google-this-mode-submap)

Or, if you don't want google-this to overwrite the default ("C-c /")
key insert the following line BEFORE everything else (even before
the `require' command):

       (setq google-this-keybind (kbd "C-x g"))


To start a blank search, do `google-search' (C-c / RET). If you
want more control of what "under point" means for the `google-this'
command, there are the `google-word', `google-symbol',
`google-line' and `google-region' functions, bound as w, s, l and space,
respectively. They all do a search for what's under point.

If the `google-wrap-in-quotes' variable is t, than searches are
enclosed by double quotes (default is NOT). If a prefix argument is
given to any of the functions, invert the effect of
`google-wrap-in-quotes'.

There is also a `google-error' (C-c / e) function. It checks the
current error in the compilation buffer, tries to do some parsing
(to remove file name, line number, etc), and googles it. It's still
experimental, and has only really been tested with gcc error
reports.

Finally there's also a google-cpp-reference function (C-c / r).

Instructions:

INSTALLATION

 Make sure "google-this.el" is in your load path, then place
     this code in your .emacs file:
		(require 'google-this)
             (google-this-mode 1)


This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
