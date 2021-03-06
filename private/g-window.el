(use-package evil
  :ensure t)

(use-package hydra
  :ensure t)

(use-package eyebrowse
  :ensure t
  :config
  (eyebrowse-mode t))


(winner-mode t)
(toggle-frame-maximized)

(use-package winum
  :ensure t
  :config
  ;; (setq winum-scope 'frame-local
  ;;       winum-ignored-buffers '(" *which-key*"))
  (general-define-key
   :prefix "<f7>"
   "0" 'winum-select-window-0-or-10
   "1" 'winum-select-window-1
   "2" 'winum-select-window-2
   "3" 'winum-select-window-3
   "4" 'winum-select-window-4
   "5" 'winum-select-window-5
   "6" 'winum-select-window-6
   "7" 'winum-select-window-7
   "8" 'winum-select-window-8
   "9" 'winum-select-window-9)
  (winum-mode)
  )


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
;; problems with the minibuffer
(defun g/buf-move-down ()
  (interactive)
  (g/buf-move 'down))
(defun g/buf-move-left ()
  (interactive)
  (g/buf-move 'left))
(defun g/buf-move-right ()
  (interactive)
  (g/buf-move 'right))


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
Move
----------------------------------------------------------------
 ↑
←↓→
_<backspace>_ cancel _<return>_uit
"
  ("<left>" g/buf-move-left)
  ("<right>" g/buf-move-right)
  ("<up>" g/buf-move-up)
  ("<down>" g/buf-move-down)

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





;; (defun g/empty-left (&optional window)
;;   (let ((w (if (eq window nil) (selected-window) window)))
;;     (progn
;;       (split-window w nil 'left)
;;       (select-window (window-left-child (window-parent w)))
;;       (set-window-buffer (selected-window) (get-buffer "*scratch*"))
;;       (set-window-prev-buffers (selected-window) nil)
;;       )))
;; (defun g/empty-above (&optional window)
;;   (let ((w (if (eq window nil) (selected-window) window)))
;;     (progn
;;       (split-window w nil 'above)
;;       (select-window (window-top-child (window-parent w)))
;;       (set-window-buffer (selected-window) (get-buffer "*scratch*"))
;;       (set-window-prev-buffers (selected-window) nil)
;;       )))
;; (defun g/empty-right (&optional window)
;;   (let ((w (if (eq window nil) (selected-window) window)))
;;     (let ((w1 (split-window w nil 'right)))
;;       (progn
;; 	(select-window w1)
;; 	(set-window-buffer w1 (get-buffer "*scratch*"))
;; 	(set-window-prev-buffers w1 nil)))))
;; (defun g/empty-below (&optional window)
;;   (let ((w (if (eq window nil) (selected-window) window)))
;;     (progn
;;       (message (prin1-to-string w))
;;       (split-window w nil 'below)
;;       (windmove-down)
;;       (set-window-buffer (selected-window) (get-buffer "*scratch*"))
;;       (set-window-prev-buffers (selected-window) nil)
;;       )))
(defun g/empty-left (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (split-window w nil 'left)
    (g/remove-selection)
    ))
(defun g/empty-above (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (split-window w nil 'above)
    (g/remove-selection)
    ))
(defun g/empty-right (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (split-window w nil 'right)
    (g/remove-selection)
    ))
(defun g/empty-below (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (split-window w nil 'below)
    (g/remove-selection)
    ))

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



;; Does it make sense that we quit after splitting?
(defhydra guancio-split ()
  "
Split-empty  ^Hierarchy^
----------------------------------------------------------------
 ↑              w
←↓→             s
_<backspace>_ cancel _<return>_uit
"
  ("<left>" ( g/empty-left last-selected) :exit t)
  ("<right>" (g/empty-right last-selected) :exit t)
  ("<up>" (g/empty-above last-selected) :exit t)
  ("<down>" (g/empty-below last-selected) :exit t)
  ("w" g/up-selection)
  ("s" g/remove-selection)
  ;; left
  ;; top
  ;; create window (i.e. empty buffer and history)
  ;; left/right... yghj
  ;; 
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

(general-define-key
 :prefix "<f7> b"
 "q" 'g/kill-buffer-may-delete-window)


(defhydra guancio-window (:hint nil :color blue)
  "
Move   | Subactions ^^ | Delete ^^   | CUA ^^^^^^           | Workspace ^^          ^^    ^^         |_<backspace>_ _<return>_ _<f7>w_ cancel 
-------+------------^^-+--------^^---+-----^^^^^^-----------+-----------^^------------^^--^^---------+---------------------------------------
 ↑     | _r_esize      | _d_ window  | _z_/_u_ undo/redo ^^ | _C_ create  _w_ list      _`_ rename   | _b_ buffers
←↓→    | _s_plit       | _q_ buffer  | _x_/_c_/_v_          | _D_ delete  [] prev/next ^^ ^^ ^^      | _a_ maximize
0..9   | _m_ove	    ^^ | _o_ others  | ^^^^^^               | S-1..9 ^^   <tab> last   ^^ ^^         | _f_ find file
"
  ("<left>" windmove-left :exit nil)
  ("<down>" windmove-down :exit nil)
  ("<up>" windmove-up :exit nil)
  ("<right>" windmove-right :exit nil)
  ("r" g/open-resize
    :exit t)
  ("s" (guancio-split/body)
    :exit t)
  ("m" (guancio-move/body)
   :exit t)
  ("a" toggle-frame-maximized)
  ("0" winum-select-window-0-or-10 :exit nil)
  ("1" winum-select-window-1 :exit nil)
  ("2" winum-select-window-2 :exit nil)
  ("3" winum-select-window-3 :exit nil)
  ("4" winum-select-window-4 :exit nil)
  ("5" winum-select-window-5 :exit nil)
  ("6" winum-select-window-6 :exit nil)
  ("7" winum-select-window-7 :exit nil)
  ("8" winum-select-window-8 :exit nil)
  ("9" winum-select-window-9 :exit nil)
  ("d" delete-window :exit nil)
  ("q" g/kill-buffer-may-delete-window :exit nil)
  ("b" helm-mini :exit nil)
  ("f" helm-find-files :exit nil)
  ("z" winner-undo :exit nil)
  ("u" winner-redo :exit nil)
  ("o" delete-other-windows :exit nil)
  ("c" g/copy-window :exit nil)
  ("x" g/cut-window :exit nil)
  ("v" g/paste-window :exit nil)
  ("C" eyebrowse-create-window-config :exit nil)
  ("D" eyebrowse-close-window-config :exit nil)
  (")" eyebrowse-switch-to-window-config-0 :exit nil)
  ("!" eyebrowse-switch-to-window-config-1 :exit nil)
  ("@" eyebrowse-switch-to-window-config-2 :exit nil)
  ("#" eyebrowse-switch-to-window-config-3 :exit nil)
  ("$" eyebrowse-switch-to-window-config-4 :exit nil)
  ("%" eyebrowse-switch-to-window-config-5 :exit nil)
  ("^" eyebrowse-switch-to-window-config-6 :exit nil)
  ("&" eyebrowse-switch-to-window-config-7 :exit nil)
  ("*" eyebrowse-switch-to-window-config-8 :exit nil)
  ("(" eyebrowse-switch-to-window-config-9 :exit nil)
  ("<tab>" eyebrowse-last-window-config :exit nil)
  ("[" eyebrowse-prev-window-config :exit nil)
  ("]" eyebrowse-next-window-config :exit nil)
  ("w" eyebrowse-switch-to-window-config :exit nil)
  ("`" eyebrowse-rename-window-config :exit nil)
  ("<backspace>" nil)
  ("<return>" nil)
  ("<f7>w" nil)
  )

(general-define-key
 "<s-left>" 'evil-window-left
 "<s-right>" 'evil-window-right
 "<s-up>" 'evil-window-up
 "<s-down>" 'evil-window-down

 "s-r" 'g/open-resize
 "s-s" 'guancio-split/body
 "s-m" 'guancio-move/body

 "s-a" 'toggle-frame-maximized

 "<M-s-left>" 'g/buf-move-left
 "<M-s-right>" 'g/buf-move-right
 "<M-s-up>" 'g/buf-move-up
 "<M-s-down>" 'g/buf-move-down

 "s-0" 'winum-select-window-0-or-10
 "s-1" 'winum-select-window-1
 "s-2" 'winum-select-window-2
 "s-3" 'winum-select-window-3
 "s-4" 'winum-select-window-4
 "s-5" 'winum-select-window-5
 "s-6" 'winum-select-window-6
 "s-7" 'winum-select-window-7
 "s-8" 'winum-select-window-8
 "s-9" 'winum-select-window-9

 "s-d" 'delete-window
 "s-q" 'g/kill-buffer-may-delete-window
 "s-b" 'helm-mini
 "s-f" 'helm-find-files
 "s-z" 'winner-undo
 "s-u" 'winner-redo
 "s-o" 'delete-other-windows
 "s-c" 'g/copy-window
 "s-x" 'g/cut-window
 "s-v" 'g/paste-window

 "s-C" 'eyebrowse-create-window-config
 "s-D" 'eyebrowse-close-window-config
 "s-)" 'eyebrowse-switch-to-window-config-0
 "s-!" 'eyebrowse-switch-to-window-config-1
 "s-@" 'eyebrowse-switch-to-window-config-2
 "s-#" 'eyebrowse-switch-to-window-config-3
 "s-$" 'eyebrowse-switch-to-window-config-4
 "s-%" 'eyebrowse-switch-to-window-config-5
 "s-^" 'eyebrowse-switch-to-window-config-6
 "s-&" 'eyebrowse-switch-to-window-config-7
 "s-*" 'eyebrowse-switch-to-window-config-8
 "s-(" 'eyebrowse-switch-to-window-config-9
 "s-<tab>" 'eyebrowse-last-window-config
 "s-[" 'eyebrowse-prev-window-config
 "s-]" 'eyebrowse-next-window-config
 "s-w" 'eyebrowse-switch-to-window-config
 "s-`" 'eyebrowse-rename-window-config
)

(general-define-key
 :prefix "<f7>"
 "w" 'guancio-window/body)

;;  ("F" follow-mode)
  
;;     ;;     (defvar helm-buffer-history-map
;;     ;;       (let ((map (make-sparse-keymap)))
;;     ;; 	(set-keymap-parent map helm-map)
;;     ;; 	(define-key map (kbd "M-D")     'helm-buffer-run-kill-buffers)
;;     ;; 	;;(define-key map (kbd "C-]")     'helm-exwm-toggle-buffers-details)
;;     ;; 	map)
;;     ;;       "Keymap for browser source in Helm.")

;;     ;;     (defun helm-buffer-history-highlight-buffers (buffers)
;;     ;;       (mapcar 'buffer-name buffers))

;;     ;;     (defun helm-buffer-history-candidates (window &optional filter)
;;     ;;       (mapcar 'car (window-prev-buffers window)))

;;     ;;     (defun g/helm-exwm-build-source (window &optional filter)
;;     ;;       "Build source for EXWM buffers.
;;     ;; See `helm-exwm' for more details."
;;     ;;       (helm-build-sync-source "Buffers history"
;;     ;; 	:candidates (helm-buffer-history-candidates window filter)
;;     ;; 	:candidate-transformer 'helm-buffer-history-highlight-buffers
;;     ;; 	:action '(("Switch to buffer(s)" . helm-buffer-switch-buffers)
;;     ;;                   ("Kill buffer(s) `M-D`" . helm-kill-marked-buffers))
;;     ;; 	;; When follow-mode is on, the persistent-action allows for multiple candidate selection.
;;     ;; 	:persistent-action 'helm-buffers-list-persistent-action
;;     ;; 	:keymap helm-buffer-history-map))

;;     ;;     (defun g/helm-buffer-history (&optional filter)
;;     ;;       (interactive)
;;     ;;       (helm :sources (g/helm-exwm-build-source (selected-window) filter)
;;     ;;             :buffer "*helm-buffer-history*"))

;;     ;;     (exwm-input-set-key (kbd "<s-tab>") #'g/helm-buffer-history)


;;     ;; Some other default config, like three columns, fibonacci?
;;     )
;;   )

;; (message (prin1-to-string (window-prev-buffers (selected-window))))




(provide 'g-window)

;; maybe just split top instead of select the window
