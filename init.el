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

;; Load theme
(use-package spacemacs-theme
  :no-require t
  :config
  (load-theme 'spacemacs-dark t))

;; Disable splash screen
(setq inhibit-splash-screen t)

;; Disable menubar and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(electric-pair-mode)
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

;; Rebind undo
(global-set-key (kbd "C-z") 'undo)

;; Duplicate a line
(global-set-key (kbd "C-ö") "\C-a\C- \C-n\M-w\C-y\C-p")

;; Multiple cursors
(use-package multiple-cursors
  :bind
  ("M-Å" .  'mc/mark-all-like-this)
  ("M-Ä" .  'mc/mark-previous-like-this-word)
  ("M-ä" .  'mc/mark-next-like-this-word)
  ("M-P" .  'mc/mark-more-like-this-extended))

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
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(fci-rule-color "#383838")
 '(flycheck-checkers
   (quote
    (meghanada meghanada-live ada-gnat asciidoctor asciidoc c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint css-stylelint cwl d-dmd dockerfile-hadolint emacs-lisp emacs-lisp-checkdoc erlang-rebar3 erlang eruby-erubis fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck go-unconvert go-megacheck groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy javascript-eslint javascript-jshint javascript-standard json-jsonlint json-python-json jsonnet less less-stylelint llvm-llc lua-luacheck lua markdown-markdownlint-cli markdown-mdl nix perl perl-perlcritic php php-phpmd php-phpcs processing proselint protobuf-protoc pug puppet-parser puppet-lint python-flake8 python-pylint python-pycompile python-mypy r-lintr racket rpm-rpmlint rst-sphinx rst ruby-rubocop ruby-reek ruby-rubylint ruby ruby-jruby rust-cargo rust rust-clippy scala scala-scalastyle scheme-chicken scss-lint scss-stylelint sass/scss-sass-lint sass scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim slim-lint sql-sqlint systemd-analyze tcl-nagelfar tex-chktex tex-lacheck texinfo typescript-tslint verilog-verilator vhdl-ghdl xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby)))
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(ido-vertical-define-keys (quote C-n-C-p-up-down-left-right))
 '(ido-vertical-show-count t)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (rainbow-delimiters company-auctex auctex tex eyebrowse format-all git-gutter-fringe nv-delete-back smart-hungry-delete meghanada swiper idomenu magit ggtags move-text yasnippet flycheck company-c-headers company ido-vertical-mode smex sml-mode)))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter-fr:added ((t (:foreground "green" :weight bold))))
 '(git-gutter-fr:modified ((t (:foreground "dodger blue" :weight bold)))))

;; Nice fuzzy matching for M-x
(use-package smex
  :config
  (progn
    (setq smex-save-file "~/.emacs.d/smex.save")
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'execute-extended-command)
    (smex-initialize)))

;; Setup imenu
(use-package idomenu
  :config
  (setq imenu-auto-rescan t)
  :bind
  (("M-i" . idomenu)))

(use-package ido-vertical-mode
  :config
  (ido-vertical-mode))

(use-package eyebrowse
  :init
  (setq eyebrowse-keymap-prefix "")
  :config
  (eyebrowse-mode t))

(use-package company
  :config
  ;; Speeds up company
  (setq company-idle-delay 0))

(use-package flycheck)
(use-package yasnippet)
(use-package yasnippet-snippets)

(use-package swiper
  :bind
  ("C-s" . swiper)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (ivy-mode 1))

;; If the installation of the server does not work, download the setup from the projects github
(use-package meghanada
  :init
  (cond
   ((eq system-type 'windows-nt)
    (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
    (setq meghanada-maven-path "mvn.cmd"))
   (t
    (setq meghanada-java-path "java")
    (setq meghanada-maven-path "mvn")))
  :config
  (add-hook 'java-mode-hook
            (lambda ()
              ;; meghanada-mode on
              (meghanada-mode t)
              (flycheck-mode t)
              (company-mode t)
              (setq c-basic-offset 2)
              (add-hook 'before-save-hook 'delete-trailing-whitespace))))

;; Delets words like modern editors
(use-package nv-delete-back
  :bind
  ("C-<backspace>" . nv-delete-back-all)
  ("M-<backspace>" . nv-delete-back))

(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode))

(use-package magit)

(add-hook 'c-mode-common-hook
          (lambda()
            (progn
              (global-company-mode)
              (flycheck-mode t)
              )))

(add-hook 'c-mode-common-hook
          (lambda ()
            (let* ((file (concat user-emacs-directory "emacs-c-astyle-config")))
              (if (file-exists-p (concat file ".el"))
                  (progn 
                    (load file)
                    (add-hook 'after-save-hook 'astyle-after-save))))))

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

(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

(global-set-key (kbd "C-c i") #'find-user-init-file)

;; Command for moving lines
(use-package move-text
  :bind
  (("M-S-<up>"   . move-text-up)
   ("M-S-<down>" . move-text-down)))

;; Store files ending with ~ in a separete folder
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "file-backups")))))

(use-package rainbow-delimiters
  :config
  (add-hook 'Emacs-Lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'java-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'c-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode))

(defun latex/buildOnSave ()
  ;; (interactive)
  (when (eq major-mode 'latex-mode) (TeX-command "LaTeX" 'TeX-master-file -1)))

(use-package auctex
  :no-require t)

(use-package tex
  :ensure nil
  :config
  (add-hook 'after-save-hook 'latex/buildOnSave))

(use-package flyspell
  :config
  (add-hook 'LaTeX-mode-hook 'flyspell-mode))

(use-package company-auctex
  :config
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (company-mode t))))
