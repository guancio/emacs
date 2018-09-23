(defun eshell-new()
  "Open a new instance of eshell."
  (interactive)
  (eshell 'Z))

(general-define-key
 :prefix "<f7>"
 "as"  'eshell
 "aS"  'eshell-new
 )

;; due to bug in eshell we cannot use a simple approach
(add-hook 'eshell-mode-hook
          (lambda ()
            (general-define-key
             :keymaps 'eshell-mode-map
             :prefix "<f7>"
             "<up>"  'helm-eshell-history
             )
            ))

;; does not work
;; (use-package esh-autosuggest
;;   :commands (esh-autosuggest-mode)
;;   :hook (eshell-mode . esh-autosuggest-mode)
;;   ;; If you have use-package-hook-name-suffix set to nil, uncomment and use the
;;   ;; line below instead:
;;   ;; :hook (eshell-mode-hook . esh-autosuggest-mode)
;;   :ensure t)

(use-package bash-completion
  :ensure t
  :init
  (bash-completion-setup)
  )

(defun setup-eshell-helm-completion ()
  (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete))

(add-hook 'eshell-mode-hook #'setup-eshell-helm-completion)

(provide 'g-shell)
