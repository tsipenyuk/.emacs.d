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

(provide 'init-eshell)
;;; init-eshell.el ends here
