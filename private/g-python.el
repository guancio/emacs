(use-package imenu-list
  :ensure t
  :commands (imenu-list-smart-toggle)
  :init
  ;; It does not work. I must open it manually and update it manually
  ;; (add-hook 'python-mode-hook #'imenu-list)
  (general-define-key
     :prefix "<f7> t"
     "i"  'imenu-list-smart-toggle
     )
  )

(general-define-key
 :keymaps 'python-mode-map
 :prefix "<f7> m"
 "x"  'run-python
 "r"  'python-shell-send-region
 "b"  'python-shell-send-buffer
 )


;; (use-package lsp-python
;;   :ensure t
;;   :commands (lsp-python-enable)
;;   :init
;;   (progn
;;     (add-hook 'python-mode-hook #'lsp-python-enable)
;;     (add-hook 'python-mode-hook #'flycheck-mode)
;;     (add-hook 'python-mode-hook #'company-mode)
;;     )
;;   )


(use-package eglot
  :ensure t
  :commands (eglot)
  :init
  (add-hook 'python-mode-hook #'company-mode)
  )


(provide 'g-python)
