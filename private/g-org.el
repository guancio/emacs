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
 "c" '((lambda () (interactive)
         (let ((b (get-file-buffer org-default-notes-file)))
           (if b
               (with-current-buffer b
                 (revert-buffer t t t)))
           (org-capture))) :which-key "capture")
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

(defun g-org-mode-hook ()
  (if (equal
       (file-truename org-default-notes-file)
         (buffer-file-name))
      (auto-revert-mode 1)))


(add-hook 'org-mode-hook 'g-org-mode-hook)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (python . t)))

(use-package htmlize
  :ensure t)

(provide 'g-org)
