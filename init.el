;; gnutls must be installed!
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

(package-initialize)

;; Make sure use-package is installed
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)

;; Auto install packages that aren't installed
(setq use-package-always-ensure t)

;; Disable splash screen
(setq inhibit-splash-screen t)

;; Shows where the cursor is in the menu bar
(setq column-number-mode t)

;; Line number
(global-linum-mode t)

;; Global text settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Make sure all buffers get unique names
(setq uniquify-buffer-name-style      'post-forward
      uniquify-separator              ":"
      uniquify-after-kill-buffer-p t  ;; rename after killing uniquified
      uniquify-ignore-buffers-re      "^\\*")

;; Highlight dangerous C functions
(add-hook 'c-mode-hook (lambda () (font-lock-add-keywords nil '(("\\<\\(malloc\\|calloc\\|free\\|realloc\\)\\>" . font-lock-warning-face)))))

;; Keybindings
;; Navigation
(global-set-key (kbd "M-g b") 'beginning-of-buffer)
(global-set-key (kbd "M-g e") 'end-of-buffer)

;; Multiple windows
(global-set-key (kbd "C-x <left>")  'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <up>")    'windmove-up)
(global-set-key (kbd "C-x <down>")  'windmove-down)
(global-set-key (kbd "C-x |")  'split-window-horizontally)
(global-set-key (kbd "C-x -")  'split-window-below)

;; Multiple cursors
(use-package multiple-cursors
  :bind
  ("M-Å" .  'mc/mark-all-like-this)
  ("M-Ä" .  'mc/mark-previous-like-this-word)
  ("M-ä" .  'mc/mark-next-like-this-word)
  ("M-P" .  'mc/mark-more-like-this-extended))

;; Rebind undo
(global-set-key (kbd "C-z") 'undo)

;; Remove/kill completion buffer when done
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(ido-vertical-define-keys (quote C-n-C-p-up-down-left-right))
 '(ido-vertical-show-count t)
 '(package-selected-packages
   (quote
    (ggtags move-text yasnippet flycheck company-c-headers company ido-vertical-mode smex sml-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Nice fuzzy matching for M-x
(use-package smex
  :config
  (progn
    (setq smex-save-file "~/.emacs.d/smex.save")
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'execute-extended-command)
    (smex-initialize)))

(use-package ido-vertical-mode
  :config
  (ido-vertical-mode))

(use-package company
  :config
  ;; Speeds up company
  (setq company-idle-delay 0))

(use-package flycheck)
(use-package yasnippet)

(add-hook 'c-mode-common-hook
          (lambda()
            (progn
              (global-company-mode)
              (flycheck-mode t)
              )))

;; Completes includes for c
(use-package company-c-headers
  :config
  (add-to-list 'company-backends 'company-c-headers))

;; GGtags
(use-package ggtags
  :init
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
                (ggtags-mode 1))))
  :bind (:map ggtags-mode-map
              ("C-c g r" . ggtags-find-reference)
              ("C-c g c" . ggtags-create-tags)
              ("C-c g u" . ggtags-update-tags)
              ("C-c g d" . ggtags-find-definition))
   :diminish ggtags-mode)

;; Command for moving lines
(use-package move-text
  :bind
  (("M-S-<up>"   . move-text-up)
   ("M-S-<down>" . move-text-down)))

;; Store files ending with ~ in a separete folder
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "file-backups")))))