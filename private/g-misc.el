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


(provide 'g-misc)


