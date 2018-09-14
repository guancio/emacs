;; to Fix
(setq g/offline-imap-process nil)
(defun g/start-offline-imap-process ()
  (interactive)
  (progn
    (if (eq g/offline-imap-process nil)
	(setq g/offline-imap-process (start-process "offlineimap" "*offlineimap*" "offlineimap")))
    (switch-to-buffer "*offlineimap*")
    ))
(defun g/stop-offline-imap-process ()
  (interactive)
  (progn
    (if (not (eq g/offline-imap-process nil))
	(stop-process "offlineimap"))
    (switch-to-buffer "*offlineimap*")
    ))

(use-package mu4e
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :commands (mu4e mu4e-headers-search mu4e-compose-new mu4e~proc-add)
  :init
  (setq
   mu4e-maildir       "~/mail/kth"   ;; top-level Maildir
   mu4e-sent-folder   "/Sent Items"       ;; folder for sent messages
   mu4e-drafts-folder "/Drafts"     ;; unfinished messages
   mu4e-trash-folder  "/Deleted Items"      ;; trashed messages
   mu4e-refile-folder "/INBOX.archive")   ;; saved messages
  ;; a  list of user's e-mail addresses
  (setq mu4e-user-mail-address-list '("robertog@kth.se"))
  ;; general emacs mail settings; used when composing e-mail
  ;; the non-mu4e-* stuff is inherited from emacs/message-mode
  (setq mu4e-reply-to-address "robertog@kth.se"
        user-mail-address "robertog@kth.se"
        user-full-name  "Roberto Guanciale")
  (setq mu4e-compose-signature
        "Roberto Guanciale\nKTH.se\n")

  ;; delete password from smtp-auth
  ;; smtp mail setting
  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-stream-type 'starttls
        smtpmail-default-smtp-server "smtp.kth.se"
        smtpmail-smtp-server "smtp.kth.se"
        smtpmail-smtp-service 587)
  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)

  (general-define-key
   :prefix "<f7>"
   "am"  '(mu4e :which-key "e-mail"))

  (general-define-key
   :prefix "<f7>"
   :keymaps 'mu4e-main-mode-map
   "mo"  '(:ignore t :which-key "Offlineimap")
   "mob" 'g/start-offline-imap-process
   "mos" 'g/stop-offline-imap-process
   )

  (general-define-key
   :prefix "<f7> m"
   :keymaps 'mu4e-headers-mode-map

   "SPC" 'mu4e-mark-resolve-deferred-marks
   "." 'mu4e-headers-mark-for-something
   "?" 'mu4e-headers-mark-for-unread

   "C" 'mu4e-compose-new
   "F" 'mu4e-compose-forward
   "R" 'mu4e-compose-reply
   
   "d" 'mu4e-headers-mark-for-trash
   "D" 'mu4e-headers-mark-for-delete
   
   "s" 'mu4e-headers-change-sorting
   "t" 'mu4e-headers-mark-thread
   "U" 'mu4e-mark-unmark-all
   "g" 'mu4e-headers-rerun-search
   "j" 'mu4e~headers-jump-to-maildir
   "m" 'mu4e-headers-mark-for-move
   "n" 'mu4e-headers-next
   "p" 'mu4e-headers-prev
   "q" 'mu4e~headers-quit-buffer
   "r" 'mu4e-headers-mark-for-refile
   "u" 'mu4e-headers-mark-for-unmark
   "x" 'mu4e-mark-execute-all
   )

  (general-define-key
   :keymaps 'mu4e-headers-mode-map

   "SPC" 'mu4e-mark-resolve-deferred-marks
   "." 'mu4e-headers-mark-for-something
   "?" 'mu4e-headers-mark-for-unread

   "C" 'mu4e-compose-new
   "F" 'mu4e-compose-forward
   "R" 'mu4e-compose-reply
   
   "d" 'mu4e-headers-mark-for-trash
   "D" 'mu4e-headers-mark-for-delete
   
   "s" 'mu4e-headers-change-sorting
   "t" 'mu4e-headers-mark-thread
   "U" 'mu4e-mark-unmark-all
   "g" 'mu4e-headers-rerun-search
   "j" 'mu4e~headers-jump-to-maildir
   "m" 'mu4e-headers-mark-for-move
   "n" 'mu4e-headers-next
   "p" 'mu4e-headers-prev
   "q" 'mu4e~headers-quit-buffer
   "r" 'mu4e-headers-mark-for-refile
   "u" 'mu4e-headers-mark-for-unmark
   "x" 'mu4e-mark-execute-all
   )

  (general-define-key
   :prefix "<f7> t"
   :keymaps 'mu4e-headers-mode-map
   "t" 'mu4e-headers-toggle-threading
   "f" 'mu4e-headers-toggle-full-search
   "d" 'mu4e-headers-toggle-skip-duplicates
   "r" 'mu4e-headers-toggle-include-related)

  (general-define-key
   :prefix "<f7> s"
   :keymaps 'mu4e-headers-mode-map
   "n" 'mu4e-headers-search-narrow
   "e" 'mu4e-headers-search-edit
   "f" 'mu4e-headers-search)

  ;; %		mu4e-headers-mark-pattern
   ;; &		mu4e-headers-mark-custom
   ;; +		mu4e-headers-mark-for-flag
   ;; -		mu4e-headers-mark-for-unflag
   ;; ;		mu4e-context-switch
   ;; <		beginning-of-buffer
   ;; =		mu4e-headers-mark-for-untrash
   ;; >		end-of-buffer
   ;; A		mu4e-headers-mark-for-action
   ;; B		mu4e-headers-search-bookmark-edit
   ;; E		mu4e-compose-edit
   ;; H		mu4e-display-manual
   ;; [		mu4e-headers-prev-unread
   ;; \		mu4e-headers-query-prev
   ;; ]		mu4e-headers-next-unread
   ;; a		mu4e-headers-action
   ;; b		mu4e-headers-search-bookmark
   ;; t		mu4e-headers-mark-subthread
   ;; y		mu4e-select-other-view
   ;; C-+		mu4e-headers-split-view-grow
   ;; C--		mu4e-headers-split-view-shrink
   ;; <C-kp-add>	mu4e-headers-split-view-grow
   ;; <C-kp-subtract>			mu4e-headers-split-view-shrink
   ;; <M-down>	mu4e-headers-next
   ;; <M-left>	mu4e-headers-query-prev
   ;; <M-right>	mu4e-headers-query-next
   ;; <M-up>		mu4e-headers-prev

   

  ;; better keybinding in header
  ;; sorting
  ;; better search
  
  ;; mu4e message: download attachment...
  ;; detach message
  ;; open in emacs
  ;; compose from to/from
  ;; show addresses
  
  (general-define-key
   :keymap 'mu4e-view-mode-map
   :prefix "<f7>"
   "t c" 'mu4e-view-toggle-hide-cited
   )

  
  ;; !		mu4e-view-mark-for-read
  ;; %		mu4e-view-mark-pattern
  ;; &		mu4e-view-mark-custom
  ;; *		mu4e-view-mark-for-something
  ;; +		mu4e-view-mark-for-flag
  ;; -		mu4e-view-mark-for-unflag
  ;; .		mu4e-view-raw-message
  ;; /		mu4e-view-search-narrow
  ;; 0 .. 9		digit-argument
  ;; ;		mu4e-context-switch
  ;; <		beginning-of-buffer
  ;; =		mu4e-view-mark-for-untrash
  ;; >		end-of-buffer
  ;; ?		mu4e-view-mark-for-unread
  ;; A		mu4e-view-attachment-action
  ;; B		mu4e-headers-search-bookmark-edit
  ;; C		mu4e-compose-new
  ;; D		mu4e-view-mark-for-delete
  ;; E		mu4e-compose-edit
  ;; F		mu4e-compose-forward
  ;; H		mu4e-display-manual
  ;; O		mu4e-headers-change-sorting
  ;; P		mu4e-headers-toggle-threading
  ;; Q		mu4e-headers-toggle-full-search
  ;; R		mu4e-compose-reply
  ;; S		mu4e-view-search-edit
  ;; T		mu4e-view-mark-thread
  ;; U		mu4e-view-unmark-all
  ;; W		mu4e-headers-toggle-include-related
  ;; [		mu4e-view-headers-prev-unread
  ;; ]		mu4e-view-headers-next-unread
  ;; a		mu4e-view-action
  ;; b		mu4e-headers-search-bookmark
  ;; d		mu4e-view-mark-for-trash
  ;; e		mu4e-view-save-attachment
  ;; f		mu4e-view-fetch-url
  ;; g		mu4e-view-go-to-url
  ;; h		mu4e-view-toggle-html
  ;; j		mu4e~headers-jump-to-maildir
  ;; k		mu4e-view-save-url
  ;; m		mu4e-view-mark-for-move
  ;; n		mu4e-view-headers-next
  ;; o		mu4e-view-open-attachment
  ;; p		mu4e-view-headers-prev
  ;; q		mu4e~view-quit-buffer
  ;; r		mu4e-view-mark-for-refile
  ;; s		mu4e-headers-search
  ;; t		mu4e-view-mark-subthread
  ;; u		mu4e-view-unmark
  ;; v		mu4e-view-verify-msg-popup
  ;; w		visual-line-mode
  ;; x		mu4e-view-marked-execute
  ;; y		mu4e-select-other-view
  ;; z		ignore
  ;; |		mu4e-view-pipe
  ;; DEL		scroll-down-command
  ;; C-S-u		mu4e-update-mail-and-index
  ;; S-SPC		scroll-down-command
  ;; C-+		mu4e-headers-split-view-grow
  ;; C--		mu4e-headers-split-view-shrink
  ;; <C-kp-add>	mu4e-headers-split-view-grow
  ;; <C-kp-subtract>			mu4e-headers-split-view-shrink
  ;; <M-down>	mu4e-view-headers-next
  ;; <M-left>	mu4e-headers-query-prev
  ;; <M-right>	mu4e-headers-query-next
  ;; <M-up>		mu4e-view-headers-prev
  ;; <backspace>	mu4e-scroll-down
  ;; <delete>	mu4e-view-mark-for-delete
  ;; <deletechar>	mu4e-view-mark-for-delete
  ;; <end>		end-of-buffer
  ;; <home>		beginning-of-buffer
  ;; <insert>	mu4e-view-mark-for-something
  ;; <insertchar>	mu4e-view-mark-for-something
  ;; <kp-multiply>	mu4e-view-mark-for-something
  ;; <remap>		Prefix Command

  ;; M-q		mu4e-view-fill-long-lines

  ;; C-c C-u		mu4e-update-mail-and-index


  (general-define-key
   :keymaps 'mu4e-compose-mode-map
   :prefix "<f7> m"
   "a" '(mml-attach-file :which-key "attach")
   "b" '(message-goto-body :which-key "body")
   "c" '(message-send-and-exit :which-key "send and exit")
   "q" '(message-kill-buffer :which-key "quit")
   "s" '(message-send :which-key "send")
   )
  ;; better autocompletition



  (setq mu4e-html2text-command 'mu4e-shr2text)
  (setq shr-color-visible-luminance-min 60)
  (setq shr-color-visible-distance-min 5)
  (setq shr-use-colors nil)
  (advice-add #'shr-colorize-region :around (defun shr-no-colourise-region (&rest ignore)))

  )

(provide 'g-mail)
