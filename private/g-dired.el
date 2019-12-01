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

(use-package wuxch-dired-copy-paste
  :load-path "/home/guancio/emacs-test/private/wuxch-dired-copy-paste/"
  )

(defhydra hydra-dired (:hint nil :color blue)
  "
Navigation^^    | Mark^^         | Actions ^^     ^^               ^^         | Shell^^    | Open   | Regexp^^                      Others
----------^^----+-----^^---------+---------^^-----^^---------------^^-------- +------^^----+--------+-------^^------------------------------------------
_q_ quit        | _._ mark       | _+_ new dir    _G_ chgrp        _x_ cut    | _&_ async  | ↩ here | mark^^        actions^^         _y_ type      
_g_ revert      | _u_ unmark     | _C_ do copy    _O_ chown        _c_ copy   | _!_ sync   | o N    | _rg_ contain  _rC_ copy           _w_ copy name 
^↩^ up          | _U_ unmark all | _D_ do delete  _M_ chmod        _v_ paste  | _E_ eshell |        | _rm_ regexp   _rH_ hardlink          _S_ search 
^⇄^ toggle      | ^ ^            | _L_ link       _Z_ (de)compress ^ ^        | ^ ^        |        | ^  ^          _rL_ link          _=_ diff   
_k_ remove line | ^ ^            | _R_ move       _z_ compress to  ^ ^        | ^ ^        |        | ^  ^          _rR_ move          _e_ edit 
_i_ insert dir  | ^ ^            | ^ ^            _a_ attach       ^ ^        | ^ ^        |        |
"
  ("g" revert-buffer :exit nil)
  ("q" quit-window)
  ("<backspace>" dired-up-directory :exit nil)
  ("<tab>" dired-hide-subdir :exit nil)
  ("k" (lambda () (interactive) (dired-do-kill-lines t)) :exit nil)
  ("i" dired-maybe-insert-subdir :exit nil)
  ("+" dired-create-directory :exit nil)
  ("C" dired-do-copy :exit nil)
  ("D" dired-do-delete :exit nil)
  ("L" dired-do-symlink :exit nil)
  ("R" dired-do-rename :exit nil)
  ("." dired-mark :exit nil)
  ("u" dired-unmark :exit nil)
  ("U" dired-unmark-all-marks :exit nil)
  ("G" dired-do-chgrp :exit nil)
  ("M" dired-do-chmod :exit nil)
  ("O" dired-do-chown :exit nil)
  ("&" dired-do-async-shell-command :exit nil)
  ("E" ((lambda () (interactive))
         (progn
           (setq helm-ff-default-directory (dired-current-directory))
           (helm-ff-switch-to-eshell nil))))
  ("!" dired-do-shell-command :exit nil)
  ("Z" dired-do-compress :exit nil)
  ("z" dired-do-compress-to :exit nil)
  ("a" gnus-dired-attach :exit nil)

  ("c" wuxch-dired-copy :exit nil)
  ("x" wuxch-dired-cut :exit nil)
  ("v" wuxch-dired-paste :exit nil)

  ("y" dired-show-file-type :exit nil)
  ("w" dired-copy-filename-as-kill :exit nil)
  ("S" dired-do-find-regexp :exit nil)
  ("=" dired-diff :exit nil)
  ("e" dired-toggle-read-only :exit nil)
  ("<RET>" dired-find-file)
  ("o1" g/find-select-window-1 :exit nil) 
  ("o2" g/find-select-window-2 :exit nil) 
  ("o3" g/find-select-window-3 :exit nil) 
  ("o4" g/find-select-window-4 :exit nil) 
  ("o5" g/find-select-window-5 :exit nil) 
  ("o6" g/find-select-window-6 :exit nil) 
  ("o7" g/find-select-window-7 :exit nil) 
  ("o8" g/find-select-window-8 :exit nil) 
  ("o9" g/find-select-window-9 :exit nil) 

  ("rC" dired-do-copy-regexp :exit nil) 
  ("rH" dired-do-hardlink-regexp :exit nil) 
  ("rR" dired-do-rename-regexp :exit nil) 
  ("rL" dired-do-symlink-regexp :exit nil) 
  ("rg" dired-mark-files-containing-regexp :exit nil) 
  ("rm" dired-mark-files-regexp :exit nil) 

  ("<up>" dired-previous-line :exit nil)
  ("<down>" dired-next-line :exit nil)
  ("<f7>m" nil)
  )
