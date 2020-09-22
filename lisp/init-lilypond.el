;;; init-lilypond.el --- Configure lilypond -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'lilypond-mode)

;; automatically use lyqi mode when editing .ly and .ily files
(add-to-list 'auto-mode-alist '("\\.ly$" . lilypond-mode))
(add-to-list 'auto-mode-alist '("\\.ily$" . lylypond-mode))


(provide 'init-lilypond)
;;; init-lilypond.el ends here
