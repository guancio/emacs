;; all-the-icons does not work
;; (insert (all-the-icons-icon-for-file "Code.js" :height 2.0))
(use-package all-the-icons-dired
  :ensure t
  :commands (all-the-icons-dired-mode)
  :init
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  :config
  (require 'font-lock)
  (use-package font-lock+
    :load-path "/home/guancio/emacs-test/private/font-lock-plus")
  (use-package all-the-icons
    :ensure t)
  )



(defun g/find-select-window (arg)
  (let ((file (dired-get-file-for-visit)))
    (winum-select-window-by-number arg)
    (find-file file)))
(defun g/find-select-window-1 ()
  (interactive)
  (g/find-select-window 1))
(defun g/find-select-window-2 ()
  (interactive)
  (g/find-select-window 2))
(defun g/find-select-window-3 ()
  (interactive)
  (g/find-select-window 3))
(defun g/find-select-window-4 ()
  (interactive)
  (g/find-select-window 4))
(defun g/find-select-window-5 ()
  (interactive)
  (g/find-select-window 5))
(defun g/find-select-window-6 ()
  (interactive)
  (g/find-select-window 6))
(defun g/find-select-window-7 ()
  (interactive)
  (g/find-select-window 7))
(defun g/find-select-window-8 ()
  (interactive)
  (g/find-select-window 8))
(defun g/find-select-window-9 ()
  (interactive)
  (g/find-select-window 9))

  
(setq dired-dwim-target t)
;; However, now also rename has the other director
(setq dired-compress-files-alist
      '(("\\.tar\\.gz\\'" . "tar -c %i | gzip -c9 > %o")
        ("\\.tgz\\'" . "tar -c %i | gzip -c9 > %o")
        ("\\.zip\\'" . "zip %o -r --filesync %i")
        ))

(defun my-dired-mode-hook ()
  (progn
   (auto-revert-mode t)
  ))

(add-hook 'dired-mode-hook 'my-dired-mode-hook)


;; TODO: avoid repetition
(general-define-key
 :keymaps 'dired-mode-map
 "<backspace>" 'dired-up-directory
 "<tab>" 'dired-hide-subdir
 "&" 'dired-do-async-shell-command
 "+" 'dired-create-directory
 "=" 'dired-diff
 "C" 'dired-do-copy
 "D" 'dired-do-delete
 "G" 'dired-do-chgrp
 "H" 'dired-do-find-regexp-and-replace
 "L" 'dired-do-symlink
 "M" 'dired-do-chmod
 "O" 'dired-do-chown
 "R" 'dired-do-rename
 "S" 'dired-do-find-regexp
 "U" 'dired-unmark-all-marks
 "X" 'dired-do-shell-command
 "Z" '(dired-do-compress :which-key "(de)compress")
 "d" 'dired-flag-file-deletion
 "e" 'dired-toggle-read-only
 "g" 'revert-buffer
 "h" 'describe-mode
 "k" '((lambda () (interactive) (dired-do-kill-lines t)) :which-key "remove")
 ;; does not show icons
 "i" 'dired-maybe-insert-subdir
 "m" 'dired-mark
 "q" 'quit-window
 "u" 'dired-unmark
 "x" 'dired-do-flagged-delete
 "z" 'dired-do-compress-to
 "y" 'dired-show-file-type
 )

(general-define-key
 :keymaps 'dired-mode-map
 :prefix "o"
 "" '(nil :which-key "Open")
 "1" 'g/find-select-window-1
 "2" 'g/find-select-window-2
 "3" 'g/find-select-window-3
 "4" 'g/find-select-window-4
 "5" 'g/find-select-window-5
 "6" 'g/find-select-window-6
 "7" 'g/find-select-window-7
 "8" 'g/find-select-window-8
 "9" 'g/find-select-window-9
)
(general-define-key
 :keymaps 'dired-mode-map
 :prefix "r"
 "" '(nil :which-key "Regexp")
 "r &" 'dired-flag-garbage-files
 "r C" 'dired-do-copy-regexp
 "r H" 'dired-do-hardlink-regexp
 "r R" 'dired-do-rename-regexp
 "r S" 'dired-do-symlink-regexp
 "r d" 'dired-flag-files-regexp
 "r g" 'dired-mark-files-containing-regexp
 "r l" 'dired-downcase
 "r m" 'dired-mark-files-regexp
 "r r" 'dired-do-rename-regexp
 "r u" 'dired-upcase
)

