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
(require 'init-julia)
(require 'init-keys)
(require 'init-lilypond)
(require 'init-markdown)
(require 'init-org)
(require 'init-origami)
(require 'init-themes)
(require 'init-windows)
(require 'init-w3m)

;;----------------------------------------------------------------------------
;; Enable ido
;;----------------------------------------------------------------------------
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;----------------------------------------------------------------------------
;; Replace highlighted regions
;;----------------------------------------------------------------------------
(delete-selection-mode 1)

;;----------------------------------------------------------------------------
;; Use super key for numeric keypad
;;----------------------------------------------------------------------------
(global-set-key (kbd "s-m") (kbd "1")) ; lower case “s” is for super
(global-set-key (kbd "s-w") (kbd "2"))
(global-set-key (kbd "s-v") (kbd "3"))
(global-set-key (kbd "s-h") (kbd "4"))
(global-set-key (kbd "s-t") (kbd "5"))
(global-set-key (kbd "s-n") (kbd "6"))
(global-set-key (kbd "s-g") (kbd "7"))
(global-set-key (kbd "s-c") (kbd "8"))
(global-set-key (kbd "s-r") (kbd "9"))
(global-set-key (kbd "s-b") (kbd "0"))


(global-set-key (kbd "M-s-m") (kbd "M-1"))
(global-set-key (kbd "M-s-w") (kbd "M-2"))
(global-set-key (kbd "M-s-v") (kbd "M-3"))
(global-set-key (kbd "M-s-h") (kbd "M-4"))
(global-set-key (kbd "M-s-t") (kbd "M-5"))
(global-set-key (kbd "M-s-n") (kbd "M-6"))
(global-set-key (kbd "M-s-g") (kbd "M-7"))
(global-set-key (kbd "M-s-c") (kbd "M-8"))
(global-set-key (kbd "M-s-r") (kbd "M-9"))
(global-set-key (kbd "M-s-b") (kbd "M-0"))

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

