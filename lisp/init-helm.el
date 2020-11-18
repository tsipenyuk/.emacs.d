;;; init-helm.el --- Configure helm -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'helm)
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-x c g") 'helm-google-suggest)

;; imenu
;;(global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "M-i") 'helm-imenu)


(provide 'init-helm)
;;; init-helm.el ends here
