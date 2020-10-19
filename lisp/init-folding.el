;;; init-folding.el --- Configure folding -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'folding)
(if (require 'folding nil 'noerror)
    (folding-mode-add-find-file-hook)
  (message "Library `folding' not found"))

(folding-add-to-marks-list 'julia-mode "##{{{" "##}}}" nil t)

(define-key folding-mode-map (kbd "C-o C-c") 'folding-hide-current-entry)
(define-key folding-mode-map (kbd "C-o C-s") 'folding-show-current-subtree)

(define-key folding-mode-map (kbd "C-o C-p") 'folding-previous-visible-heading)
(define-key folding-mode-map (kbd "C-o C-n") 'folding-next-visible-heading)

(provide 'init-folding)
;;; init-folding.el ends here
