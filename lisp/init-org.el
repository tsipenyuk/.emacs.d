;;; init-org.el --- Configure org -*- lexical-binding: t -*-
;;; Commentary:

;; Among settings for many aspects of `org-mode', this code includes
;; an opinionated setup for the Getting Things Done (GTD) system based
;; around the Org Agenda.

;; See https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html
;;
;; Shortcuts
;; C-c c       add new entry; t for inbox.org, T for tickler.org
;; C-c C-c     store new entry in inbox.org
;; C-c C-w     refile entry from inbox to other .org file (gtd/someday/tickler)
;; C-c C-c     use on headline to tag. Example tags :@office: , :emacs:
;; C-c t       set the TODO keyword
;; C-c C-s     add a timestamp
;; C-c C-d     add a deadline
;; C-c C-x C-a archive entry
;; C-c l       store link (see right below for related shortcuts)

;;; Code:

(require-package 'org)
;;(maybe-require-package 'org-cliplink)

(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c C-l") 'org-insert-link)
(define-key global-map (kbd "C-c C-o") 'org-open-at-point)

(define-key global-map (kbd "C-c g") 'org-agenda)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c t") 'org-todo)
(global-set-key (kbd "C-c C-x C-a") 'org-archive-subtree-default)
(global-set-key "\C-cb" 'org-iswitchb)

(setq calendar-week-start-day 1)
(setq org-log-done t)
(setq org-agenda-files (list "~/Dropbox (Maestral)/org/gtd.org"
			     "~/Dropbox (Maestral)/org/inbox.org"
                             "~/Dropbox (Maestral)/org/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/Dropbox (Maestral)/org/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/Dropbox (Maestral)/org/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(setq org-refile-targets '(("~/Dropbox (Maestral)/org/gtd.org" :maxlevel . 3)
                           ("~/Dropbox (Maestral)/org/someday.org" :level . 1)
                           ("~/Dropbox (Maestral)/org/tickler.org" :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

; office home travelling phone email errands
;(setq org-agenda-custom-commands 
;      '(("o" "At the office" tags-todo "@office"
;         ((org-agenda-overriding-header "Office")))))
;
; (setq org-agenda-custom-commands 
;      '(("o" "At the office" tags-todo "@office"
;         ((org-agenda-overriding-header "Office")
;          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))
		  
(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))


(setq org-agenda-custom-commands
      '(("c" . "My Custom Agendas")
	("cl" "Letters" tags-todo "letters"
         ((org-agenda-overriding-header "Letters")))
	("chb" "home_b" tags-todo "home_b"
         ((org-agenda-overriding-header "home_b")))
	("chm" "home_m" tags-todo "home_m"
         ((org-agenda-overriding-header "home_m")))
	("cm" "Movies" tags-todo "movies"
         ((org-agenda-overriding-header "Movies")))
	("cb" "Books" tags-todo "books"
         ((org-agenda-overriding-header "Books")))
	("co" "Office" tags-todo "office"
         ((org-agenda-overriding-header "office")))
	("cw" "Work" tags-todo "work"
         ((org-agenda-overriding-header "work")))
	("cv" "Vacation" tags-todo "vacation"
         ((org-agenda-overriding-header "Vacation")))
	("cs" "Shopping" tags-todo "shopping"
         ((org-agenda-overriding-header "shopping")))
	("ce" "Errands" tags-todo "errands"
         ((org-agenda-overriding-header "Errands")))
	))
(provide 'init-org)
;;; init-org.el ends here
