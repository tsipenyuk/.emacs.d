;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:
;;;   2020-11-18 -- reworked using https://pages.sachachua.com/.emacs.d/Sacha.html
;;;                 and dave emacs setup

;;; Code:
(setq debug-on-error t) ;; Produce backtraces when errors occur

;;; This fixed garbage collection, makes emacs start up faster ;;;;;;;
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))

(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
	gc-cons-percentage 0.1))

(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; This is all kinds of necessary
(require 'package)
(setq package-enable-at-startup nil)

;;; remove SC if you are not using sunrise commander and org if you like outdated packages
(setq package-archives '(("ELPA"  . "http://tromey.com/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("org"   . "https://orgmode.org/elpa/")))
(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Bootstrapping use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

;; Always swap “C-t” and “C-x” (Dvorak layout) -- even if errors occur in config
(keyboard-translate ?\C-t ?\C-x)
(keyboard-translate ?\C-x ?\C-t)

;;; This is the actual config file. It is omitted if it doesn't exist so emacs won't refuse to launch.
(when (file-readable-p "~/.emacs.d/config.org")
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))

;;;;----------------------------------------------------------------------------
;;;; Load path, custom, personal config
;;;;----------------------------------------------------------------------------
;;(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;;(load custom-file t)
;;
;;(setq user-full-name "Arseniy Tsipenyuk"
;;      user-mail-address "arseniy.tsipenyuk@gmail.com")
;;
;;;; Site packages
;;(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))
;;(unless (package-installed-p 'use-package)
;;  (package-install 'use-package))
;;(setq use-package-verbose t)
;;(setq use-package-always-ensure t)
;;(require 'use-package)
;;(use-package auto-compile
;;  :config (auto-compile-on-load-mode))
;;(setq load-prefer-newer t)
;;
;;
;;;;----------------------------------------------------------------------------
;;;; Load packages
;;;;----------------------------------------------------------------------------
;;;; essential
;;(require 'init-exwm)
;;;;(require 'init-eshell)
;;
;;;; daedreth uncledavesemacs my personal .emacs.d
;;;;;; secondary
;;;;(require 'init-auctex)
;;;;(require 'init-buffer-move)
;;;;(require 'init-column-marker)
;;;;;;(require-package 'ein)
;;;;;;(require-package 'haskell-mode)
;;;;(require 'init-idomenu)
;;;;(require 'init-julia)
;;;;(require-package 'jupyter)
;;;;(require 'init-helm)
;;;;(require 'init-helm-bibtex)
;;;;;;(require 'init-lilypond)
;;;;(require 'init-markdown)
;;;;(require 'init-org)
;;;;(require 'init-org2blog)
;;;;;;(require 'init-origami)
;;;;(require 'init-outline)
;;;;(require 'init-prose-mode)
;;;;(require 'init-pdf-tools)
;;;;(require 'init-themes)
;;;;(require 'init-test)
;;;;(require 'init-windows)
;;;;(require 'init-w3m)
;;(use-package w3m)
;;;;
;;;; main / graphical
;;
;;;; last
;;;; init-keys is loaded last since it rebinds some keys, e.g. C-, in org-mode
;;(require 'init-keys)
;;
;;;;----------------------------------------------------------------------------
;;;; Test packages
;;;;----------------------------------------------------------------------------
;;;;;;(require-package 'centered-window) ;; Manual install needed? Available obsolete?
;;;;;;(require 'centered-window-mode)
;;;;;;(centered-window-mode t)
;;;;(when (executable-find "ipython3")
;;;;  (setq python-shell-interpreter "ipython3"))
;;;;
;;;;(require 'init-arxiv-fetcher)
;;;;
;;;;;; Folding mode, see https://www.emacswiki.org/emacs/FoldingMode
;;;;(require 'init-folding)
;;;;
;;;;;; Edit emacs -- client
;;;;(require 'init-edit-emacs)
;;;;(require-package 'gmail-message-mode)
;;;;;; M-x package-install RET gmail-message-mode
;;;;
;;;;;; prohibit tab insertion
;;;;(setq-default indent-tabs-mode nil)
;;;;
;;;;;;; org-mime for jupyter mime svg+xml output -- deprecated 2020-10-15
;;;;;;(require-package 'org-mime)
;;;;
;;;;;;; vterm for julia -- deprecated 2020-10-15
;;;;;;(use-package vterm
;;;;;;    :ensure t)
;;;;
;;;;;; Add pdv-to-rut input method -----------------------------------------------
;;;;;; Modified variant of /usr/local/share/emacs/26.3/lisp/leim/quail/..
;;;;(require 'pdv-to-rut)
;;;;
;;;;;; This is awful, but does the job. Created as described in 
;;;;;; https://emacs.stackexchange.com/questions/70/how-to-save-a-keyboard-macro-as-a-lisp-function
;;;;(fset 'kbd-macro-set-input-method-pdv-to-rut
;;;;   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217848 115 101 116 45 105 110 tab return 112 100 118 45 116 111 tab return] 0 "%d")) arg)))
;;;;
;;;;(fset 'kbd-macro-set-input-method-ucs
;;;;   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217848 115 101 116 45 105 110 tab return 117 99 115 return] 0 "%d")) arg)))
;;;;
;;;;(global-set-key (kbd "s-)") (setq current-input-method 'kbd-macro-set-input-method-pdv-to-rut))
;;;;(global-set-key (kbd "s-+") (setq current-input-method 'kbd-macro-set-input-method-ucs))
;;;;
;;;;;; dired omit mode
;;;;(require 'dired-x)
;;;;(add-hook 'dired-load-hook '(lambda () (require 'dired-x))) ; Load Dired X when Dired is loaded.
;;;;(setq dired-omit-mode t) ; Turn on Omit mode.
;;;;(setq-default dired-omit-files-p t) ; Buffer-local variable
;;;;(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
;;;;
;;;;;;----------------------------------------------------------------------------
;;;;;; Test functions
;;;;;;----------------------------------------------------------------------------
;;;;(defun fill-to-end (char)
;;;;  (interactive "cFill Character:")
;;;;  (save-excursion
;;;;    (end-of-line)
;;;;    (while (< (current-column) 80)
;;;;      (insert-char char))))
;;;;
;;;;(defun fill-short (char)
;;;;  (interactive "cFill Character:")
;;;;  (save-excursion
;;;;    (end-of-line)
;;;;    (while (< (current-column) 72)
;;;;      (insert-char char))))
;;;;
;;;;(global-set-key (kbd "C-x C-b") 'ibuffer)
;;;;
;;;;;; emacs-w3m as default browser
;;;;(setq browse-url-browser-function 'w3m-browse-url)
;;;;
;;;;;; Help buffer commands
;;;;(define-key help-mode-map (kbd "b") 'help-go-back)
;;;;(define-key help-mode-map (kbd "f") 'help-go-forward)
;;;;
;;;;;;; open with chrome
;;;;(defun org-open-at-point-with-chrome ()
;;;;  (interactive)
;;;;  (let ((browse-url-browser-function 'browse-url-chrome))
;;;;    (org-open-at-point )))
;;;;
;;;;(define-key org-mode-map (kbd "C-c C-;") 'org-open-at-point-with-chrome)
;;;;
;;;;
;;;;;;; new line
;;;;;; Insert new line below current line and move cursor to new line
;;;;;; it will also indent newline
;;;;(global-set-key (kbd "<C-return>")
;;;;                (lambda ()
;;;;                  (interactive)
;;;;                  (end-of-line)
;;;;                  (newline-and-indent)))
;;;;;; Insert new line above current line and move cursor to previous line (newly inserted line)
;;;;;; it will also indent newline
;;;;(global-set-key (kbd "<C-S-return>")
;;;;                (lambda ()
;;;;                  (interactive)
;;;;                  (previous-line)
;;;;                  (end-of-line)
;;;;                  (newline-and-indent)))
;;;;
;;;;;;----------------------------------------------------------------------------
;;;;;; One-liners
;;;;;;----------------------------------------------------------------------------
;;;;(when (display-graphic-p)
;;;;  (server-start)
;;;;  )
;;;;(desktop-save-mode 0) ;; save desktop config on exit if save-mode is 1
;;;;(setq revert-without-query '(".pdf")) ;; reload *pdf's without asking
;;;;(setq apropos-sort-by-scores t) ;; Apropos sorts results by relevancy
;;;;
;;;;(setq-default cursor-type 'box)
;;;;(blink-cursor-mode 0)
;;;;(set-cursor-color "#93a1a1") 
;;;;
;;;;;; key remappings --------------------------------------------------------------
;;;;;; Digit argument
;;;;(global-set-key (kbd "C-*") (kbd "C-8"))
;;;;(global-set-key (kbd "M-*") (kbd "M-8"))
;;;;(global-set-key (kbd "C-M-*") (kbd "C-M-8"))
;;;;
;;;;;; Custom vertical scroll
;;;;(define-key global-map (kbd "M-p") (kbd "C-u 8 C-p C-l"))
;;;;(define-key global-map (kbd "M-n") (kbd "C-u 8 C-n C-l"))
;;;;
;;;;;; refresh highlighting
;;;;(global-set-key (kbd "C-x C-$") 'font-lock-fontify-buffer)
;;;;
;;;;;; Org-scrum
;;;;;;(require 'init-org-scrum)
;;;;(define-key global-map (kbd "C-c s") 'org-scrum-update-all)
;;;;(define-key global-map (kbd "C-c e") 'org-html-export-to-html)
;;;;
;;;;
;;;;;;----------------------------------------------------------------------------
;;;;;; Enable ido
;;;;;;----------------------------------------------------------------------------
;;;;(setq ido-enable-flex-matching t)
;;;;(setq ido-everywhere t)
;;;;(ido-mode 1)
;;;;
;;;;;; python3
;;;;;(setq doom-modeline-python-executable "python3")
;;;;;(setq python-shell-interpreter "python3")
;;;;;(setq python-shell-interpreter-args "-m IPython --simple-prompt -i")
;;;;;(setq flycheck-python-pycompile-executable "python3"
;;;;;      flycheck-python-pylint-executable "python3"
;;;;;      flycheck-python-flake8-executable "python3")
;;;;;(setq doom-modeline-major-mode-icon nil
;;;;;      doom-modeline-persp-name t
;;;;;      doom-modeline-github t
;;;;;      doom-modeline-version t
;;;;;      doom-modeline-minor-modes t)
;;;;;(minions-mode 1)
;;;;;(setq persp-nil-name "#")
;;;;;(setq minions-mode-line-lighter "◎")
;;;;;;(setq python-shell-interpreter "python3")
;;;;
;;;;----------------------------------------------------------------------------
;;;; Replace highlighted regions
;;;;----------------------------------------------------------------------------
;;(delete-selection-mode 1)
;;
;;(dired ".") ;; start in dired mode
;;
;;----------------------------------------------------------------------------;;
; Set custom variables
;;----------------------------------------------------------------------------
;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(initial-buffer-choice 'eshell)
;;
;; ;; latex fonts
;; '(font-latex-script-display (quote ((raise -0.0) raise 0.0)))
;; '(initial-buffer-choice (quote eshell))
;; '(package-selected-packages
;;   (quote
;;    (w3m switch-window pdf-tools writeroom-mode origami org markdown-mode helm-bibtex julia-repl julia-mode auctex fullframe seq))))
;;(put 'erase-buffer 'disabled nil)
;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" default))
 '(helm-completion-style 'emacs)
 '(package-selected-packages
   '(lilypond-mode elcord org-bullets htmlize sudo-edit magit company-auctex auctex julia-repl julia-mode company-shell slime-company slime company-jedi company-irony company-c-headers flycheck-clang-analyzer company flycheck yasnippet-snippets yasnippet rainbow-mode popup-kill-ring zzz-to-char hungry-delete expand-region rainbow-delimiters beacon mark-multiple avy helm linum-relative swiper switch-window which-key ivy symon fancy-battery spaceline dashboard projectile dmenu async pretty-mode w3m use-package solarized-theme exwm auto-compile))
 '(symon-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
