(use-package lsp-mode
  :ensure t
  :commands (lsp-mode)
  :init
  ;;(add-hook 'lsp-after-open-hook #'imenu-list)
  )

(use-package flycheck
  :ensure t
  :commands (flycheck-mode)
  )


(use-package company
  :ensure t
  :commands (company-mode)
  )

(use-package lsp-ui
  :ensure t
  :commands (lsp-ui-mode)
  :init
  (progn
    (add-hook 'lsp-mode-hook #'lsp-ui-mode)
    (setq lsp-ui-doc-enable nil)
    )

  :config 
  (use-package company-lsp
    :ensure t
    :init
    (push 'company-lsp company-backends)
    )
  )

(provide 'g-lsp)

;;     "gd" 'lsp-ui-peek-find-definitions
;;     "gr" 'lsp-ui-peek-find-references
