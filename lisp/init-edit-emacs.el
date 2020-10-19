;;; init-edit-emacs.el --- Configure edit-emacs -*- lexical-binding: t -*-
;;; Commentary: from chrome-extension://ljobjlafonikaiipfkggjbhkghgicgoh/fancy-settings/source/index.html
;;; Code:

(require-package 'edit-server)

(when (and (daemonp) (require 'edit-server nil :noerror))
  (edit-server-start))

(when (require 'edit-server nil :noerror)
  (setq edit-server-new-frame nil)
  (edit-server-start))

(autoload 'edit-server-maybe-dehtmlize-buffer "edit-server-htmlize" "edit-server-htmlize" t)
(autoload 'edit-server-maybe-htmlize-buffer   "edit-server-htmlize" "edit-server-htmlize" t)
(add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
(add-hook 'edit-server-done-hook  'edit-server-maybe-htmlize-buffer)

(provide 'init-edit-emacs)
;;; init-edit-emacs.el ends here
