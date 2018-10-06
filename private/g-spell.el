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


(defhydra hydra-spelling (:color blue)
  "
  ^
  ^Spelling^          ^Errors^            ^Checker^
  ^────────^──────────^──────^────────────^───────^───────
  _q_ quit            _p_ previous        _c_ correction
  ^^                  _n_ next            _d_ dictionary
  ^^                  _b_ buffer          ^^
  ^^                  ^^                  ^^
  "
  ("q" nil)
  ("p" evil-prev-flyspell-error :color pink)
  ("n" evil-next-flyspell-error :color pink)
  ("c" flyspell-correct-previous-word-generic)
  ("d" spell-checking/change-dictionary)
  ("b" flyspell-buffer))


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
     "." 'hydra-spelling/body
    )
    (general-define-key
     :prefix "<f7> t"
     "S" '(flyspell-mode :which-key "spelling")
     "T" '(flyspell-prog-mode :which-key "prog-spelling"))
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
