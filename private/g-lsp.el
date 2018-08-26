(use-package lsp-mode
  :ensure t
  :init
  ;;(add-hook 'lsp-after-open-hook #'imenu-list)
)

(use-package flycheck
  :ensure t
  )


(use-package lsp-ui
  :ensure t
  :commands (lsp-ui-mode)
  :init
  (progn
    (add-hook 'lsp-mode-hook #'lsp-ui-mode)
    (setq lsp-ui-doc-enable nil)
    )
  )

(provide 'g-lsp)

