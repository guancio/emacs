(general-define-key
 :keymaps 'emacs-lisp-mode-map
 :prefix "<f7> m"
 "r"  'eval-region
 "b"  'eval-buffer
 "e"  'eval-last-sexp
 )

(provide 'g-elisp)
