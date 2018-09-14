(setq org-replace-disputed-keys t)

(setq org-default-notes-file "~/Desktop/organizer.org")

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
  :init
  (general-define-key
   :keymaps 'org-mode-map
   :prefix "<f7> m"
   "e s" 'org-reveal-export-to-html
   ;; what to do with the other 2000 keymaps?
   )
  )

(provide 'g-org)
