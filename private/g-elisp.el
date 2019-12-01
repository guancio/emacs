(general-define-key
 :keymaps 'emacs-lisp-mode-map
 :prefix "<f7> m"
 "r"  'eval-region
 "b"  'eval-buffer
 "e"  'eval-last-sexp
 )

(setq-default indent-tabs-mode nil)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(provide 'g-elisp)
