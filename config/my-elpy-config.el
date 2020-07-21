(require 'elpy)
(setq elpy-rpc-backend "jedi")
(setq elpy-rpc-python-command "python3")
;; (elpy-use-ipython "ipython3")
(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "-i")
(setq elpy-remove-modeline-lighter t)
(setq elpy-modules
      (delq 'elpy-module-company
	    (delq 'elpy-module-flymake elpy-modules)))
(defun my-elpy-module-company (command &rest args)
  "Module to support company-mode completions."
  (pcase command
    (`global-init
     (elpy-modules-remove-modeline-lighter 'company-mode)
     (define-key company-active-map (kbd "C-d")
       'company-show-doc-buffer))
    (`buffer-init
     (set (make-local-variable 'company-tooltip-align-annotations)
          t)
     (set (make-local-variable 'company-backends)
          (cons '(:separate elpy-company-backend :with company-yasnippet)
                (delq 'company-semantic
                      (delq 'company-ropemacs
                            (delq 'company-capf
                                  (mapcar #'identity company-backends)))))))
    (`buffer-stop
     (kill-local-variable 'company-tooltip-align-annotations)
     (kill-local-variable 'company-backends))
    ))
(add-to-list 'elpy-modules 'my-elpy-module-company)
;; (when (require 'flycheck nil t)
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))
;; (define-key python-mode-map (kbd "<C-return>") (function company-complete))
(elpy-enable)

(provide 'my-elpy-config)
