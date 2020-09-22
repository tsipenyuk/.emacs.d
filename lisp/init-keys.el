;;; init-keys.el --- Configure global key bindings -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Swap “C-t” and “C-x”, so it's easier to type on Dvorak layout
(keyboard-translate ?\C-t ?\C-x)
(keyboard-translate ?\C-x ?\C-t)

;; Copy file name 
(global-set-key (kbd "C-c C-f") 'copy-file-name-to-clipboard)
(global-set-key (kbd "s-f") 'copy-file-name-to-clipboard)

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

;; try efficient movement
(global-set-key (kbd "C-*") (kbd "C-8"))

;; Other-window 
(global-set-key (kbd "M-o") 'other-window)

;; (windmove-default-keybindings) --> S-<left> for moving between windows
(global-set-key (kbd "s-.") 'windmove-up)
(global-set-key (kbd "s-e") 'windmove-down)
(global-set-key (kbd "s-o") 'windmove-left)
(global-set-key (kbd "s-u") 'windmove-right)

;; move buffers; uses functions from lisp/init-buffer-move.el
;;(global-set-key (kbd "C-c C-x c")  'buf-move-up)
;;(global-set-key (kbd "C-c C-x t")  'buf-move-down)
;;(global-set-key (kbd "C-c C-x h")  'buf-move-left)
;;(global-set-key (kbd "C-c C-x n")  'buf-move-right)
(global-set-key (kbd "s-b")  'buf-move-left)

;; Add new lines with C-n
(setq next-line-add-newlines t)

;; Create revert buffer shortcut
;; Source: https://emacs.stackexchange.com/questions/169/how-do-i-reload-a-file-in-a-buffer
(global-set-key (kbd "C-c r") (lambda ()
                                (interactive)
                                (revert-buffer t t t)
                                (message "buffer is reverted")))

(global-set-key (kbd "s-f") 'copy-file-name-to-clipboard)

(provide 'init-keys)
;;; init-keys.el ends here
