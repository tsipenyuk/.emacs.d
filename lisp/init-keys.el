;;; init-keys.el --- Configure global key bindings -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Swap “C-t” and “C-x”, so it's easier to type on Dvorak layout
(keyboard-translate ?\C-t ?\C-x)
(keyboard-translate ?\C-x ?\C-t)

(global-set-key (kbd "C-c C-f") 'copy-file-name-to-clipboard)

(provide 'init-keys)
;;; init-keys.el ends here
