;; Emacs code broweser

;; (add-to-list 'load-path "~/.emacs.d/ecb")
(require 'ecb)
;;(require 'ecb-autoloads)
(global-set-key (kbd "C-x p") 'ecb-activate)
(global-set-key (kbd "C-x j") 'ecb-deactivate)
(global-set-key (kbd "C-x ,") 'ecb-toggle-ecb-windows)

(setq ecb-version-check t)
(setq ecb-auto-activate nil)
;; (setq ecb-tip-of-the-day-file "~/.emacs.d/ecb-tip-of-the-day.el")
(setq ecb-tip-of-the-day t) 
(setq ecb-compile-window-height 4)
(setq ecb-compile-window-temporally-enlarge  'after-selection)
(setq ecb-compile-window-width 'edit-window)

(setq ecb-layout-name "left2")
;;(setq ecb-prescan-directories-for-emptyness nil)
;; (setq ecb-tip-of-the-day-file "~/.emacs.d/ecb-tip-of-day.el")
;;main action on the left click:
(setq ecb-primary-secondary-mouse-buttons 'mouse-1--C-mouse-1)
;; for working with non-semantic sources:
;; enable ability to rebuild methods buffer for LaTeX
(setq imenu-auto-rescan t)
(setq ecb-auto-update-methods-after-save t)

(provide 'my-ecb-config)
