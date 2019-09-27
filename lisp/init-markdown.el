;;; init-markdown.el --- Configure markdown -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(provide 'init-markdown)
;;; init-markdown.el ends here
