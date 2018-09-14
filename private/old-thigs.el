(use-package evil
  :ensure t)

(use-package xelb
  :ensure t)


(use-package hydra
  :ensure t)


(setq g/resize-selected-edge nil)



(defun g/window-enlarge-v ()
  (interactive)
  (adjust-window-trailing-edge (selected-window) 1)
  )
(defun g/window-enlarge-v-fast ()
  (interactive)
  (adjust-window-trailing-edge (selected-window) 5)
  )
(defun g/window-shrink-v ()
  (interactive)
  (adjust-window-trailing-edge (selected-window) -1)
  )
(defun g/window-shrink-v-fast ()
  (interactive)
  (adjust-window-trailing-edge (selected-window) -5)
  )
(defun g/window-enlarge-h ()
  (interactive)
  (adjust-window-trailing-edge (selected-window) 1 t)
  )
(defun g/window-enlarge-h-fast ()
  (interactive)
  (adjust-window-trailing-edge (selected-window) 5 t)
  )
(defun g/window-shrink-h ()
  (interactive)
  (adjust-window-trailing-edge (selected-window) -1 t)
  )
(defun g/window-shrink-h-fast ()
  (interactive)
  (adjust-window-trailing-edge (selected-window) -5 t)
  )

;; window ---------------------------------------------------------------------
(defun split-window-below-and-focus ()
  "Split the window vertically and focus the new window."
  (interactive)
  (split-window-below)
  (windmove-down)
  (when (and (boundp 'golden-ratio-mode)
	     (symbol-value golden-ratio-mode))
    (golden-ratio)))

(defun split-window-above-and-focus ()
  "Split the window vertically and focus the new window."
  (interactive)
  (split-window nil nil 'above)
  (windmove-up)
  (when (and (boundp 'golden-ratio-mode)
	     (symbol-value golden-ratio-mode))
    (golden-ratio)))


(defun split-window-right-and-focus ()
  "Split the window horizontally and focus the new window."
  (interactive)
  (split-window-right)
  (windmove-right)
  (when (and (boundp 'golden-ratio-mode)
	     (symbol-value golden-ratio-mode))
    (golden-ratio)))

(defun split-window-left-and-focus ()
  "Split the window vertically and focus the new window."
  (interactive)
  (split-window nil nil 'left)
  (windmove-left)
  (when (and (boundp 'golden-ratio-mode)
	     (symbol-value golden-ratio-mode))
    (golden-ratio)))

;; s-\ split window vertically and close current buffer from the old window.
;; Focus on the new window. This should also remove the buffer from the history
(defun g/split-and-move-right ()
  (interactive)
  (let* ((this-win (selected-window)))
    (split-window-right-and-focus)
    (switch-to-prev-buffer this-win t)))
(defun g/split-and-move-down ()
  (interactive)
  (let* ((this-win (selected-window)))
    (split-window-below-and-focus)
    (switch-to-prev-buffer this-win t)))


;; Moving Buffers
;; Copied from buffer-move
;; when we move a buffer, we should also remove it from the list
;; of buffers for the current window.
;; (require 'windmove)
(defun g/buf-move (direction)
  (interactive)
  (let* ((other-win (windmove-find-other-window direction))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      (switch-to-prev-buffer (selected-window) t)
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))
(defun g/buf-move-up ()
  (interactive)
  (g/buf-move 'up))
;; problems with hydra
(defun g/buf-move-down ()
  (interactive)
  (g/buf-move 'down))
(defun g/buf-move-left ()
  (interactive)
  (g/buf-move 'left))
(defun g/buf-move-right ()
  (interactive)
  (g/buf-move 'right))


;; delete window and buffers
;; Maybe it is better to connect this to the kill-buffer-hook
(defun g/kill-buffer-may-delete-window ()
  (interactive)
  (let ((window_history (window-prev-buffers)))
    (progn
      (kill-buffer)
      (if (eq window_history nil)
          (delete-window))
      )))




(setq g/resize-selected-edge nil)

(defun g/resize-right (&optional cols)
  (interactive)
  (let ((s (if (eq cols nil) 1 cols)))
    (cond
     ((eq g/resize-selected-edge 'right)
      (adjust-window-trailing-edge (selected-window) s t))
     ((eq g/resize-selected-edge 'left)
      (adjust-window-trailing-edge (window-in-direction 'left (selected-window)) s t))
     (t (setq g/resize-selected-edge 'right))
     )))
(defun g/resize-left (&optional cols)
  (interactive)
  (let ((s (if (eq cols nil) 1 cols)))
    (cond
     ((eq g/resize-selected-edge 'right)
      (adjust-window-trailing-edge (selected-window) (- 0 s) t))
     ((eq g/resize-selected-edge 'left)
      (adjust-window-trailing-edge (window-in-direction 'left (selected-window)) (- 0 s) t))
     (t (setq g/resize-selected-edge 'left))
     )))
(defun g/resize-below (&optional cols)
  (interactive)
  (let ((s (if (eq cols nil) 1 cols)))
    (cond
     ((eq g/resize-selected-edge 'below)
      (adjust-window-trailing-edge (selected-window) s))
     ((eq g/resize-selected-edge 'above)
      (adjust-window-trailing-edge (window-in-direction 'above (selected-window)) s))
     (t (setq g/resize-selected-edge 'below))
     )))
(defun g/resize-above (&optional cols)
  (interactive)
  (let ((s (if (eq cols nil) 1 cols)))
    (cond
     ((eq g/resize-selected-edge 'below)
      (adjust-window-trailing-edge (selected-window) (- 0 s)))
     ((eq g/resize-selected-edge 'above)
      (adjust-window-trailing-edge (window-in-direction 'above (selected-window)) (- 0 s)))
     (t (setq g/resize-selected-edge 'above))
     )))

(defhydra guancio-resize ()
  "
Resize (S-fast)  ^Centered (S-fast) ^ 
----------------------------------------------------------------
 ↑                   w
←↓→                 ads
_<backspace>_ cancel _<return>_uit
"
  ("<right>" g/resize-right)
  ("<S-right>" (lambda ()(interactive) (g/resize-right 5)))
  ("<left>" g/resize-left)
  ("<S-left>" (lambda ()(interactive) (g/resize-left 5)))
  ("<up>" g/resize-above)
  ("<S-up>" (lambda ()(interactive) (g/resize-above 5)))
  ("<down>" g/resize-below)
  ("<S-down>" (lambda ()(interactive) (g/resize-below 5)))
  ("SPC" (lambda ()(interactive) (setq g/resize-selected-edge nil)))
  ("<backspace>" (guancio-window/body) :exit t)
  ("<return>" nil)
  )

(defun g/open-resize ()
  (interactive)
  (progn
    (setq g/resize-selected-edge nil)
    (guancio-resize/body)))

;; Does it make sense that we quit after splitting?
(defhydra guancio-split ()
  "
Split-dup  ^Split-move^ ^Empty win^ ^Side win^
----------------------------------------------------------------
 ↑              i          t           w
←↓→            jkl        fgh         asd
_<backspace>_ cancel _<return>_uit
"
  ("<left>" (progn
	      (split-window-left-and-focus)
	      (guancio-window/body)):exit t)
  ("<right>" (progn
	       (split-window-right-and-focus)
	       (guancio-window/body)):exit t)
  ("<up>" (progn
	    (split-window-above-and-focus)
	    (guancio-window/body)):exit t)
  ("<down>" (progn
	      (split-window-below-and-focus)
	      (guancio-window/body)):exit t)
  ("l" (progn
	 (g/split-and-move-right)
	 (guancio-window/body)):exit t)
  ("k" (progn
	 (g/split-and-move-down)
	 (guancio-window/body)):exit t)
  ;; left
  ;; top
  ;; create window (i.e. empty buffer and history)
  ;; left/right... yghj
  ;; 
  ("<backspace>" (guancio-window/body) :exit t)
  ("<return>" nil)
  )

(defun g/move-to (arg)
  (interactive)
  (let ((b (current-buffer))
	(w (selected-window)))
    (winum-select-window-by-number arg)
    (set-window-buffer (selected-window) b)
    (switch-to-prev-buffer w t)
  ))

(defhydra guancio-move ()
  "
Move ^Side move^
----------------------------------------------------------------
 ↑       w
←↓→     asd
_<backspace>_ cancel _<return>_uit
"
  ("<left>" g/buf-move-left)
  ("<right>" g/buf-move-right)
  ("<up>" g/buf-move-up)
  ("<down>" g/buf-move-down)

  ("a" evil-window-move-far-left)
  ("s" evil-window-move-very-bottom)
  ("w" evil-window-move-very-top)
  ("d" evil-window-move-far-right)

  ("1" (lambda () (interactive)(g/move-to 1)))
  ("2" (lambda () (interactive)(g/move-to 2)))
  ("3" (lambda () (interactive)(g/move-to 3)))
  ("4" (lambda () (interactive)(g/move-to 4)))
  ("5" (lambda () (interactive)(g/move-to 5)))
  ("6" (lambda () (interactive)(g/move-to 6)))
  ("7" (lambda () (interactive)(g/move-to 7)))
  ("8" (lambda () (interactive)(g/move-to 8)))
  ("9" (lambda () (interactive)(g/move-to 9)))

  ("<backspace>" (guancio-window/body) :exit t)
  ("<return>" nil)
  )


(setq g/copied-window nil)
(defun g/copy-window ()
  (interactive)
  (let ((b (current-buffer))
	(w (selected-window)))
    (setq g/copied-window (list b nil))
    ))
(defun g/cut-window ()
  (interactive)
  (let ((b (current-buffer))
	(w (selected-window)))
    (setq g/copied-window (list b w))
    ))
(defun g/paste-window ()
  (interactive)
  (if (not (eq g/copied-window nil))
      (let ((b (car g/copied-window))
	    (w (cdr g/copied-window)))
	(progn
	  (set-window-buffer (selected-window) (car g/copied-window))
	  (if (not (eq w nil))
	      (progn
		(switch-to-prev-buffer w t)
		(setq g/copied-window (list b (current-window)))
		)))
	)))
(exwm-input-set-key (kbd "s-c") #'g/copy-window)
(exwm-input-set-key (kbd "s-x") #'g/cut-window)
(exwm-input-set-key (kbd "s-v") #'g/paste-window)


(defhydra guancio-window ()
  "
Move 
----------------------------------------------------------------
 ↑       _r_esize    m_a_ximize       e_x_ecute
←↓→      _s_plit     _d_elete         _b_uffer list
0..9     _m_ove      _q_ kill buffer  _w_orkspace  S-0..9 workspace
_z_ undo   _u_ redo  delete _o_thers  _n_ move to workspace
_<backspace>_ _<return>_ cancel 
"
  ("<left>" windmove-left )
  ("<down>" windmove-down )
  ("<up>" windmove-up )
  ("<right>" windmove-right )
  
  ("r" g/open-resize
    :exit t)
  ("s" (guancio-split/body)
    :exit t)
  ("m" (guancio-move/body)
   :exit t)
  
  ("a" g/exwm-layout-toggle-fullscreen)

  ("0" winum-select-window-0-or-10)
  ("1" winum-select-window-1)
  ("2" winum-select-window-2)
  ("3" winum-select-window-3)
  ("4" winum-select-window-4)
  ("5" winum-select-window-5)
  ("6" winum-select-window-6)
  ("7" winum-select-window-7)
  ("8" winum-select-window-8)
  ("9" winum-select-window-9)

  ("w" exwm-workspace-switch :exit t)
  ("!" (lambda () (interactive) (exwm-workspace-switch 0)))
  ("@" (lambda () (interactive) (exwm-workspace-switch 1)))
  ("#" (lambda () (interactive) (exwm-workspace-switch 2)))
  ("$" (lambda () (interactive) (exwm-workspace-switch 3)))
  ("%" (lambda () (interactive) (exwm-workspace-switch 4)))
  ("^" (lambda () (interactive) (exwm-workspace-switch 5)))
  ("&" (lambda () (interactive) (exwm-workspace-switch 6)))
  ("*" (lambda () (interactive) (exwm-workspace-switch 7)))
  ("(" (lambda () (interactive) (exwm-workspace-switch 8)))
  (")" (lambda () (interactive) (exwm-workspace-switch 9)))

  ("d" delete-window)
  ("q" g/kill-buffer-may-delete-window)
  ("x"
     (lambda (command)
       (interactive (list (read-shell-command "$ ")))
       (start-process-shell-command command nil command))
     )
  ("b" helm-mini)
  ("f" helm-find-files)
  ("z" winner-undo)
  ("u" winner-redo)
  ("o" delete-other-windows)
  ("n" exwm-workspace-move-window)
  ("<backspace>" nil)
  ("<return>" nil)
  )  

;;  ("F" follow-mode)

(defun spacemacs//exwm-switch-to-line-mode ()
  "Used as a hook to switch to line mode when transient mode starts."
  (when (not exwm--keyboard-grabbed)
    ;; (setq exwm--switch-to-char-after-transient (current-buffer))
    (call-interactively 'exwm-input-grab-keyboard)))


(use-package exwm
  :ensure t
  :init
  (progn
    ;; Disable dialog boxes since they are unusable in EXWM
    (setq use-dialog-box nil)
    ;; 10 Worskpaces please
    (setq exwm-workspace-number 1)
    (setq exwm-input-line-mode-passthrough t)
    )
  :config
  (progn
    (winner-mode t)
    (setq exwm-workspace-number 4)
    ;; All buffers created in EXWM mode are named "*EXWM*". You may want to
    ;; change it in `exwm-update-class-hook' and `exwm-update-title-hook', which
    ;; are run when a new X window class name or title is available.  Here's
    ;; some advice on this topic:
    ;; + Always use `exwm-workspace-rename-buffer` to avoid naming conflict.
    ;; + For applications with multiple windows (e.g. GIMP), the class names of
					;    all windows are probably the same.  Using window titles for them makes
    ;;   more sense.
    ;; In the following example, we use class names for all windows expect for
    ;; Java applications and GIMP.
    (add-hook 'exwm-update-class-hook
              (lambda ()
		(unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                            (string= "gimp" exwm-instance-name))
		  (exwm-workspace-rename-buffer exwm-class-name))))
    (add-hook 'exwm-update-title-hook
              (lambda ()
		(when (or (not exwm-instance-name)
			  (string-prefix-p "sun-awt-X11-" exwm-instance-name)
			  (string= "gimp" exwm-instance-name))
		  (exwm-workspace-rename-buffer exwm-title))))

    (exwm-input-set-key (kbd "s-.") #'guancio-window/body)
        ;; make sure that displaying transient states gets the keyboard input.  Also
    ;; take care of going into line mode, and possibly switching back.
    ;; borrowed from: https://github.com/abo-abo/hydra/issues/232
    (define-advice hydra-set-transient-map (:around (fun keymap on-exit &optional foreign-keys) exwm-passthrough)
      (spacemacs//exwm-switch-to-line-mode)
      (let ((on-exit (lexical-let ((on-exit on-exit))
                       (lambda ()
                         ;; Here would be the place to reactivate input state if
                         ;; it was active before hydra invocation.  This
                         ;; probably only makes sense when you have a global
                         ;; input state.
                         (when on-exit (funcall on-exit))))))
        (funcall fun keymap on-exit foreign-keys)))

    
    ;; kick all exwm buffers into insert mode per default
    (add-hook 'exwm-manage-finish-hook (lambda () (call-interactively #'exwm-input-release-keyboard)))

    ;; Does not work if we have xwindow
    ; (exwm-input-set-key (kbd "<f7>.") #'guancio-window/body)
    ;; things moved to hidra
    ;; Should we re-enable some of them?
    ;; maybe move and start hydra
    (exwm-input-set-key (kbd "<s-left>") #'evil-window-left)
    (exwm-input-set-key (kbd "<s-right>") #'evil-window-right)
    (exwm-input-set-key (kbd "<s-up>") #'evil-window-up)
    (exwm-input-set-key (kbd "<s-down>") #'evil-window-down)

    (exwm-input-set-key (kbd "s-r") #'g/open-resize)
    (exwm-input-set-key (kbd "s-s") #'guancio-split/body)
    (exwm-input-set-key (kbd "s-m") #'guancio-move/body)

 
    (exwm-input-set-key (kbd "<M-s-left>") #'g/buf-move-left)
    (exwm-input-set-key (kbd "<M-s-right>") #'g/buf-move-right)
    (exwm-input-set-key (kbd "<M-s-up>") #'g/buf-move-up)
    (exwm-input-set-key (kbd "<M-s-down>") #'g/buf-move-down)
  
    (exwm-input-set-key (kbd "s-a") #'exwm-layout-toggle-fullscreen)

    (exwm-input-set-key (kbd "s-0") #'winum-select-window-0-or-10)
    (exwm-input-set-key (kbd "s-1") #'winum-select-window-1)
    (exwm-input-set-key (kbd "s-2") #'winum-select-window-2)
    (exwm-input-set-key (kbd "s-3") #'winum-select-window-3)
    (exwm-input-set-key (kbd "s-4") #'winum-select-window-4)
    (exwm-input-set-key (kbd "s-5") #'winum-select-window-5)
    (exwm-input-set-key (kbd "s-6") #'winum-select-window-6)
    (exwm-input-set-key (kbd "s-7") #'winum-select-window-7)
    (exwm-input-set-key (kbd "s-8") #'winum-select-window-8)
    (exwm-input-set-key (kbd "s-9") #'winum-select-window-9)

    (exwm-input-set-key (kbd "s-w") #'exwm-workspace-switch)
    (exwm-input-set-key (kbd "s-!") #'(lambda () (interactive) (exwm-workspace-switch 0)))
    (exwm-input-set-key (kbd "s-@") #'(lambda () (interactive) (exwm-workspace-switch 1)))
    (exwm-input-set-key (kbd "s-#") #'(lambda () (interactive) (exwm-workspace-switch 2)))
    (exwm-input-set-key (kbd "s-$") #'(lambda () (interactive) (exwm-workspace-switch 3)))
    (exwm-input-set-key (kbd "s-%") #'(lambda () (interactive) (exwm-workspace-switch 4)))
    (exwm-input-set-key (kbd "s-^") #'(lambda () (interactive) (exwm-workspace-switch 5)))
    (exwm-input-set-key (kbd "s-&") #'(lambda () (interactive) (exwm-workspace-switch 6)))
    (exwm-input-set-key (kbd "s-*") #'(lambda () (interactive) (exwm-workspace-switch 7)))
    (exwm-input-set-key (kbd "s-(") #'(lambda () (interactive) (exwm-workspace-switch 8)))
    (exwm-input-set-key (kbd "s-)") #'(lambda () (interactive) (exwm-workspace-switch 9)))

    (exwm-input-set-key (kbd "s-d") #'delete-window)
    (exwm-input-set-key (kbd "s-q") #'g/kill-buffer-may-delete-window)
    (exwm-input-set-key (kbd "s-x")
     (lambda (command)
       (interactive (list (read-shell-command "$ ")))
       (start-process-shell-command command nil command))
     )
    (exwm-input-set-key (kbd "s-b") #'helm-mini)
    (exwm-input-set-key (kbd "s-z") #'winner-undo)
    (exwm-input-set-key (kbd "s-u") #'winner-redo)
    (exwm-input-set-key (kbd "s-o") #'delete-other-windows)
    (exwm-input-set-key (kbd "s-n") #'exwm-workspace-move-window)

    (exwm-input-set-key (kbd "s-i") 'exwm-input-release-keyboard)
    (exwm-input-set-key (kbd "s-l") 'exwm-input-grab-keyboard)



    
    ;;     (defvar helm-buffer-history-map
    ;;       (let ((map (make-sparse-keymap)))
    ;; 	(set-keymap-parent map helm-map)
    ;; 	(define-key map (kbd "M-D")     'helm-buffer-run-kill-buffers)
    ;; 	;;(define-key map (kbd "C-]")     'helm-exwm-toggle-buffers-details)
    ;; 	map)
    ;;       "Keymap for browser source in Helm.")

    ;;     (defun helm-buffer-history-highlight-buffers (buffers)
    ;;       (mapcar 'buffer-name buffers))

    ;;     (defun helm-buffer-history-candidates (window &optional filter)
    ;;       (mapcar 'car (window-prev-buffers window)))

    ;;     (defun g/helm-exwm-build-source (window &optional filter)
    ;;       "Build source for EXWM buffers.
    ;; See `helm-exwm' for more details."
    ;;       (helm-build-sync-source "Buffers history"
    ;; 	:candidates (helm-buffer-history-candidates window filter)
    ;; 	:candidate-transformer 'helm-buffer-history-highlight-buffers
    ;; 	:action '(("Switch to buffer(s)" . helm-buffer-switch-buffers)
    ;;                   ("Kill buffer(s) `M-D`" . helm-kill-marked-buffers))
    ;; 	;; When follow-mode is on, the persistent-action allows for multiple candidate selection.
    ;; 	:persistent-action 'helm-buffers-list-persistent-action
    ;; 	:keymap helm-buffer-history-map))

    ;;     (defun g/helm-buffer-history (&optional filter)
    ;;       (interactive)
    ;;       (helm :sources (g/helm-exwm-build-source (selected-window) filter)
    ;;             :buffer "*helm-buffer-history*"))

    ;;     (exwm-input-set-key (kbd "<s-tab>") #'g/helm-buffer-history)


    

    ;; Some other default config, like three columns, fibonacci?
    )
  )

;; (message (prin1-to-string (window-prev-buffers (selected-window))))


(defun g/empty-left (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (progn
      (split-window w nil 'left)
      (select-window (window-left-child (window-parent w)))
      (set-window-buffer (selected-window) (get-buffer "*scratch*"))
      (set-window-prev-buffers (selected-window) nil)
      )))
(defun g/empty-above (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (progn
      (split-window w nil 'above)
      (select-window (window-top-child (window-parent w)))
      (set-window-buffer (selected-window) (get-buffer "*scratch*"))
      (set-window-prev-buffers (selected-window) nil)
      )))


(defun g/empty-right (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (let ((w1 (split-window w nil 'right)))
      (progn
	(select-window w1)
	(set-window-buffer w1 (get-buffer "*scratch*"))
	(set-window-prev-buffers w1 nil)))))


(defun g/empty-below (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (progn
      (message (prin1-to-string w))
      (split-window w nil 'below)
      (windmove-down)
      (set-window-buffer (selected-window) (get-buffer "*scratch*"))
      (set-window-prev-buffers (selected-window) nil)
      )))


(general-define-key
     :prefix "<f7> p"
     "<right>" 'g/empty-right)



(setq last-selected nil)

(defun g/color-layer (window)
  (if (not (eq window nil))
      (progn
	(g/color-all window)
	(g/color-layer (window-next-sibling window))
	)))

(defun g/color-all (window)
  (let ((c (window-child window)))
    (if (eq c nil)
     	(let ((over (make-overlay 1 100000 (window-buffer window))))
     	  (progn
     	    (overlay-put over 'face '(:background "#001100"))
     	    (overlay-put over 'window window)
     	    ))
      (g/color-layer c)
      )
    )
  )

(defun g/color-none ()
  (mapcar (lambda (window)
	    (with-current-buffer (window-buffer window)
	      (remove-overlays )))
	  (window-list)))


(defun g/up-selection ()
  (interactive)
  (progn
    (if (eq last-selected nil)
	(setq last-selected (selected-window))
      (setq last-selected (window-parent last-selected)))
    (g/color-none)
    (g/color-all last-selected)
    ))
(defun g/remove-selection()
  (interactive)
  (progn
    (setq last-selected nil)
    (g/color-none)))

(general-define-key
     :prefix "<f7>"
     "q" 'g/up-selection
     "w" 'g/remove-selection
 "<right>" (lambda () (interactive) (g/empty-right last-selected))
 "<left>" (lambda () (interactive) (g/empty-left last-selected))
 "<up>" (lambda () (interactive) (g/empty-above last-selected))
 "<down>" (lambda () (interactive) (g/empty-beloww last-selected))
 )

(provide 'g-window)
