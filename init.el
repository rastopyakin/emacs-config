;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)

(dap-mode 1)
;; Enabling only some features
(setq dap-auto-configure-features '(expressions controls tooltip))

(add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra)))
;; The modes below are optional

;; (dap-ui-mode 1)
;; ;; enables mouse hover support
;; (dap-tooltip-mode 1)
;; ;; use tooltips for mouse hover
;; ;; if it is not enabled `dap-mode' will use the minibuffer.
;; (tooltip-mode 1)
;; ;; displays floating panel with debug buttons
;; ;; requies emacs 26+
;; (dap-ui-controls-mode 1)

(require 'dap-lldb)



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

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(require 'cmake-ide)
(setq cmake-ide-header-search-other-file nil)
;; (cmake-ide-setup)
(define-key c++-mode-map (kbd "<f5>") 'cmake-ide-compile)


(defun cmake/lsp-ide-maybe-start-lsp ()
  "Starts LSP mode"
  (interactive)
  (when (and (cide--comp-db-file-name) (file-exists-p (cide--comp-db-file-name)))
    (cide--message "configuring lsp")
    (let ((compile-commands-dir  (concat "--compile-commands-dir=" (cide--build-dir))))
      (push compile-commands-dir lsp-clients-clangd-args))
    (make-local-variable 'lsp-clients-clangd-args)
    (lsp)))

(defun cide/lsp-register-callback ()
  (cide--register-a-callback
   (lambda (process _event)
     (cide--message "Finished running CMake")
     (if (= 0 (process-exit-status process)) ; only perform post cmake operation on success.
         (cmake/lsp-ide-maybe-start-lsp)
       (cide--message "CMake failed, see *cmake* for details."))
     (setq cmake-sentinel-flag nil)
     (setq cmake-temp-project-dir nil))))

(defun cide/lsp-maybe-run-cmake ()
  (interactive)
  (cmake-ide-maybe-run-cmake)
  (if (get-process "cmake")
      (cide/lsp-register-callback)
    (cmake/lsp-ide-maybe-start-lsp)))

(defun cmake/lsp-ide-mode-hook ()
  (add-hook 'find-file-hook #'cide/lsp-maybe-run-cmake nil 'local)
  ;; (cmake/lsp-ide-maybe-start-lsp)
  (cmake-ide-maybe-start-rdm))

(require 'lsp-mode)
(setq lsp-completion-provider :capf)
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))
(setq lsp-auto-guess-root t)
(setq lsp-clients-clangd-args '("--completion-style=bundled"))
(add-hook 'c++-mode-hook #'cmake/lsp-ide-mode-hook)
(add-hook 'c-mode-hook #'cmake/lsp-ide-mode-hook)
(add-hook 'before-save-hook #'cide--before-save)

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



;; (require 'subr-x)

(add-to-list 'load-path "~/.emacs.d/freefem-mode-master")
;; (require 'freefem++-mode)
(autoload 'freefem++-mode "freefem++-mode"
  "Major mode for editing FreeFem++ code." t)
(add-to-list 'auto-mode-alist '("\\.edp$" . freefem++-mode))
(add-to-list 'auto-mode-alist '("\\.idp$" . freefem++-mode))

;; (setq freefempp-program "FreeFem++-nw")

(load "~/.emacs-settings")
