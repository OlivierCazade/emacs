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

;; Theme configuration
(use-package ample-theme
	     :init (progn (load-theme 'ample t t)
			  (enable-theme 'ample))
	     :defer t
	     :ensure t)


(setq inhbit-startup-message t)

(column-number-mode t)
(line-number-mode t)
(global-linum-mode t)

(show-paren-mode)

(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(define-key global-map "\C-xk" 'kill-this-buffer)

;; (require 'ido)
;; (ido-mode t)
;; (setq ido-auto-merge-work-directories-length -1)

(use-package ivy :ensure t
  :diminish (ivy-mode . "")
  :bind
  (:map ivy-mode-map
   ("C-'" . ivy-avy))
  :init
  (ivy-mode 1)
  ;; add ‘recentf-mode’ and bookmarks to ‘ivy-switch-buffer’.
  (setq ivy-use-virtual-buffers t)
  ;; number of result lines to display
  (setq ivy-height 10)
  ;; does not count candidates
  (setq ivy-count-format "")
  ;; no regexp by default
  (setq ivy-initial-inputs-alist nil)
  ;; configure regexp engine.
  (setq ivy-re-builders-alist
	;; allow input not in order
        '((t   . ivy--regex-ignore-order))))

(setq c-default-style "linux"
      c-basic-offset 4
      tab-width 4
      indent-tabs-mode t)

(global-auto-revert-mode t)

;; org-mod
(use-package org
  :mode (("\\.org$" . org-mode))
  :ensure t
  :defer t
  :init
  (progn
    (setq org-log-done t)
    )
  :bind
  ("C-c a" . org-agenda)
  )

(use-package yaml-mode
  :ensure t
  :defer t
  )


(use-package aggressive-indent
  :ensure t
  :defer t
  :config
  (global-aggressive-indent-mode 1)
;;  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  )

(use-package diff-hl
  :ensure t
  :defer t
  :init
  (global-diff-hl-mode 1)
  )


(use-package flycheck
  :ensure t
  :defer t
  :init
  (global-flycheck-mode 1)
  )

(defun is-current-file-tramp ()
  (tramp-tramp-file-p (buffer-file-name (current-buffer))))

(use-package tramp
  :ensure t
  :defer t
  :config
  (add-hook
   'find-file-hook
   (lambda () (if (is-current-file-tramp) (setq-local make-backup-files nil))))
  )

(use-package magit
  :ensure t
  :defer t
  :init
  (global-set-key (kbd "C-x g") 'magit-status)
  )

(use-package which-key
  :ensure t
  :defer t
  :config (which-key-mode 1))

(use-package markdown-mode
  :defer t
  :ensure t
  )

(use-package dockerfile-mode
  :defer t
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
  )

(setq debug-on-error nil
      debug-on-quit nil)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))
