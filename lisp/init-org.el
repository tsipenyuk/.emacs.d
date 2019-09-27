;;; init-org.el --- Configure org -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; enable org-mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq calendar-week-start-day 1)

(setq org-agenda-files (list "~/Dropbox/org/home.org"
			     "~/Dropbox/org/thesis.org"
                             "~/Dropbox/org/work.org"))
(setq org-agenda-custom-commands
      '(("c" . "My Custom Agendas")
        ("cu" "Unscheduled TODO"
         ((todo ""
                ((org-agenda-overriding-header "\nUnscheduled TODO")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
         nil
         nil)))

(provide 'init-org)
;;; init-org.el ends here
