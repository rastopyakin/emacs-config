(require 'helm)
(require 'helm-config)

(customize-set-variable 'helm-command-prefix-key "C-c h")
(helm-mode 1)
(when (executable-find "curl")
  (setq helm-net-prefer-curl t))

(setq helm-split-window-inside-p            nil
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-scroll-amount                    2
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

;; (setq helm-M-x-fuzzy-match t)

(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap switch-to-buffer] 'helm-mini)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(define-key global-map [remap apropos-command] 'helm-apropos)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 50)
(helm-autoresize-mode 1)

(provide 'my-helm-config)
