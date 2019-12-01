;; emacs26 -q --load "/home/guancio/emacs-test/init.el"

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(add-to-list 'load-path (concat user-emacs-directory "emacs-test/private/"))

;; benckmark: doe not work
;; (esup "/home/guancio/emacs-test/init.el")

(require 'g-defaults)
(require 'g-general-edit)
(require 'g-theme)
(require 'g-keys)
(require 'g-text)
(require 'g-prog)
(require 'g-org)
(require 'g-mail)
(require 'g-spell)
(require 'g-latex)
(require 'g-dired)
(require 'g-window)
(require 'g-elisp)
(require 'g-lsp)
(require 'g-python)
;; (require 'g-cpp)
(require 'g-shell)
(require 'g-git)
(require 'g-project)
(require 'g-misc)


;; company
;; how about eldoc on a sidebar?
;; xref find reference with helm

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3da031b25828b115c6b50bb92a117f5c0bbd3d9d0e9ba5af3cd2cb9db80db1c2" default)))
 '(package-selected-packages
   (quote
    (ivy-posframe all-the-icons-ivy ivy-xref flyspell-correct-ivy smex ivy-hydra counsel ivy-rich ivy posframe mu4e-conversation boon-qwerty weechat slack avy avy-goto boon-powerline-theme keycast gif-screencast boon xah-fly-keys frames-only-mode frames-only hide-mode-line workgroups projectile gruvbox groovebox wuxch-dired-copy-paste dired-copy-paste 2048-game elmacro gnus-dired magit helm-mu company-lsp keyfreq helm-org-contacts oauth2 bash-completion lsp-python lsp-ui company flycheck lsp-mode dired-du helm-xref disable-mouse general solaire-mode zenburn-theme zen-and-art-theme yapfify xterm-color ws-butler winum white-sand-theme which-key volatile-highlights vi-tilde-fringe uuidgen use-package underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme toc-org tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme stickyfunc-enhance srefactor spaceline spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle shell-pop seti-theme reverse-theme restart-emacs rebecca-theme rainbow-delimiters railscasts-theme pyvenv pytest pyenv-mode py-isort purple-haze-theme professional-theme popwin planet-theme pip-requirements phoenix-dark-pink-theme phoenix-dark-mono-theme persp-mode pdf-tools pcre2el paradox ov orgit organic-green-theme org-present org-pomodoro org-mime org-gcal org-download org-bullets open-junk-file omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme ob-async noctilux-theme neotree naquadah-theme mustang-theme multi-term mu4e-maildirs-extension mu4e-alert move-text monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme magit-gitflow madhat2r-theme macrostep lush-theme lorem-ipsum live-py-mode linum-relative link-hint light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme indent-guide imenu-list ibuffer-sidebar ibuffer-projectile hy-mode hungry-delete htmlize howdoi hl-todo highlight-parentheses highlight-numbers highlight-indentation heroku-theme hemisu-theme helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-exwm helm-descbinds helm-ag hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gandalf-theme frame-local flyspell-correct-helm flx-ido flatui-theme flatland-theme fill-column-indicator farmhouse-theme fancy-battery eyebrowse expand-region exotica-theme exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu espresso-theme eshell-z eshell-prompt-extras esh-help elisp-slime-nav eglot dumb-jump dracula-theme doom-themes django-theme disaster dired-sidebar diminish define-word darktooth-theme darkokai-theme darkmine-theme darkburn-theme dakrone-theme cython-mode cyberpunk-theme column-enforce-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized cmake-mode clues-theme clean-aindent-mode clang-format cherry-blossom-theme calfw busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk apropospriate-theme anti-zenburn-theme anaconda-mode ample-zen-theme ample-theme all-the-icons-dired alect-themes aggressive-indent afternoon-theme adaptive-wrap ace-window ace-link ace-jump-helm-line))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
