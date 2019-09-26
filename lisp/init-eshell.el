;;; init-eshell.el --- Configure eshell -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'eshell)

(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

;;(add-hook 'emacs-startup-hook (lambda () (eshell) (previous-buffer)))
(add-hook 'emacs-startup-hook 'eshell)
(cd (expand-file-name "~/.emacs.d"))

(provide 'init-eshell)
;;; init-eshell.el ends here