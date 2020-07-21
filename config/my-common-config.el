(add-to-list 'display-buffer-alist
             '("." nil (reusable-frames . t)))

(setq inhibit-startup-screen t)
(setq-default major-mode 'text-mode)

(setq default-frame-alist '((vertical-scroll-bars . nil)
			    (tool-bar-lines . 0)
			    (menu-bar-lines . 0)
			    (fullscreen . maximized)))

(show-paren-mode 1)

;; the theme
(load-theme 'monokai t)

;; default font
(when (member "DejaVu Sans Mono" (font-family-list))
    (add-to-list 'initial-frame-alist '(font . "DejaVu Sans Mono-10"))
    (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10")))

;; (global-set-key "\C-u" 'backward-kill-word)

(setq-default fill-column 90)
;; y&n instead of yes&no
(fset 'yes-or-no-p 'y-or-n-p)
;;Saving session
;;(desktop-save-mode t)

;; tune visual-line-mode via auxiliary packages
(require 'visual-fill-column)
(require 'adaptive-wrap)
(add-hook 'visual-line-mode-hook 'adaptive-wrap-prefix-mode)
(add-hook 'visual-fill-column-mode-hook
	  (lambda ()
	    (setq split-window-preferred-function
		  'visual-fill-column-split-window-sensibly)))

(global-visual-line-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow nil))
(setq-default sentence-end-double-space nil)

(require 'yasnippet)
(yas-global-mode 1)

(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)

(require 'my-helm-config)

(require 'projectile)
(setq projectile-completion-system 'helm)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode)

(require 'helm-projectile)
(helm-projectile-on)

(defun my-smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.
Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of
line."
  (interactive) ; Use (interactive "^") in Emacs 23 to make shift-select work
  (let ((oldpos (point)))
    (beginning-of-visual-line)
    (and (= oldpos (point))
	 (back-to-indentation))
    )
  )

(define-key visual-line-mode-map [remap move-beginning-of-line] 'my-smart-beginning-of-line)

(global-set-key (kbd "C-'") 'comment-line)

(add-hook 'after-save-hook 'delete-trailing-whitespace)

(provide 'my-common-config)
