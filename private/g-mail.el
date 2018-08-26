(use-package mu4e
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :commands (mu4e mu4e-headers-search mu4e-compose-new mu4e~proc-add)
  :init
  (progn
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
    ;; smtp mail setting
    (setq message-send-mail-function 'smtpmail-send-it
          smtpmail-stream-type 'starttls
          smtpmail-default-smtp-server "smtp.kth.se"
          smtpmail-smtp-server "smtp.kth.se"
          smtpmail-smtp-service 587)
    ;; don't keep message buffers around
    (setq message-kill-buffer-on-exit t)

    (general-define-key
     :prefix "M-SPC"
     "am"  '(mu4e :which-key "e-mail")
     )
    (general-define-key
     :keymaps 'mu4e-compose-mode-map
     :prefix "M-SPC m"
     "a" '(mml-attach-file :which-key "attach")
     "b" '(message-goto-body :which-key "body")
     "c" '(message-send-and-exit :which-key "send and exit")
     "q" '(message-kill-buffer :which-key "quit")
     "s" '(message-send :which-key "send")
     )
    ))

(provide 'g-mail)
