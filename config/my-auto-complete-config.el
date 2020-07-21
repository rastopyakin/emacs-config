;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-comlete configuration and launching
;; (add-to-list 'load-path "~/.emacs.d/auto-complete")
;; (require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-start nil)
(define-key ac-mode-map [(meta return)] 'auto-complete) 
(set-cursor-color "white")
(provide 'my-auto-complete-config)
