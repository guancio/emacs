(use-package async
  :ensure t)

(use-package posframe
  :ensure t)

(use-package ivy-posframe
  :load-path "/home/guancio/emacs-test/private/ivy-posframe")

;; (setq ivy-display-function #'ivy-posframe-display)
(setq ivy-display-function #'ivy-posframe-display-at-frame-center)
;; (setq ivy-display-function #'ivy-posframe-display-at-window-center)
;; (setq ivy-display-function #'ivy-posframe-display-at-frame-bottom-left)
;; (setq ivy-display-function #'ivy-posframe-display-at-window-bottom-left)
;; (setq ivy-display-function #'ivy-posframe-display-at-point)
(ivy-posframe-enable)

