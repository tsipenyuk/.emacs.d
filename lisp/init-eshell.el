;;; init-eshell.el --- Configure eshell -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Fix eshell $PATH to include local installation of pdflatex
(defun jpk/eshell-mode-hook ()
  (eshell/addpath "/home/at/.texlive2019/bin/x86_64-linux"))
(add-hook 'eshell-mode-hook #'jpk/eshell-mode-hook)

(require 'eshell)

(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

;;(add-hook 'emacs-startup-hook (lambda () (eshell) (previous-buffer)))
(add-hook 'emacs-startup-hook 'eshell)
;;(cd (expand-file-name "~/.emacs.d"))
(setenv "PATH" "/home/at/.texlive2019/bin/x86_64-linux:/home/at/.local/julia/bin:/home/at/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games")


(setq ;; eshell-buffer-shorthand t ...  Can't see Bug#19391
 eshell-scroll-to-bottom-on-input 'all
 eshell-error-if-no-glob t
 eshell-hist-ignoredups t
 eshell-save-history-on-exit t
 eshell-prefer-lisp-functions nil
 eshell-destroy-buffer-when-process-dies t)


(add-hook 'eshell-mode-hook
          (lambda ()
            (eshell/alias "e" "find-file $1")
            (eshell/alias "ff" "find-file $1")
            (eshell/alias "emacs" "find-file $1")
            (eshell/alias "ee" "find-file-other-window $1")
            (eshell/alias "ei" "ls")
            (eshell/alias "eu" "ls")            

            (eshell/alias "d" "dired $1")))

(provide 'init-eshell)
;;; init-eshell.el ends here
