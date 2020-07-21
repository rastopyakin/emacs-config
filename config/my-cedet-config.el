;;CEDET configuration
(setq cedet-root-path (file-name-as-directory "~/.emacs.d/lisp/cedet/"))
(load-file (concat cedet-root-path "cedet-devel-load.el"))
(load-file (concat cedet-root-path "contrib/cedet-contrib-load.el"))
(add-to-list 'load-path cedet-root-path)
(add-to-list 'load-path (concat cedet-root-path "contrib"))
;loading submodes
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode) 
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)


(semantic-mode 1)
;; (require 'semantic/ia)
;; (require 'semantic/bovine/gcc)
;; (require 'cedet-files)
;; (require 'eassist)
;;(require 'semantic/bovine/clang)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;customisation for C/C++
(defun my-c-mode-cedet-hook ()
  (interactive)
  ;;(semantic-clang-activate) doesn`t work properly
  (setq ac-sources '(ac-source-semantic ac-source-dictionary))
  
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu) 
  (local-set-key "\C-c?" 'semantic-analyze-possible-completions)
  (local-set-key [(control tab)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-cl" 'eassist-list-methods)
  )
;; (add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)
;;EDE tuning
;; (global-ede-mode 1)
;; (ede-enable-generic-projects)

;;GNU Global turn on
(when (cedet-gnu-global-version-check t)
  (semanticdb-enable-gnu-global-databases 'c-mode t)
  (semanticdb-enable-gnu-global-databases 'c++mode t))

(when (cedet-ectag-version-check t)
  (semantic-load-enable-primary-ectags-support))


;; Create a Project.ede equivalent for ede-simple-project
;; by telling Emacs to load Project.el files
(defun check-for-Project-el ()
  (if (file-exists-p "Project.el")
    (load-file "Project.el")
  )
)
;; (add-hook 'c-mode-common-hook 'check-for-Project-el)
;;(semantic-add-system-include "the path" 'c++-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(provide 'my-cedet-config)

