(use-package async
  :ensure t)

(use-package posframe
  :ensure t)


(use-package ivy
  :ensure t)

(ivy-mode 1)

(use-package counsel
  :ensure t)

(use-package ivy-rich
  :ensure t)
(ivy-rich-mode 1)
;; Fix their integration
;; (use-package all-the-icons-ivy
;;   :ensure t
;;   :config
;;   (all-the-icons-ivy-setup))


(use-package ivy-hydra
  :ensure t)

;; to sort counsel-M-x by frequently used
(use-package smex
  :ensure t)
(smex-initialize)

(general-define-key
 :prefix "<f7> /"
 "b" 'ivy-switch-buffer
 "f" 'counsel-find-file
 "v" 'counsel-yank-pop
 "s" 'swiper
 "x" 'counsel-M-x
 "r" 'counsel-recentf
 "a" 'counsel-ag
 "c" 'ivy-resume
 )

(use-package flyspell-correct-ivy
  :ensure t)
(setq flyspell-correct-interface #'flyspell-correct-ivy)

;; prog
;; helm-xref
;; This does not work. Seems a problem with helm-mode 1
(use-package ivy-xref
  :ensure t
  :init
  ;; xref initialization is different in Emacs 27 - there are two different
  ;; variables which can be set rather than just one
  (when (>= emacs-major-version 27)
    (setq xref-show-definitions-function #'ivy-xref-show-defs))
  ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
  ;; commands other than xref-find-definitions (e.g. project-find-regexp)
  ;; as well
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

;; This is only a program to run dired there
;; dired (setq helm-ff-default-directory (dired-current-directory))
;; g-dired.el 102:           (helm-ff-switch-to-eshell nil))))

;; mail
;; to jump to folders using helm
;;  (setq mu4e-completing-read-function 'completing-read)
;; helm-mu 
;; heml-mu-contacts


;; eshell
;; setup-eshell-helm-completion
(add-hook 'eshell-mode-hook
          (lambda ()
            (general-define-key
             :keymaps 'eshell-mode-map
             :prefix "<f7>"
             "<down>"  'counsel-esh-history
             )
            ))
(defun setup-eshell ()
  (define-key eshell-mode-map [remap eshell-pcomplete] 'completion-at-point))
(add-hook 'eshell-mode-hook 'setup-eshell)             
;; fix size of completition


;; helm-grep-do-git-grep	counsel-git-grep	search regexp in current project
;; helm-projectile	counsel-projectile	search project and file in it
;; helm-ls-git-ls	counsel-git	search file in current git project
;; helm-themes	counsel-load-theme	switch themes
;; helm-descbinds	counsel-descbinds	describe keybindings and associated functions



(use-package ivy-posframe
  :ensure t)
;; display at `ivy-posframe-style'
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-point)))

(ivy-posframe-mode 1)

(use-package ace-window
  :ensure t)
