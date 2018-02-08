(setq debug-on-error t
      debug-on-quit t)

(set-language-environment "UTF-8")

(require 'package)
(setq package-archives
      (append package-archives
	      '(("melpa" . "http://melpa.org/packages/"))
	      '(("org" . "http://orgmode.org/elpa/"))))
(package-initialize)
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
    (exec-path-from-shell terraform-mode dockerfile-mode smartparens ansible markdown-mode which-key flycheck smex diff-hl aggressive-indent yaml-mode elpy counsel ivy magit projectile ample-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
