;;AUCTEX loading
;; (load "auctex.el" nil t t) ;; loaded by package-initialize
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;; enable forward/inverse search
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'visual-fill-column-mode)

;; viewers customization
(setq TeX-view-program-selection
      '((output-dvi "xdvi")
	 (output-pdf "PDF Tools")
	 (output-html "xdg-open")))
(add-hook 'TeX-after-compilation-finished-functions
	  #'TeX-revert-document-buffer)

(require 'pdf-tools)
(pdf-tools-install)

(setq TeX-newline-function 'newline-and-indent)

(setq TeX-file-line-error t)
(setq TeX-command-extra-options "")

;; this activates RefTex
(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(require 'company-auctex)
(defun my-company-auctex-init ()
  "Add backends provided by company-auctex to company-backends."
  (set (make-local-variable 'company-backends)
       '((company-auctex-macros company-auctex-symbols company-auctex-environments)
	 company-auctex-labels company-auctex-bibs)))
;; (company-auctex-init)

(defun my-LaTeX-hook()
  (my-company-auctex-init)
  (local-set-key [(control return)] 'TeX-complete-symbol))
(add-hook 'LaTeX-mode-hook 'my-LaTeX-hook)

(add-hook 'TeX-mode-hook 'prettify-symbols-mode)

(defadvice LaTeX-fill-region-as-paragraph (around LaTeX-sentence-filling)
  "Start each sentence on a new line."
  (let ((from (ad-get-arg 0))
	(fill-column 10000)
        (to-marker (set-marker (make-marker) (ad-get-arg 1)))
        tmp-end)
    (while (< from (marker-position to-marker))
      (forward-sentence)
      ;; might have gone beyond to-marker --- use whichever is smaller:
      (ad-set-arg 1 (setq tmp-end (min (point) (marker-position to-marker))))
      ad-do-it
      (ad-set-arg 0 (setq from (point)))
      (unless (or
               (bolp)
               (looking-at "\\s *$"))
        (LaTeX-newline)))
    (set-marker to-marker nil)))
(ad-activate 'LaTeX-fill-region-as-paragraph)

(provide 'my-auctex-config)