(general-define-key
 :keymaps 'dired-mode-map
 :prefix "<f7> m"
 "<backspace>" 'dired-up-directory
 "<tab>" 'dired-hide-subdir
 "&" 'dired-do-async-shell-command
 "+" 'dired-create-directory
 "=" 'dired-diff
 "C" 'dired-do-copy
 "D" 'dired-do-delete
 "G" 'dired-do-chgrp
 "H" 'dired-do-find-regexp-and-replace
 "L" 'dired-do-symlink
 "M" 'dired-do-chmod
 "O" 'dired-do-chown
 "R" 'dired-do-rename
 "S" 'dired-do-find-regexp
 "U" 'dired-unmark-all-marks
 "X" 'dired-do-shell-command
 "Z" '(dired-do-compress :which-key "(de)compress")
 "d" 'dired-flag-file-deletion
 "e" 'dired-toggle-read-only
 "g" 'revert-buffer
 "h" 'describe-mode
 "k" '((lambda () (interactive) (dired-do-kill-lines t)) :which-key "remove")
 ;; does not show icons
 "i" 'dired-maybe-insert-subdir
 "m" 'dired-mark
 "o" '(:ignore t :which-key "open")
 "o 1" 'g/find-select-window-1
 "o 2" 'g/find-select-window-2
 "o 3" 'g/find-select-window-3
 "o 4" 'g/find-select-window-4
 "o 5" 'g/find-select-window-5
 "o 6" 'g/find-select-window-6
 "o 7" 'g/find-select-window-7
 "o 8" 'g/find-select-window-8
 "o 9" 'g/find-select-window-9
 
 "q" 'quit-window
 "u" 'dired-unmark
 "x" 'dired-do-flagged-delete
 "z" 'dired-do-compress-to
 "y" 'dired-show-file-type

 "r"  '(:ignore t :which-key "Regexp")
 "r &" 'dired-flag-garbage-files
 "r C" 'dired-do-copy-regexp
 "r H" 'dired-do-hardlink-regexp
 "r R" 'dired-do-rename-regexp
 "r S" 'dired-do-symlink-regexp
 "r d" 'dired-flag-files-regexp
 "r g" 'dired-mark-files-containing-regexp
 "r l" 'dired-downcase
 "r m" 'dired-mark-files-regexp
 "r r" 'dired-do-rename-regexp
 "r u" 'dired-upcase
 )

(general-define-key
 :keymaps 'wdired-mode-map
 :prefix "<f7> m"
 "b" 'wdired-finish-edit
)

(general-define-key
 :keymaps 'dired-mode-map
 :prefix "<f7> t"
 "d" 'dired-hide-details-mode
 )
;; open new dired accoring to details

(use-package dired-sort
  :load-path "/home/guancio/emacs-test/private/dired-sort"
  :commands (dired-sort-size dired-sort-extension dired-sort-ctime
			     dired-sort-utime dired-sort-time dired-sort-name)
  :init
  (general-define-key
   :keymaps 'dired-mode-map
   :prefix "<f7> m"
   "s" '(:ignore t :which-key "Sort")
   "s s" 'dired-sort-size
   "s e" 'dired-sort-extension
   "s c" 'dired-sort-ctime
   "s a" 'dired-sort-utime
   "s d" 'dired-sort-time
   "s n" 'dired-sort-name
   )
  (general-define-key
   :keymaps 'dired-mode-map
   :prefix "s"
   "" '(nil :which-key "Sort")
   "s" 'dired-sort-size
   "e" 'dired-sort-extension
   "c" 'dired-sort-ctime
   "a" 'dired-sort-utime
   "d" 'dired-sort-time
   "n" 'dired-sort-name
   )
  )

(use-package dired-du
  :ensure t
  :init
  (general-define-key
   :keymaps 'dired-mode-map
   :prefix "<f7> t"
   "s" 'dired-du-mode
   "r" 'dired-du--toggle-human-readable
  ))


;; (use-package sunrise-commander
;;   :load-path "/home/guancio/emacs-test/private/sunrise-commander")

(provide 'g-dired)
