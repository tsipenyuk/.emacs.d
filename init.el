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

(require 'init-buffer-move)
(require 'init-column-marker)
(require 'init-idomenu)
(require 'init-julia)
(require 'init-helm-bibtex)
(require 'init-keys)
(require 'init-lilypond)
(require 'init-markdown)
(require 'init-org)
(require 'init-origami)
(require 'init-prose-mode)
(require 'init-pdf-tools)
(require 'init-themes)
(require 'init-test)
(require 'init-windows)
(require 'init-w3m)


;;(require 'font-latex) # probably obsolete, incorporated into init-auctex
(require 'init-auctex)
(require 'init-outline)

(require-package 'jupyter)

;;----------------------------------------------------------------------------
;; Test packages
;;----------------------------------------------------------------------------
;;(require-package 'centered-window) ;; Manual install needed? Available obsolete?
;;(require 'centered-window-mode)
;;(centered-window-mode t)
(when (executable-find "ipython3")
  (setq python-shell-interpreter "ipython3"))

(require 'init-arxiv-fetcher)

;; Folding mode, see https://www.emacswiki.org/emacs/FoldingMode
(require 'init-folding)

;; Edit emacs -- client
(require 'init-edit-emacs)
(require-package 'gmail-message-mode)
;; M-x package-install RET gmail-message-mode

;;; org-mime for jupyter mime svg+xml output -- deprecated 2020-10-15
;;(require-package 'org-mime)

;;; vterm for julia -- deprecated 2020-10-15
;;(use-package vterm
;;    :ensure t)

;; Add pdv-to-rut input method -----------------------------------------------
;; Modified variant of /usr/local/share/emacs/26.3/lisp/leim/quail/.. 
(require 'pdv-to-rut)

;; This is awful, but does the job. Created as described in
;; https://emacs.stackexchange.com/questions/70/how-to-save-a-keyboard-macro-as-a-lisp-function
(fset 'kbd-macro-set-input-method-pdv-to-rut
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217848 115 101 116 45 105 110 tab return 112 100 118 45 116 111 tab return] 0 "%d")) arg)))

(fset 'kbd-macro-set-input-method-ucs
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217848 115 101 116 45 105 110 tab return 117 99 115 return] 0 "%d")) arg)))

(global-set-key (kbd "s-)") (setq current-input-method 'kbd-macro-set-input-method-pdv-to-rut))
(global-set-key (kbd "s-+") (setq current-input-method 'kbd-macro-set-input-method-ucs))
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Test functions
;;----------------------------------------------------------------------------
(defun fill-to-end (char)
  (interactive "cFill Character:")
  (save-excursion
    (end-of-line)
    (while (< (current-column) 80)
      (insert-char char))))

(global-set-key (kbd "C-x C-b") 'ibuffer)

;;----------------------------------------------------------------------------
;; One-liners
;;----------------------------------------------------------------------------
(when (display-graphic-p)
  (server-start)
  )
(desktop-save-mode 1) ;; save desktop config on exit if save-mode is 1
(setq revert-without-query '(".pdf")) ;; reload *pdf's without asking
(setq apropos-sort-by-scores t) ;; Apropos sorts results by relevancy

;; key remappings --------------------------------------------------------------
;; Digit argument
(global-set-key (kbd "C-*") (kbd "C-8"))
(global-set-key (kbd "M-*") (kbd "M-8"))
(global-set-key (kbd "C-M-*") (kbd "C-M-8"))

;; Custom vertical scroll
(define-key global-map (kbd "M-p") (kbd "C-u 8 C-p C-l"))
(define-key global-map (kbd "M-n") (kbd "C-u 8 C-n C-l"))

;; imenu
(global-set-key (kbd "M-i") 'imenu)

;; Org-scrum
;;(require 'init-org-scrum)
(define-key global-map (kbd "C-c s") 'org-scrum-update-all)
(define-key global-map (kbd "C-c e") 'org-html-export-to-html)


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
 '(initial-buffer-choice 'eshell)

 ;; latex fonts
 '(font-latex-script-display (quote ((raise -0.0) raise 0.0)))
 '(initial-buffer-choice (quote eshell))
 '(package-selected-packages
   (quote
    (w3m switch-window pdf-tools writeroom-mode origami org markdown-mode helm-bibtex julia-repl julia-mode auctex fullframe seq))))

