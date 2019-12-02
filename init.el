;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Produce backtraces when errors occur
(setq debug-on-error t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages


;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-eshell)
(require 'init-column-marker)
(require 'init-idomenu)
(require 'init-julia)
(require 'init-keys)
(require 'init-lilypond)
(require 'init-markdown)
(require 'init-org)
(require 'init-origami)
(require 'init-prose-mode)
(require 'init-themes)
(require 'init-windows)
(require 'init-w3m)

;;----------------------------------------------------------------------------
;; Enable ido
;;----------------------------------------------------------------------------
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)


;; python3
;(setq doom-modeline-python-executable "python3")
;(setq python-shell-interpreter "python3")
;(setq python-shell-interpreter-args "-m IPython --simple-prompt -i")
;(setq flycheck-python-pycompile-executable "python3"
;      flycheck-python-pylint-executable "python3"
;      flycheck-python-flake8-executable "python3")
;(setq doom-modeline-major-mode-icon nil
;      doom-modeline-persp-name t
;      doom-modeline-github t
;      doom-modeline-version t
;      doom-modeline-minor-modes t)
;(minions-mode 1)
;(setq persp-nil-name "#")
;(setq minions-mode-line-lighter "◎")
;;(setq python-shell-interpreter "python3")

;;----------------------------------------------------------------------------
;; Replace highlighted regions
;;----------------------------------------------------------------------------
(delete-selection-mode 1)

;;----------------------------------------------------------------------------
;; Set custom variables
;;----------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-buffer-choice 'eshell))

;;(add-hook 'after-init-hook (lambda () (previous-buffer)))

