;; (add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
;; (add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp")
(require 'cl)
(require 'org)
(require 'org-drill)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)

(add-to-list 'org-modules 'org-drill t)

;; todo states
(setq org-todo-keywords
      '((sequence "TODO" "ACTIVE" "INTERRUPTED" "|" "DONE" "CANCELED")))

;; some custom varibles
(setq org-special-ctrl-a/e t)
(setq org-log-done 'time)

(provide 'my-org-mode-config)
