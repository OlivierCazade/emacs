(setq debug-on-error t
      debug-on-quit t)

(set-language-environment "UTF-8")

(require 'package)
(setq package-archives
      (append package-archives
	      '(("melpa-stable" . "http://stable.melpa.org/packages/"))
	      '(("melpa" . "http://melpa.org/packages/"))
	      '(("org" . "http://orgmode.org/elpa/"))))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(setq package-archive-priorities
      '(("melpa-stable" . 15)
        ("org" . 10)
	("melpa" . 5)))
(setq package-enable-at-startup nil)

;; Use-package conf
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; Load the config
(org-babel-load-file (concat user-emacs-directory "config.org"))

(setq debug-on-error nil
      debug-on-quit nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (feature-mode use-package yaml-mode which-key terraform-mode smex smartparens restclient markdown-mode magit ibuffer-projectile google-this expand-region exec-path-from-shell elpy dockerfile-mode delight counsel bind-key ansible ample-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
