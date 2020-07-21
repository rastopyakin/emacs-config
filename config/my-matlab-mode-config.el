;; (add-to-list 'load-path "~/.emacs.d/lisp/matlab-emacs/")
;; (require 'matlab-load)
(matlab-cedet-setup)
;; (setq matlab-change-current-directory 'on)

(setq matlab-shell-command-switches '("-nodesktop" "-nosplash"))
(setq matlab-completion-technique 'increment)
;; (matlab-shell-enable-gud-flag t)

; if you want function bodies indented
(setq matlab-indent-function-body t)
;; somw custom code
(defun my-matlab-pwd ()
  "Ask MATLAB about it's current working directory"
  (let (
	(matlab-ans (matlab-shell-collect-command-output "cd"))
	(dir))
    (setq dir (nth 1 (split-string matlab-ans "\n")))
    (concat dir "/")))

(defun my-matlab-shell-save-and-go ()
  "Check whether MATLAB working dir and current buffer's dir are
  the same and if not change MATLAB's dir appropriately. Then run
  matlab-shell-save-and go function"
  (interactive)
  (let ((buffer-dir (file-name-directory (buffer-file-name)))
	(matlab-dir (my-matlab-pwd)))
    (if (not (string-equal buffer-dir matlab-dir))
	(progn
	  (matlab-shell-collect-command-output
	   (concat "cd('" buffer-dir "')"))
	  (matlab-shell-save-and-go)
	  (message (concat "MATLAB working dir is changed from "
			   matlab-dir " to " buffer-dir)))
      (matlab-shell-save-and-go))))

(defun my-matlab-mode-hook()
  (local-set-key [f5] 'my-matlab-shell-save-and-go)
  (local-set-key (kbd "C-c C-s") 'matlab-shell)
  (local-set-key [(control return)] 'matlab-complete-symbol)
  (matlab-functions-have-end-minor-mode 1)
  )
(defun my-matlab-shell-mode-hook ()
  (setq-local yas-dont-activate-functions t)
  )
(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)

(provide 'my-matlab-mode-config)
