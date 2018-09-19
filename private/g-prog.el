(general-define-key
 :keymaps 'prog-mode-map
 :prefix "<f7>"
 "gR" 'xref-find-references
 "td" 'eldoc-mode
 "ts" 'whitespace-mode
 )

(use-package helm-xref
  :ensure t
  :commands (xref-find-references)
  :init
  (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
  )

(provide 'g-prog)
