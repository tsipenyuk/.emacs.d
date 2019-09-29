;;; init-column-marker.el --- Configure column-marker -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'column-marker)
(add-hook 'text-mode-hook (lambda () (interactive) (column-marker-1 80)))
(add-hook 'julia-mode-hook (lambda () (interactive) (column-marker-1 80)))
(global-set-key [?\C-c ?m] 'column-marker-1)

(provide 'init-column-marker)
;;; init-column-marker.el ends here