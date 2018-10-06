(use-package magit
  :ensure t
  :commands (magit-status)
  :init
  (general-define-key
   :prefix "<f7>"
     "G"  'magit-status
     )
  )

(provide 'g-git)
