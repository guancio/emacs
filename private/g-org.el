(setq org-replace-disputed-keys t)

(setq org-default-notes-file "~/Desktop/organizer.org")

(add-hook 'org-mode-hook 'auto-fill-mode)

(general-define-key
 :keymaps 'org-mode-map
 :prefix "<f7> m"
 "e p" 'org-latex-export-to-pdf
 ;; what to do with the other 2000 keymaps?
 )

(general-define-key
 :prefix "<f7> o"
 "c" 'org-capture
 )

(use-package ox-reveal
  :load-path "/home/guancio/emacs-test/private/org-reveal"
  :commands (org-reveal-export-to-html org-export-dispatch)
  :init
  (general-define-key
   :keymaps 'org-mode-map
   :prefix "<f7> m"
   "e r" 'org-reveal-export-to-html
   )
  )

(provide 'g-org)
