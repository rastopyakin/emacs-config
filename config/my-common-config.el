(add-to-list 'display-buffer-alist
             '("." nil (reusable-frames . t)))

(setq inhibit-startup-screen t)
(setq-default major-mode 'text-mode)

(setq default-frame-alist '((vertical-scroll-bars . nil)
			    (menu-bar-lines . nil)
			    (tool-bar-lines . nil)
			    (fullscreen . maximized)
			    (font . "DejaVu Sans Mono-10")))

;; the theme
(load-theme 'monokai t)
(doom-modeline-mode 1)

(show-paren-mode 1)

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

(require 'my-helm-config)

(require 'projectile)
(setq projectile-completion-system 'helm)
(setq projectile-indexing-method 'hybrid)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode)

(require 'helm-projectile)
(helm-projectile-on)

;; filemanagers
(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(treemacs-icons-dired-mode)


(defun my-is-current-buffer-treemacs-buffer ()
  "Returns t if the current buffer is Treemacs buffer"
  (eq (treemacs-get-local-buffer) (current-buffer)))

(defun my-move-to-treemacs-dwim ()
  "Currently just move the point to/from the Treemacs buffer"
  (interactive)
  (if (my-is-current-buffer-treemacs-buffer)
      (treemacs-visit-node-default)
    (treemacs-select-window)))

(define-key global-map (kbd "<f8>") 'my-move-to-treemacs-dwim)
(setq treemacs-is-never-other-window t)

(setq treemacs-indentation-string (propertize "|" 'face 'font-lock-comment-face)
      treemacs-indentation 1)
(treemacs-resize-icons 12)
(setq treemacs-width 25)

(with-eval-after-load 'treemacs
  (add-to-list 'treemacs-pre-file-insert-predicates #'treemacs-is-file-git-ignored?)
  (require 'treemacs-magit))

;; miscellaneous

(defun my-smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.
If point was already at that position, move
point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (beginning-of-visual-line)
    (if (= oldpos (point))
	(back-to-indentation))))

(define-key visual-line-mode-map [remap move-beginning-of-line] 'my-smart-beginning-of-line)

(global-set-key (kbd "C-'") 'comment-line)

(add-hook 'after-save-hook 'delete-trailing-whitespace)

(provide 'my-common-config)
