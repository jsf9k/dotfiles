;; I stole a lot of this from Bozhidar Batsov's personal
;; configuration: https://github.com/bbatsov/emacs.d

;; Set up package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; Keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)

;; Update the package metadata if the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

;; Name and email
(setq user-full-name "Jeremy Frasier"
      user-mail-address "jeremy.frasier@beta.dhs.gov")

;; Always load newest byte code
(setq load-prefer-newer t)

;; Reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; Warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(defconst my-savefile-dir (expand-file-name "savefile" user-emacs-directory))

;; Create the savefile dir if it doesn't exist
(unless (file-exists-p my-savefile-dir)
  (make-directory my-savefile-dir))

;; Don't show the menu, tool, or scroll bars
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Turn off annoyances: the blinking cursor, the bell, the init
;; screen, and the splash screen
(blink-cursor-mode nil)
(setq ring-bell-function 'ignore
      inhibit-default-init t
      inhibit-splash-screen t)

;; Nice scrolling
;; (setq scroll-margin 0
;;       scroll-conservatively 100000
;;       scroll-preserve-screen-position 1)

;; Mode line settings
(column-number-mode t)
(line-number-mode t)
(size-indication-mode t)

;; Enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Turn on font-lock mode
;; (when (fboundp 'global-font-lock-mode)
;;   (global-font-lock-mode t))

;; Show a more useful frame title, that shows either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Enable visual feedback on selections
;; (setq transient-mark-mode t)

;; Use spaces instead of tabs for indent.
(setq-default indent-tabs-mode nil)
;; Set default tab width for all buffers
(setq-default tab-width 4)

;; Always end a file with a newline
(setq require-final-newline t)

;; Store all backup and autosave files in the /tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Revert buffers automatically when underlying files are changed
;; externally
(global-auto-revert-mode t)

;; (prefer-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)

;; Turn on semantic-mode and semantic-decoration-mode
(semantic-mode 1)
(global-semantic-decoration-mode t)

;; Install use-package if necessary, then set it up
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-verbose t)

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

;; Enable IDO mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(use-package ido-vertical-mode
  :ensure t
  :config
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))
(ido-vertical-mode 1)

;; Use cscope
(require 'xcscope)

;; Use tramp
(require 'tramp)

;; Use cmake mode
(require 'cmake-mode)

;; Use lilypond mode
;;(require 'lilypond-mode)

;; Use chromium as the generic URL browser
(setq browse-url-generic-program "chromium")

;; Ratpoison
(require 'ratpoison)

;; Enable IDO mode

;; enable subword mode for C++
(add-hook 'c++-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for C
(add-hook 'c-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for python
(add-hook 'python-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for lisp
(add-hook 'lisp-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for java
(add-hook 'java-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for scala
(add-hook 'scala-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for groovy
(add-hook 'groovy-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for CMake
(add-hook 'cmake-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for javascript
(add-hook 'js-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable flyspell mode for latex
(add-hook 'latex-mode-hook
          '(lambda ()
             (flyspell-mode)))

;; enable visual word wrap mode for latex
(add-hook 'latex-mode-hook
          '(lambda ()
             (visual-line-mode)))

;; Add Arduino ino files to c++-mode
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

;; Use pdflatex instead of latex
(setq latex-run-command "pdflatex --shell-escape")

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

(server-start)
