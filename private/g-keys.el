(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (revert-buffer :ignore-auto)))

;; (defun start-emacs ()
;;   (interactive)
;;   (start-process-shell-command "emacs" "*emacs*" "setsid" "sh" "/home/guancio/emacs-test/run.sh"))
(defun start-emacs ()
  (interactive)
  (start-process-shell-command "emacs" "*emacs*" "setsid" "emacs26"))




(use-package hydra
  :ensure t)
(defhydra guancio-zoom ()
  "
Zoom
----------------------------------------------------------------
"
  ("=" text-scale-increase "in")
  ("-" text-scale-decrease "out")
  ("0" (lambda () (interactive)
         (text-scale-set 0)
         )
   "reset")
  )


(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
New buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc.

It returns the buffer (for elisp programing).

URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2017-11-01"
  (interactive)
  (let (($buf (generate-new-buffer "untitled")))
    (switch-to-buffer $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    $buf
    ))
(setq initial-major-mode (quote text-mode))

(use-package helm
  :ensure t
  )
(use-package helm-swoop
  :ensure t
  )

(use-package general
  :ensure t
  :init
  (progn
    (general-define-key
     :prefix "<f7>"
     "a"  '(:ignore t :which-key "Applications")
     "an"  'new-frame
     "ae" '(start-emacs :which-key "emacs")
     "aq" '(save-buffers-kill-terminal :which-key "quit")
     "b"  '(:ignore t :which-key "Buffers")
     "bb" 'helm-mini
     "bk" '((lambda () (interactive)(kill-buffer)) :which-key "kill this buffer")
     "bK" 'kill-buffer
     "f"  '(:ignore t :which-key "Files")
     "ff" 'helm-find-files
     "fa" 'save-some-buffers
     "fg" 'revert-buffer-no-confirm
     "fn" 'xah-new-empty-buffer
     "fp" 'find-file-at-point
     "fs" 'save-buffer
     "fS" 'write-file
     "g"  '(:ignore t :which-key "Go")
     "gi" 'helm-imenu
     "gl" 'goto-line
     ;; does not work
     ;; "ga" 'xref-find-apropos
     "h"  '(:ignore t :which-key "Help")
     "h k" 'describe-key
     "h K" 'which-key-show-top-level
     "h m" 'describe-mode
     "m"  '(:ignore t :which-key "Mode")
     "k"  '(:ignore t :which-key "Text")
     "k ;" 'comment-or-uncomment-region
     "k c" 'kill-ring-save
     "k x" 'kill-ring
     "k v" 'yank
     "k V" 'helm-show-kill-ring
     "k a" 'mark-whole-buffer
     "s"  '(:ignore t :which-key "Search")
     "s s" 'helm-swoop
     "s h" 'replace-string
     "t"  '(:ignore t :which-key "Toggle")
     "t z" 'guancio-zoom/body
     "x" 'helm-M-x
     ;; company / company with doc
     )
    (setq scroll-preserve-screen-position 1)
    (general-define-key
     "C-y" 'undo-tree-redo
     "M-<up>" (lambda ()(interactive) (scroll-down-command 1))
     "M-<down>" (lambda ()(interactive) (scroll-up-command 1))
     )
    ))
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-S-v") #'helm-show-kill-ring)

(use-package elmacro
  :ensure t
  :commands (elmacro-mode)
  :init
  (general-define-key
   "<f7> k m"  '(:ignore t :which-key "Macro")
   "<f7> k m s" '((lambda () (interactive)
                   (elmacro-mode)
                   (kmacro-start-macro nil)) :which-key "start")
   "<f7> k m e" 'kmacro-end-or-call-macro
   "<f7> k m p" 'elmacro-show-last-macro
   "<f7> k e" 'kmacro-end-and-call-macro
   )
  )


(use-package which-key :ensure t
  :config
  (setq which-key-idle-delay 0)
  (setq which-key-sort-order 'which-key-key-order-alpha)
  (which-key-mode))

(setq helm-always-two-windows nil)
(setq helm-display-buffer-default-height 23)
;; open helm on the bottom
(setq helm-default-display-buffer-functions '(display-buffer-in-side-window))
(setq helm-swoop-split-direction 'split-window-horizontally)
;; Otherwise eshell uses a new frame
(setq helm-show-completion-display-function #'helm-show-completion-default-display-function)

;; (setq helm-display-function #'helm-display-buffer-in-own-frame)
;; (use-package frames-only-mode :ensure t
;; :config (frames-only-mode))

(helm-mode 1)

(use-package disable-mouse
  :ensure t
  :commands (global-disable-mouse-mode)
  :init
  (general-define-key
   :prefix "<f7> t"
   "M"  'global-disable-mouse-mode)
)


(use-package keyfreq
  :ensure t
  :init
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  (general-define-key
   :prefix "<f7>"
   "i" '(:igore t :which-key "Info")
   "i k" 'keyfreq-show)
  )


(provide 'g-keys)
