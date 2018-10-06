(add-hook 'text-mode-hook 'auto-fill-mode)


(general-define-key
 :prefix "<f7> t"
 :keymaps 'text-mode-map
 "f" 'auto-fill-mode
 )


(provide 'g-text)
