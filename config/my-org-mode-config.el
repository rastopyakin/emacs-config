;; (add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
;; (add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp")
(require 'org)
(require 'org-drill)
(require 'org-projectile)

(org-projectile-per-project)
(push (org-projectile-project-todo-entry) org-capture-templates)
(push (org-projectile-project-todo-entry
       :capture-character "l"
       :capture-heading "TODO bookmark"
       :capture-template "* TODO %?\n [[%l][link]]")
      org-capture-templates)

(add-hook 'org-mode-hook #'org-bullets-mode)

(require 'org-noter-pdftools)
(add-hook 'org-mode-hook #'org-pdftools-setup-link)

(add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)

(add-to-list 'org-modules 'org-drill t)

(require 'org-noter-pdftools)
(add-hook 'org-mode-hook #'org-pdftools-setup-link)
(add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)

;; todo states
(setq org-todo-keywords
      '((sequence "TODO(t)" "ACTIVE(a)" "|" "DONE(d)")))

;; some custom varibles
(setq org-special-ctrl-a/e t)
(setq org-log-done 'time)

(add-hook 'org-mode-hook 'org-bullets-mode)



(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(provide 'my-org-mode-config)
