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


(add-hook 'c++-mode-hook 'modern-c++-font-lock-mode)




(require 'subr-x)
(require 'cmake-ide)
(cmake-ide-setup)
(define-key c++-mode-map (kbd "<f5>") 'cmake-ide-compile)

;; (require 'rtags)
;; (require 'helm-rtags)
;; (setq rtags-autostart-diagnostics t)
;; (setq rtags-display-result-backend 'helm)
;; (rtags-diagnostics)
;; (rtags-enable-standard-keybindings)

;; (defun my-irony-mode-hook ()
  ;; (define-key irony-mode-map [remap completion-at-point]
    ;; 'irony-completion-at-point-async)
  ;; (define-key irony-mode-map [remap complete-symbol]
    ;; 'irony-completion-at-point-async)
  ;; (set (make-local-variable 'company-backends)
       ;; (cons '(:separate company-irony-c-headers company-irony :with company-yasnippet)
	     ;; (delq 'company-semantic
		   ;; (mapcar #'identity company-backends)))))

(load "~/.emacs-settings")
