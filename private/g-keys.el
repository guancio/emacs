(use-package general
  :ensure t
  :init
  (progn
    (global-unset-key (kbd "M-SPC"))
    (general-define-key
     :prefix "<f7>"
     "a"  '(:ignore t :which-key "Applications")
     "b"  '(:ignore t :which-key "Buffers")
     "bb" 'helm-mini
     ;;"bd" 'kill-buffer
     "f"  '(:ignore t :which-key "Files")
     "ff" 'helm-find-files
     "g"  '(:ignore t :which-key "Go")
     "gd" 'lsp-ui-peek-find-definitions
     "gr" 'lsp-ui-peek-find-references
     "gR" 'xref-find-references
     "gi" 'helm-imenu
     ;; does not work
     ;; "ga" 'xref-find-apropos
     "m"  '(:ignore t :which-key "Mode")
     "t"  '(:ignore t :which-key "Toggle")     
     "td"  'eldoc-mode
     ;; flyckeck buffer
     ;; company / company with doc
     )
    (general-define-key
     "C-y" 'undo-tree-redo)
    ))
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-S-v") #'helm-show-kill-ring)

(use-package which-key :ensure t
  :config
  (progn
    (setq which-key-idle-delay 0.5)
    (which-key-mode)))

(helm-mode 1)
;; open helm on the bottom
(setq helm-always-two-windows nil)
(setq helm-display-buffer-default-height 23)
(setq helm-default-display-buffer-functions '(display-buffer-in-side-window))

(use-package helm-xref
  :ensure t
  :init
  (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
  )

;; tab complete in helm?

(provide 'g-keys)
