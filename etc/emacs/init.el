;;; init.el

(require 'org)
(org-babel-load-file
 (expand-file-name "config.org"
                   user-emacs-directory))
