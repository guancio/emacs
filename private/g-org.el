(setq org-replace-disputed-keys t)

(setq org-default-notes-file "~/Desktop/organizer.org")

(general-define-key
 :keymaps 'org-mode-map
 :prefix "<f7> m"
 "e p" 'org-latex-export-to-pdf
 "e h" 'org-html-export-to-html
 "-" 'org-shiftleft
 "=" 'org-shiftright
 "r" 'org-refile
 "l" 'org-insert-link
 ;; what to do with the other 2000 keymaps?
 )

(general-define-key
 :prefix "<f7> o"
 "c" 'org-capture
 "l" 'org-store-link
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


(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)))


(provide 'g-org)
