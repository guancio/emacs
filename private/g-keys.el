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

(defun start-emacs ()
  (interactive)
  (start-process-shell-command "emacs" "*emacs*" "/home/guancio/emacs-test/run.sh"))

(use-package general
  :ensure t
  :init
  (progn
    (general-define-key
     :prefix "<f7>"
     "a"  '(:ignore t :which-key "Applications")
     "as"  'eshell
     "an"  'new-frame
     "ae" '(start-emacs :which-key "emacs")
     "aq" '(save-buffers-kill-terminal :which-key "quit")
     "b"  '(:ignore t :which-key "Buffers")
     "bb" 'helm-mini
     "bk" '((lambda () (interactive)(kill-buffer)) :which-key "kill this buffer")
     "bK" 'kill-buffer
     "f"  '(:ignore t :which-key "Files")
     "ff" 'helm-find-files
     "fg" 'revert-buffer-no-confirm 
     "fs" 'save-buffer
     "fS" 'write-file
     "g"  '(:ignore t :which-key "Go")
     "gi" 'helm-imenu
     ;; does not work
     ;; "ga" 'xref-find-apropos
     "h"  '(:ignore t :which-key "Help")
     "h k" 'describe-key
     "h K" 'which-key-show-top-level
     "h m" 'describe-mode
     "m"  '(:ignore t :which-key "Mode")
     "k"  '(:ignore t :which-key "Text")
     "k c" 'comment-or-uncomment-region
     "k s" 'kmacro-start-macro
     "k d" 'kmacro-end-macro
     "k e" 'kmacro-end-and-call-macro
     "k a" 'mark-whole-buffer
     "k h" 'query-replace
     "s"  '(:ignore t :which-key "Search")
     "s s" 'helm-swoop
     "t"  '(:ignore t :which-key "Toggle")     
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
  (setq which-key-idle-delay 0)
  (setq which-key-sort-order 'which-key-key-order-alpha)
  (which-key-mode))

(setq helm-always-two-windows nil)
(setq helm-display-buffer-default-height 23)
;; open helm on the bottom
(setq helm-default-display-buffer-functions '(display-buffer-in-side-window))
(setq helm-swoop-split-direction 'split-window-horizontally)

(helm-mode 1)


;; tab complete in helm?

(provide 'g-keys)
