(menu-bar-mode -1)
;; sometimes does not work
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; (use-package powerline
;;   :ensure t
;;   )
;; (use-package spaceline
;;   :ensure t
;;   :config
;;   (spaceline-emacs-theme)
;;   (spaceline-helm-mode)
;;   )

(defun g-toggle-dark-light ()
  (interactive)
  ;; use a property “state”. Value is t or nil
  (if (get 'g-toggle-dark-light 'state)
      (progn
        (load-theme 'default t)
        (put 'g-toggle-dark-light 'state nil))
    (progn
        (moe-dark)
        (put 'g-toggle-dark-light 'state t))))

(general-define-key
 :prefix "<f7> t"
 "l"  'g-toggle-dark-light)

(use-package moe-theme
  :ensure t
  :commands (moe-dark)
  :config
  (setq moe-theme-highlight-buffer-id t)
    
  ;;(moe-dark)
;;  (moe-light)
;;  (powerline-moe-theme)
  )

;; (use-package doom-themes
;;   :ensure t
;;   :init
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   :config
;;   ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;;   ;; may have their own settings.
;;   (menu-bar-mode -1)
;;   ;; sometimes does not work
;;   (toggle-scroll-bar -1)
;;   (tool-bar-mode -1)
;;   ;; (load-theme 'doom-one t)
;;   (load-theme 'doom-dracula t)
;;   ;; (load-theme 'doom-opera-light t)

;;   ;; Enable flashing mode-line on errors
;;   ;; (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   ;; (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   ;; (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   ;; (doom-themes-org-config)
;;   ;; look at https://github.com/hlissner/emacs-solaire-mode
;;   ;; (use-package hlinum :ensure t)
;;   ;; (hlinum-activate)
;; )

(use-package solaire-mode
  :ensure t
  :hook ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
  :requires doom-themes
  :config
  (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)
  (solaire-mode-swap-bg)
  )




(provide 'g-theme)
