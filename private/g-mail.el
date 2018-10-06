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

  (setq mu4e-attachment-dir  "~/Downloads")
  
  (general-define-key
   :prefix "<f7>"
   "am"  '(mu4e :which-key "e-mail"))

  :config
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
   
   "S" 'mu4e-headers-search
   "/" 'mu4e-headers-search-narrow
   "e" 'mu4e-headers-search-edit
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
   "s" 'mu4e-headers-change-sorting
   "r" 'mu4e-headers-toggle-include-related)

  (general-define-key
   :prefix "<f7> s"
   :keymaps 'mu4e-headers-mode-map
   "/" 'mu4e-headers-search-narrow
   "e" 'mu4e-headers-search-edit
   "f" 'mu4e-headers-search
   "m" 'helm-mu
   "c" 'helm-mu-contacts)

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
   ;; <M-left>	mu4e-headers-query-prev
   ;; <M-right>	mu4e-headers-query-next

   

  ;; mu4e message: download attachment...
  ;; detach message
  ;; open in emacs
  ;; compose from to/from
  ;; show addresses
  
  (general-define-key
   :keymaps 'mu4e-view-mode-map
   :prefix "<f7>"
   "t c" 'mu4e-view-toggle-hide-cited
   "t 0" 'mu4e-view-raw-message
   "t t" 'mu4e-headers-toggle-threading
   "t f" 'mu4e-headers-toggle-full-search
   "t d" 'mu4e-headers-toggle-skip-duplicates
   "t s" 'mu4e-headers-change-sorting
   "t r" 'mu4e-headers-toggle-include-related
   "t h" 'mu4e-view-toggle-html
   )

  (general-define-key
   :prefix "<f7> m"
   :keymaps 'mu4e-view-mode-map

   "." 'mu4e-view-mark-for-something
   "?" 'mu4e-view-mark-for-unread

   "C" 'mu4e-compose-new
   "F" 'mu4e-compose-forward
   "R" 'mu4e-compose-reply
   
   "d" 'mu4e-view-mark-for-trash
   "D" 'mu4e-view-mark-for-delete
   
   "a" '(:ignore t :which-key "attachment")
   "a a" 'mu4e-view-attachment-action
   "a s" 'mu4e-view-save-attachment
   "a o" 'mu4e-view-open-attachment
   
   "t" 'mu4e-view-mark-thread
   "U" 'mu4e-view-unmark-all
   "g" 'mu4e-view-go-to-url
   "j" 'mu4e~headers-jump-to-maildir
   "m" 'mu4e-view-mark-for-move
   "n" 'mu4e-view-next
   "p" 'mu4e-view-prev
   "q" 'mu4e~view-quit-buffer
   "r" 'mu4e-view-mark-for-refile
   "u" 'mu4e-view-unmark
   "x" 'mu4e-view-marked-execute

   "e" 'mu4e-view-search-edit
   "s" 'mu4e-headers-search
   )
  
  (general-define-key
   :keymaps 'mu4e-view-mode-map

   "." 'mu4e-view-mark-for-something
   "?" 'mu4e-view-mark-for-unread

   "C" 'mu4e-compose-new
   "F" 'mu4e-compose-forward
   "R" 'mu4e-compose-reply
   
   "d" 'mu4e-view-mark-for-trash
   "D" 'mu4e-view-mark-for-delete
   

   "t" 'mu4e-view-mark-thread
   "U" 'mu4e-view-unmark-all
   "g" 'mu4e-view-go-to-url
   "j" 'mu4e~headers-jump-to-maildir
   "m" 'mu4e-view-mark-for-move
   "n" 'mu4e-view-headers-next
   "p" 'mu4e-view-headers-prev
   "q" 'mu4e~view-quit-buffer
   "r" 'mu4e-view-mark-for-refile
   "u" 'mu4e-view-unmark
   "x" 'mu4e-view-marked-execute

   "e" 'mu4e-view-search-edit
   "s" 'mu4e-headers-search
   )

  (general-define-key
   :keymaps 'mu4e-view-mode-map
   :prefix "a"
   "" '(nil :which-key "attachment")
   "a" 'mu4e-view-attachment-action
   "s" 'mu4e-view-save-attachment
   "o" 'mu4e-view-open-attachment)


  ;; w		visual-line-mode
  ;; |		mu4e-view-pipe
  ;; <M-down>	mu4e-view-headers-next
  ;; <M-left>	mu4e-headers-query-prev
  ;; <M-right>	mu4e-headers-query-next
  ;; <M-up>		mu4e-view-headers-prev

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

  (use-package helm-mu
    :ensure t
    :init
    (general-define-key
     :keymaps 'mu4e-main-mode-map
     "<f7> m s" 'helm-mu
     "s" 'helm-mu
     )
    (general-define-key
     :keymaps 'mu4e-headers-mode-map
     "<f7> m s" 'helm-mu
     "s" 'helm-mu
     )
    (general-define-key
     :keymaps 'mu4e-view-mode-map
     "<f7> m s" 'helm-mu
     "s" 'helm-mu
     )
    )

  
  )


;; It should be defered
(use-package helm-org-contacts
  :load-path "/home/guancio/emacs-test/private/helm-org-contacts/"
  :init
  (setq org-contacts-files '("/home/guancio/Data/contacts.org"))
  
  (defun helm-contacts-2 ()
    (interactive
     (helm :sources
           '((name                           . "Contacts")
             (multiline)
             (candidates                     . helm-org-contacts-get-contacts)
             (filtered-candidate-transformer . helm-org-contacts-candidate-transformer)
             (action . (("Insert email address with name" . helm-org-contacts-insert-email-with-name)
                        ("Insert address"    . helm-org-contacts-insert-address)
                        ("Insert plain email address" . helm-org-contacts-insert-plain-email)
                        ("Insert phone number" . helm-org-contacts-insert-phone-number)
                        ("Show entry"        . helm-org-contacts-edit-entry))))
           :candidate-number-limit 500)
     ))
  (general-define-key
   :keymaps 'mu4e-compose-mode-map
   "<f7> m <tab>" 'helm-contacts-2
   )
  (general-define-key
   "<f7> a c" '(:ignore t :which-key "Contacts")
   "<f7> a c s" 'helm-contacts-2
   "<f7> a c f" (lambda ()(interactive)
                  (find-file (car org-contacts-files))
                  (widen)
                  (show-all)
                  )
   )
  )




;; (defun helm-contacts ()
;;   (interactive)
;;   (helm :sources '(helm-source-org-contacts helm-source-mu-contacts)
;;         :candidate-number-limit 500))

;; (helm-mu-contacts)


(provide 'g-mail)


