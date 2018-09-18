;; auto-dictionary
(defun spell-checking/change-dictionary ()
  "Change the dictionary. Use the ispell version if
auto-dictionary is not used, use the adict version otherwise."
  (interactive)
  (if (fboundp 'adict-change-dictionary)
      (adict-change-dictionary)
    (call-interactively 'ispell-change-dictionary)))

(defun def-word ()
    (interactive)
    (eww (concat "https://www.merriam-webster.com/dictionary/" (thing-at-point 'word))))

(use-package flyspell
  :ensure t
  :commands (flyspell-mode flyspell-prog-mode)
  :init
  (progn
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)
    (general-define-key
     :prefix "<f7>"
     "S"  '(:ignore t :which-key "Spelling")
     )
    (general-define-key
     :prefix "<f7> S"
     "b" 'flyspell-buffer
     "d" 'def-word
     "D" 'spell-checking/change-dictionary
     "n" 'flyspell-goto-next-error
     "t" '(flyspell-mode :which-key "toggle")
     ;; order alphabetically
     "T" '(flyspell-prog-mode :which-key "toggle-prog"))
    )
  )
(use-package flyspell-correct
  :ensure t
  :commands (flyspell-correct-word-generic
             flyspell-correct-previous-word-generic)
  :init
  (general-define-key
   :prefix "<f7> S"
   "c" 'flyspell-correct-previous-word-generic))

(use-package flyspell-correct-helm
  :ensure t
  :commands (flyspell-correct-helm)
  :init
  (setq flyspell-correct-interface #'flyspell-correct-helm))

(provide 'g-spell)
