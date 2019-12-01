
(use-package spot4e
  :load-path "/home/guancio/emacs-test/private/spot4e/"
  :init
  (setq spot4e-refresh-token "AQA6jFRkB04LELP_WK8G0wsfJPT_1DsEfoAIXpe6-qvVG0GrhrAZo59Er0CvzNua95t2mNOztUaMGz6cTQgvBbMg5dKwCbKo1UdYPfMPTGHReR76gVF6wqsJ3loeW86zynd0oA")
  ;; (run-with-timer 0 (* 60 59) 'spot4e-refresh)
  (general-define-key
   "<f7> a x a" 'spot4e-search-artists
   "<f7> a x t" 'spot4e-search-tracks
   "<f7> a x A" 'spot4e-authorize
   )
  )

(use-package 2048-game
  :ensure t
  :init
  (general-define-key
   "<f7> a 2" '2048-game
   )
  )

(provide 'g-misc)

 

;; (xah-fly-keys-set-layout "qwerty") 
;; (use-package xah-fly-keys :ensure t)
;; (xah-fly-keys 1)

;; (use-package boon
;;   :ensure t
;;   :init
;;   (require 'boon-qwerty)
;;   (boon-mode nil)
;;   )
;; (require 'boon-powerline)
(use-package gif-screencast
  :ensure t
  :init
  (general-define-key
   "<f7> a c s" 'gif-screencast
   "<f7> a c e" 'gif-screencast-stop
   ))
(use-package keycast
  :ensure t
 )
