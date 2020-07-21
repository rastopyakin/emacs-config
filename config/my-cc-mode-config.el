(require 'cc-mode)

(defun my-cc-mode-hook()
  (c-set-style "stroustrup")
  ;; setting some keystrokes for commenting code
  (local-set-key (kbd "C-;") 'kill-comment)
  )

(add-hook 'c-mode-common-hook 'my-cc-mode-hook)

(add-to-list 'load-path "~/.local/share/emacs/site-lisp/rtags/")

(provide 'my-cc-mode-config)
