;;; init-keys.el --- Configure global key bindings -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Swap “C-t” and “C-x”, so it's easier to type on Dvorak layout
(keyboard-translate ?\C-t ?\C-x)
(keyboard-translate ?\C-x ?\C-t)

;; Copy file name 
(global-set-key (kbd "C-c C-f") 'copy-file-name-to-clipboard)

;; Use hyper key for numeric keypad
(global-set-key (kbd "H-m") (kbd "1")) ; upper case “H” is for hyper
(global-set-key (kbd "H-w") (kbd "2"))
(global-set-key (kbd "H-v") (kbd "3"))
(global-set-key (kbd "H-h") (kbd "4"))
(global-set-key (kbd "H-t") (kbd "5"))
(global-set-key (kbd "H-n") (kbd "6"))
(global-set-key (kbd "H-g") (kbd "7"))
(global-set-key (kbd "H-c") (kbd "8"))
(global-set-key (kbd "H-r") (kbd "9"))
(global-set-key (kbd "H-b") (kbd "0"))

;; rebind paragraph and buffer movement
(global-set-key (kbd "C-,") 'beginning-of-buffer)
(global-set-key (kbd "C-.") 'end-of-buffer)
(global-set-key (kbd "C-{") 'backward-paragraph)
(global-set-key (kbd "C-}") 'forward-paragraph)

;; Add new lines with C-n
(setq next-line-add-newlines t)

(provide 'init-keys)
;;; init-keys.el ends here
