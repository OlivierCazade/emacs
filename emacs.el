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


(setq inhibit-startup-message t)

(column-number-mode t)
(line-number-mode t)
(global-linum-mode t)


(setq fill-column 80)

(show-paren-mode)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default show-trailing-whitespace t)
(add-hook 'diff-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(define-key global-map "\C-xk" 'kill-this-buffer)
(global-set-key [?\C-c ?\C-c] 'comment-or-uncomment-region)

;; projectile
(use-package projectile
  :diminish projectile-mode
  :init
  (projectile-global-mode)
  :bind ("M-<tab>" . projectile-find-file))

(use-package magit
  :ensure t
  :defer t
  :init
  (global-set-key (kbd "C-x g") 'magit-status)
  (setq magit-completing-read-function 'ivy-completing-read)
  )

(use-package ivy :ensure t
  :diminish (ivy-mode . "")
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
  ;; ivy completion in magit
  (setq magit-completing-read-function 'ivy-completing-read)
  ;; configure regexp engine.
  (setq ivy-re-builders-alist
	;; allow input not in order
        '((t   . ivy--regex-ignore-order)))
  ;; use ivy as projectile completion
  (setq projectile-completion-system 'ivy)
  )

(use-package counsel
  :ensure t
  :bind
  (("M-x" . counsel-M-x)
   ("C-s" . swiper))
  )

(setq c-default-style "linux"
      c-basic-offset 4
      tab-width 4
      indent-tabs-mode t)

(global-auto-revert-mode t)

(setq py-python-command "python3")

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
  :init
  (global-aggressive-indent-mode 1)
  ;;  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  )

(use-package diff-hl
  :ensure t
  :defer t
  :init
  (global-diff-hl-mode 1)
  )


(use-package smex
  :ensure t
  :defer t
  :init (smex-initialize))

(use-package flycheck
  :ensure t
  :defer t
  :init
  (global-flycheck-mode)
  )

(setq flycheck-python-pycompile-executable "python3")

(use-package flyspell
  :ensure t
  :defer t
  :init
  (progn
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)
    )
  :config
  ;; Sets flyspell correction to use two-finger mouse click
  (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
  )

;; (defun is-current-file-tramp ()
;;   (tramp-tramp-file-p (buffer-file-name (current-buffer))))

;; (use-package tramp
;;   :ensure t
;;   :defer t
;;   :init
;;   (add-hook
;;    'find-file-hook
;;    (lambda () (if (is-current-file-tramp) (setq-local make-backup-files nil))))
;;   )

(use-package which-key
  :ensure t
  :defer t
  :init (which-key-mode 1))

(use-package markdown-mode
  :defer t
  :ensure t
  )

(use-package ansible
  :defer t
  :ensure t
  :init
  (add-hook 'yaml-mode-hook '(lambda () (ansible 1)))
  )

(use-package smartparens
  :ensure t
  :init
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode t)))

(use-package dockerfile-mode
  :defer t
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
  )

(use-package exec-path-from-shell
  :ensure t
  :defer f
  :init
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "SHELL")
  (exec-path-from-shell-copy-env "PATH")
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(setq debug-on-error nil
      debug-on-quit nil)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(defun notify-compilation-result(buffer msg)
  (if (string-match "^finished" msg)
      (progn
	(kill-this-buffer)))
  (setq current-frame (car (car (cdr (current-frame-configuration)))))
  (select-frame-set-input-focus current-frame)
  )

(add-to-list 'compilation-finish-functions
	     'notify-compilation-result)

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups
