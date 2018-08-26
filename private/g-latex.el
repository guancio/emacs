;; Should be created after loading auctex
(defun latex/build ()
  (interactive)
  (progn
    (let ((TeX-save-query nil))
      (TeX-save-document (TeX-master-file)))
    (TeX-command "LaTeX" 'TeX-master-file -1)))
(defun latex//autofill ()
  "Check whether the pointer is currently inside one of the
environments described in `latex-nofill-env' and if so, inhibits
the automatic filling of the current paragraph."
  (let ((do-auto-fill t)
        (current-environment "")
        (level 0))
    (while (and do-auto-fill (not (string= current-environment "document")))
      (setq level (1+ level)
            current-environment (LaTeX-current-environment level)
            do-auto-fill (not (member current-environment latex-nofill-env))))
    (when do-auto-fill
      (do-auto-fill))))
(defun latex/auto-fill-mode ()
  "Toggle auto-fill-mode using the custom auto-fill function."
  (interactive)
  (auto-fill-mode)
  (setq auto-fill-function 'latex//autofill))


(use-package auctex
  :ensure t
  :defer t
  :init
  (progn
    (setq TeX-command-default "LaTeX"
          TeX-auto-save t
          TeX-parse-self t
          TeX-syntactic-comment t
          ;; Don't insert line-break at inline math
          LaTeX-fill-break-at-separators nil
          TeX-source-correlate-start-server t
          ;; Use pdf-tools to open PDF files
          TeX-view-program-selection '((output-pdf "PDF Tools"))
          )
    (setq-default TeX-master nil)
    (add-hook 'LaTeX-mode-hook 'latex/auto-fill-mode)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
    (add-hook 'LaTeX-mode-hook 'smartparens-mode)
    (add-hook 'LaTeX-mode-hook 'flyspell-mode)
    (add-hook 'LaTeX-mode-hook 'flyspell-buffer)
    ;; Update PDF buffers after successful LaTeX runs
    (add-hook 'TeX-after-compilation-finished-functions
              #'TeX-revert-document-buffer)
    ;; Should this be in :config?
    (general-define-key
     :keymaps 'LaTeX-mode-map
     :prefix "<f7> m"
     "-" 'TeX-recenter-output-buffer
     "`" 'TeX-next-error
     ;; maybe these two should me in text section
     "%" 'TeX-comment-or-uncomment-paragraph
     ";" 'TeX-comment-or-uncomment-region
     ;; TeX-command-run-all runs compile and open the viewer
     "a" 'TeX-command-run-all
     "b" 'latex/build
     "k" 'TeX-kill-job                                ;; C-c C-k
     "l" 'TeX-recenter-output-buffer                  ;; C-c C-l
     "m" 'TeX-insert-macro                            ;; C-c C-m
     "v" 'TeX-view                                    ;; C-c C-v
     ;; what to do with the other 2000 keymaps?
     )
    )
  )

(use-package pdf-tools
  :ensure t
  :defer t
  :mode (("\\.pdf\\'" . pdf-view-mode))
  :config
  (progn
    (pdf-tools-install)
    (add-hook 'pdf-view-mode-hook 'auto-revert-mode)
    ;; Binding is quite complicated. See the layer
    ))


;; (defun latex/init-reftex ()
;;   (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;   (setq reftex-plug-into-AUCTeX '(nil nil t t t)
;;         reftex-use-fonts t)
;;   (spacemacs/declare-prefix-for-mode 'latex-mode "mr" "reftex")
;;   (spacemacs/set-leader-keys-for-major-mode 'latex-mode
;;     "rc"    'reftex-citation
;;     "rg"    'reftex-grep-document
;;     "ri"    'reftex-index-selection-or-word
;;     "rI"    'reftex-display-index
;;     "r TAB" 'reftex-index
;;     "rl"    'reftex-label
;;     "rp"    'reftex-index-phrase-selection-or-word
;;     "rP"    'reftex-index-visit-phrases-buffer
;;     "rr"    'reftex-reference
;;     "rs"    'reftex-search-document
;;     "rt"    'reftex-toc
;;     "rT"    'reftex-toc-recenter
;;     "rv"    'reftex-view-crossref))

;; (defun latex/post-init-helm-gtags ()
;;   (spacemacs/helm-gtags-define-keys-for-mode 'latex-mode))

;; (defun latex/post-init-ggtags ()
;;   (add-hook 'latex-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

;; (defun latex/post-init-company ()
;;   (spacemacs|add-company-hook LaTeX-mode))

;; (defun latex/init-company-auctex ()
;;   (use-package company-auctex
;;     :defer t
;;     :init
;;     (progn
;;       (push 'company-auctex-labels company-backends-LaTeX-mode)
;;       (push 'company-auctex-bibs company-backends-LaTeX-mode)
;;       (push '(company-auctex-macros
;;               company-auctex-symbols
;;               company-auctex-environments) company-backends-LaTeX-mode))))

;; (defun latex/post-init-flycheck ()
;;   (spacemacs/add-flycheck-hook 'LaTeX-mode))

;; (defun latex/post-init-yasnippet ()
;;   (add-hook 'LaTeX-mode-hook 'spacemacs/load-yasnippet))

(provide 'g-latex)