;;  "H" 'dired-do-find-regexp-and-replace
;; ("d" dired-flag-file-deletion)
;; ("X" dired-do-flagged-delete)
  ;; ("r &" dired-flag-garbage-files)

(general-define-key
 :keymaps 'dired-mode-map
 :prefix "<f7>"
 "m" 'hydra-dired/body)
 

;; TODO: avoid repetition
(general-define-key
 :keymaps 'dired-mode-map
  "G" 'revert-buffer
  "q" 'quit-window
  "<backspace>" 'dired-up-directory
  "<tab>" 'dired-hide-subdir
  ;;
   "i" 'previous-line
   "j" 'left-char
   "k" 'next-line
   "l" 'right-char
   ;;
  "k" (lambda () (interactive) (dired-do-kill-lines t))
  ;;"i" 'dired-maybe-insert-subdir
  ;; goto file
  "+" 'dired-create-directory
  "C" 'dired-do-copy
  "D" 'dired-do-delete
  "L" 'dired-do-symlink
  "R" 'dired-do-rename
  "." 'dired-mark
  "u" 'dired-unmark
  "U" 'dired-unmark-all-marks
  "G" 'dired-do-chgrp
  "M" 'dired-do-chmod
  "O" 'dired-do-chown
  "&" 'dired-do-async-shell-command
  "E" (lambda () (interactive)
         (progn
           (setq helm-ff-default-directory (dired-current-directory))
           (helm-ff-switch-to-eshell nil)))
  "!" 'dired-do-shell-command
  "Z" 'dired-do-compress
  "z" 'dired-do-compress-to
  "a" 'gnus-dired-attach

  "c" 'wuxch-dired-copy
  "x" 'wuxch-dired-cut
  "v" 'wuxch-dired-paste

  "y" 'dired-show-file-type
  "w" 'dired-copy-filename-as-kill
  "S" 'dired-do-find-regexp
  "=" 'dired-diff
  "e" 'dired-toggle-read-only
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
 "r C" 'dired-do-copy-regexp
 "r H" 'dired-do-hardlink-regexp
 "r R" 'dired-do-rename-regexp
 "r L" 'dired-do-symlink-regexp
 "r g" 'dired-mark-files-containing-regexp
 "r m" 'dired-mark-files-regexp
)
 ;; "r &" 'dired-flag-garbage-files
 ;; "r d" 'dired-flag-files-regexp
 ;; "r l" 'dired-downcase
 ;; "r u" 'dired-upcase



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
   :prefix "<f7> t"
   "s" '(:ignore t :which-key "Sort")
   "s s" 'dired-sort-size
   "s e" 'dired-sort-extension
   "s c" 'dired-sort-ctime
   "s a" 'dired-sort-utime
   "s d" 'dired-sort-time
   "s n" 'dired-sort-name
   )
  )

(use-package dired-du
  :ensure t
  :init
  (general-define-key
   :keymaps 'dired-mode-map
   :prefix "<f7> t"
   "D" '(dired-du-mode :which-key "Du (SLOW)")
   "r" 'dired-du--toggle-human-readable
  ))


(require 'gnus-dired)
;; make the `gnus-dired-mail-buffers' function also work on
;; message-mode derived modes, such as mu4e-compose-mode
(defun gnus-dired-mail-buffers ()
  "Return a list of active message buffers."
  (let (buffers)
    (save-current-buffer
      (dolist (buffer (buffer-list t))
        (set-buffer buffer)
        (when (and (derived-mode-p 'message-mode)
                (null message-sent-message-via))
          (push (buffer-name buffer) buffers))))
    (nreverse buffers)))

(setq gnus-dired-mail-mode 'mu4e-user-agent)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)


(provide 'g-dired)
