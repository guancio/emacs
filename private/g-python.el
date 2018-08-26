(use-package imenu-list
  :ensure t
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
 "r"  'run-python
 "b"  'python-shell-send-buffer
 )


(use-package lsp-python
  :ensure t
  :commands (lsp-python-enable)
  :init
  (progn
    (add-hook 'python-mode-hook #'lsp-python-enable)
    (add-hook 'python-mode-hook #'flycheck-mode)
    (add-hook 'python-mode-hook #'company-mode)
    )
  )

(use-package company
  :ensure t
  )
(use-package company-lsp
  :ensure t
  :init
  (push 'company-lsp company-backends)
  )


;; disable warning if there is no project
;; disable lsp-ui-doc-mode and re-enable ElDoc

(provide 'g-python)
