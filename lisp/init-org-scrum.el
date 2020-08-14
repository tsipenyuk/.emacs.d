;;; init-org-scrum.el --- Configure org-scrum -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'org-scrum)
(define-key global-map (kbd "C-c s") 'org-scrum-update-all)
(define-key global-map (kbd "C-c e") 'org-html-export-to-html)

(provide 'init-org-scrum)
;;; init-org-scrum.el ends here
