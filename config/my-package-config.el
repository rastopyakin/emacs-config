; setting up package repositories for ELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(setq package-enable-at-startup nil)
(package-initialize)

(provide 'my-package-config)
