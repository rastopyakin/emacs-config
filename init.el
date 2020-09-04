;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)



(when (< emacs-major-version 27)
  (setq package-enable-at-startup nil)
  (package-initialize))

(add-to-list 'load-path "~/.emacs.d/config")

(require 'my-common-config)

(require 'my-cc-mode-config)
;; packages installed through elpa

(require 'my-org-mode-config)

(require 'company)
(global-company-mode)
(company-quickhelp-mode 1)
(setq company-idle-delay 0)

(require 'my-auctex-config)
(require 'my-matlab-mode-config)

(require 'my-elpy-config)

(require 'rtags)
;; (require 'company-rtags)
;; (setq rtags-completions-enabled t)
(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(rtags-enable-standard-keybindings)
(setq rtags-display-result-backend 'helm)
;; (require 'helm-rtags)
;; (setq rtags-use-helm t)

(require 'irony)
(require 'company-irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(require 'company-irony-c-headers)
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async)
  (set (make-local-variable 'company-backends)
       (cons '(:separate company-irony-c-headers company-irony :with company-yasnippet)
	     (delq 'company-semantic
		   (mapcar #'identity company-backends)))))

(add-hook 'irony-mode-hook #'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(add-hook 'c++-mode-hook 'modern-c++-font-lock-mode)

(require 'irony-eldoc)
(add-hook 'irony-mode-hook 'irony-eldoc)

(define-key c-mode-base-map (kbd "<C-return>") (function company-complete))


(require 'subr-x)
(require 'cmake-ide)
(cmake-ide-setup)
(define-key c++-mode-map (kbd "<f5>") 'cmake-ide-compile)

(load "~/.emacs-settings")
