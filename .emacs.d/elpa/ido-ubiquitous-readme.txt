If you use the excellent `ido-mode' for efficient completion of
file names and buffers, you might wonder if you can get ido-style
completion everywhere else too. Well, that's what this package
does! ido-ubiquitous is here to enable ido-style completion for
(almost) every function that uses the standard completion function
`completing-read'.

To use this package, call `ido-ubiquitous-mode' to enable the mode,
or use `M-x customize-variable ido-ubiquitous-mode' it to enable it
permanently. Note that `ido-ubiquotous-mode' has no effect unless
`ido-mode' is also enabled. Once the mode is enabled, most
functions that use `completing-read' will now have ido completion.
If you decide in the middle of a command that you would rather not
use ido, just C-f or C-b at the end/beginning of the input to fall
back to non-ido completion (this is the same shortcut as when using
ido for buffers or files).

Note that `completing-read' has some quirks and complex behavior
that ido cannot emulate. Ido-ubiquitous attempts to detect some of
these quirks and avoid using ido when it sees them. So some
functions will not have ido completion even when this mode is
enabled. Some other functions have ido disabled in them because
their packages already provide support for ido via other means (for
example, org-mode and magit). See `M-x customize-group
ido-ubiquitous' and read about the override variables for more
information.
