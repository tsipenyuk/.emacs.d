;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:
;;;   2020-11-18 -- reworked using https://pages.sachachua.com/.emacs.d/Sacha.html
;;;                 and dave emacs setup

;;; Code:
(setq debug-on-error t) ;; Produce backtraces when errors occur

;; TLS connection issues https://github.com/emacs-evil/evil/issues/1181
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;;; This fixed garbage collection, makes emacs start up faster ;;;;;;;
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))

(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
				gc-cons-percentage 0.1))

(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; This is all kinds of necessary
(require 'package)
(setq package-enable-at-startup nil)

;;; remove SC if you are not using sunrise commander and org if you like outdated packages
(setq package-archives '(("ELPA"  . "http://tromey.com/elpa/")
												 ("gnu"   . "http://elpa.gnu.org/packages/")
												 ("melpa" . "https://melpa.org/packages/")
												 ("org"   . "https://orgmode.org/elpa/")))
(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Bootstrapping use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

;; Always swap “C-t” and “C-x” (Dvorak layout) -- even if errors occur in config
(keyboard-translate ?\C-t ?\C-x)
(keyboard-translate ?\C-x ?\C-t)

;; modify load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)

(setq user-full-name "Arseniy Tsipenyuk"
      user-mail-address "arseniy.tsipenyuk@gmail.com")

;;;; UI CONFIG ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)          ; Disable the menu bar

;;(setq visible-bell t)             ; flashes screen on 'ding'
(setq ring-bell-function 'ignore) ; do nothing on 'ding'

(defalias 'yes-or-no-p 'y-or-n-p)

;; highlight current line in programming modes
(when window-system (add-hook 'prog-mode-hook 'hl-line-mode))

;; solarized
(use-package solarized-theme
  :init
  ;; Avoid all font-size changes
  (setq solarized-height-minus-1 1.0)
  (setq solarized-height-plus-1 1.0)
  (setq solarized-height-plus-2 1.0)
  (setq solarized-height-plus-3 1.0)
  (setq solarized-height-plus-4 1.0)

  ;; font famili and size; I also like "Ubuntu Mono 19"
  (set-face-attribute 'default nil :font "Fira Code 19")
  (set-face-attribute 'fixed-pitch nil :font "Fira Code 19" )
  (set-face-attribute 'variable-pitch nil :font "Fira Code 19" )
  (set-frame-font "Fira Code 19" nil t))

(load-theme 'solarized-light t)
(defun light ()
  "Activate a light color theme."
  (interactive)
  (load-theme 'solarized-light))

(defun dark ()
  "Activate a dark color theme."
  (interactive)
  (load-theme 'solarized-dark))

;; utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)



;;;; visiting / reloading config
(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)
(defun config-reload ()
  "Reloads ~/.emacs.d/config.org at runtime"
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c d") 'config-reload)
(define-key help-mode-map (kbd "b") 'help-go-back)
(define-key help-mode-map (kbd "f") 'help-go-forward)
(global-set-key (kbd "C-x C-$") 'font-lock-fontify-buffer)


;;;; generic packages
(use-package all-the-icons)
(use-package atomic-chrome)
(atomic-chrome-start-server)

(use-package beacon
  :config
  (beacon-mode 1))

(use-package fira-code-mode
  ;; ligatures you don't want
  :custom (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x"))
  :hook prog-mode
  :config
  (fira-code-mode-set-font))

(use-package free-keys)
(use-package hungry-delete
  :config
  (global-hungry-delete-mode))

(use-package pdf-tools)
(pdf-tools-install)

(use-package rainbow-mode
  :init
  (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;;;; site packages
(add-to-list 'load-path (expand-file-name "site-lisp/dired+" user-emacs-directory))
(require 'dired+)

(add-to-list 'load-path (expand-file-name "site-lisp/run-current-file" user-emacs-directory))
(require 'run-current-file)
(global-set-key (kbd "<f8>") 'xah-run-current-file)

;;;; custom commands
(use-package expand-region
  :bind ("C-q" . er/expand-region))
(defun fill-to-end (char)
  (interactive "cFill Character:")
  (save-excursion
    (end-of-line)
    (while (< (current-column) 80)
      (insert-char char))))

(defun fill-short (char)
  (interactive "cFill Character:")
  (save-excursion
    (end-of-line)
    (while (< (current-column) 72)
      (insert-char char))))



;;;; generic modes
(column-number-mode)
;;(global-display-line-numbers-mode nil)
(setq kill-ring-max 100)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
								treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;;;; dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner "~/.emacs.d/img/dashLogo.png")
  (setq dashboard-items '((recents  . 15)
                          (projects . 5)))
  (setq dashboard-banner-logo-title "Hello there!"))

;; Setup random footer messages
;; http://ergoemacs.org/emacs/elisp_read_file_content.html
(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

;; footer messages are loaded from here
(setq dashboard-footer-messages (read-lines "~/.emacs.d/dashboard-quotes.txt"))

;;;; modeline
(use-package spaceline
  :config
  (require 'spaceline-config)
  (setq spaceline-buffer-encoding-abbrev-p nil)
  (setq spaceline-line-column-p t)
  (setq spaceline-line-p t)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))

;; disable separator
(setq powerline-default-separator nil)

;;;; diminishing modes
(use-package diminish
  :init
  (diminish 'which-key-mode)
  (diminish 'linum-relative-mode)
  (diminish 'hungry-delete-mode)
  (diminish 'visual-line-mode)
  (diminish 'subword-mode)
  (diminish 'beacon-mode)
  (diminish 'irony-mode)
  (diminish 'page-break-lines-mode)
  (diminish 'auto-revert-mode)
  (diminish 'rainbow-delimiters-mode)
  (diminish 'rainbow-mode)
  (diminish 'yas-minor-mode)
  (diminish 'flycheck-mode)
  (diminish 'helm-mode))

(use-package fancy-battery
  :config
  (setq fancy-battery-show-percentage t)
  (setq battery-update-interval 15)
  (if window-system
      (fancy-battery-mode)
    (display-battery-mode)))

(use-package symon
  :bind
  ("s-h" . symon-mode))

(use-package which-key
  :config
  (which-key-mode))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         ("C-x C-n" . newline)
				 :map ivy-minibuffer-map
				 ("TAB" . ivy-alt-done)
				 ("C-j" . ivy-alt-done)
				 ("C-n" . ivy-next-line)
				 ("C-p" . ivy-previous-line)
				 :map ivy-switch-buffer-map
				 ("C-k" . ivy-previous-line)
				 ("C-l" . ivy-done)
				 ("C-d" . ivy-switch-buffer-kill)
				 :map ivy-reverse-i-search-map
				 ("C-k" . ivy-previous-line)
				 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1)
  :custom
  (company-minimum-prefix-length 3))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(define-key ivy-mode-map (kbd "C-o") nil)


(use-package counsel
  :bind (("C-M-t" . 'counsel-switch-buffer)
				 :map minibuffer-local-map
				 ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1))


(setq scroll-conservatively 100)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(defvar my-term-shell "/bin/zsh")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "<s-return>") 'ansi-term)

(use-package exec-path-from-shell
  :defer t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
;; used to have this instead:
;;(add-to-list 'exec-path "~/.local/bin")

(use-package ace-window
  :config
  (setq aw-background nil)
  (setq aw-keys
        '(?h ?t ?n ?s ?a ?o ?e ?u ?i))) ;; programmer dvorak keys


(defun kill-current-buffer ()
  "Kills the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))
(global-set-key (kbd "C-x C-b") 'ibuffer)

(defun close-all-buffers ()
  "Kill all buffers without regard for their origin."
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-M-s-k") 'close-all-buffers)

(use-package avy
  :bind
  ("M-s" . avy-goto-char))

(defun split-window-horizontally-instead ()
  "Kill any other windows and re-split such that the current window is on the top half of the frame."
  (interactive)
  (let ((other-buffer (and (next-window) (window-buffer (next-window)))))
    (delete-other-windows)
    (split-window-horizontally)
    (when other-buffer
      (set-window-buffer (next-window) other-buffer))))

(defun split-window-vertically-instead ()
  "Kill any other windows and re-split such that the current window is on the left half of the frame."
  (interactive)
  (let ((other-buffer (and (next-window) (window-buffer (next-window)))))
    (delete-other-windows)
    (split-window-vertically)
    (when other-buffer
      (set-window-buffer (next-window) other-buffer))))

(global-set-key (kbd "C-x |") 'split-window-horizontally-instead)
(global-set-key (kbd "C-x _") 'split-window-vertically-instead)

(global-set-key (kbd "C-c r")
                (lambda ()
                  (interactive)
                  (revert-buffer t t t)
                  (message "buffer is reverted")))

(show-paren-mode 1)
(global-subword-mode 1)

(use-package zzz-to-char
  :bind ("M-z" . zzz-up-to-char))

;;;; org mode
(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.0)
                  (org-level-2 . 1.0)
                  (org-level-3 . 1.0)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Fira Code" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(defun efs/org-mode-setup ()
  (visual-line-mode 1))

(use-package org
  :defer t
  :preface
  (setq modi/default-lisp-directory (expand-file-name "elpa/org-mode/lisp" user-emacs-directory))

  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/personal/gdrive/org/tasks.org"))

  (setq org-clock-sound "~/.emacs.d/ding.mp3")

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
				'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
					(sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
				'(("Archive.org" :maxlevel . 1)
					("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
				'((:startgroup)
																				; Put mutually exclusive tags here
					(:endgroup)
					("@errand" . ?E)
					("@home" . ?H)
					("@work" . ?W)
					("agenda" . ?a)
					("planning" . ?p)
					("publish" . ?P)
					("batch" . ?b)
					("note" . ?n)
					("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
				'(("d" "Dashboard"
					 ((agenda "" ((org-deadline-warning-days 7)))
						(todo "NEXT"
									((org-agenda-overriding-header "Next Tasks")))
						(tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

					("n" "Next Tasks"
					 ((todo "NEXT"
									((org-agenda-overriding-header "Next Tasks")))))

					("W" "Work Tasks" tags-todo "+work-email")

					;; Low-effort next actions
					("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
					 ((org-agenda-overriding-header "Low Effort Tasks")
						(org-agenda-max-todos 20)
						(org-agenda-files org-agenda-files)))

					("w" "Workflow Status"
					 ((todo "WAIT"
									((org-agenda-overriding-header "Waiting on External")
									 (org-agenda-files org-agenda-files)))
						(todo "REVIEW"
									((org-agenda-overriding-header "In Review")
									 (org-agenda-files org-agenda-files)))
						(todo "PLAN"
									((org-agenda-overriding-header "In Planning")
									 (org-agenda-todo-list-sublevels nil)
									 (org-agenda-files org-agenda-files)))
						(todo "BACKLOG"
									((org-agenda-overriding-header "Project Backlog")
									 (org-agenda-todo-list-sublevels nil)
									 (org-agenda-files org-agenda-files)))
						(todo "READY"
									((org-agenda-overriding-header "Ready for Work")
									 (org-agenda-files org-agenda-files)))
						(todo "ACTIVE"
									((org-agenda-overriding-header "Active Projects")
									 (org-agenda-files org-agenda-files)))
						(todo "COMPLETED"
									((org-agenda-overriding-header "Completed Projects")
									 (org-agenda-files org-agenda-files)))
						(todo "CANC"
									((org-agenda-overriding-header "Cancelled Projects")
									 (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
				`(("t" "Tasks / Projects")
					("tt" "Task" entry (file+olp "~/Projects/Code/emacs-from-scratch/OrgFiles/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

					("j" "Journal Entries")
					("jj" "Journal" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
					("jm" "Meeting" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

					("w" "Workflows")
					("we" "Checking Email" entry (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

					("m" "Metrics Capture")
					("mw" "Weight" table-line (file+headline "~/Projects/Code/emacs-from-scratch/OrgFiles/Metrics.org" "Weight")
					 "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  (efs/org-font-setup))

(setq org-show-notification-handler 'message)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (java . t)
   (python . t)
   (shell . t)))

(push '("conf-unix" . conf-unix) org-src-lang-modes)

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp\n"))
(add-to-list 'org-structure-template-alist '("py" . "src python\n"))
(add-to-list 'org-structure-template-alist '("js" . "src javascript\n"))

(use-package htmlize
  :ensure t)

(add-hook 'org-mode-hook
          '(lambda ()
             (visual-line-mode 1)))

(when (file-directory-p "/usr/share/emacs/site-lisp/tex-utils")
  (add-to-list 'load-path "/usr/share/emacs/site-lisp/tex-utils")
  (require 'xdvi-search))

(add-to-list 'load-path (expand-file-name "site-lisp/ox-taskjuggler" user-emacs-directory))
(require 'ox-taskjuggler)
(require 'taskjuggler-mode)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/personal/gdrive/org/roam")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-setup))

;;;; programming
(use-package company
  :defer t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
							("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 3)
  (company-idle-delay 0.0))

(use-package company-box
  :defer t
  :hook (company-mode . company-box-mode))

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-t")  ;; Or 'C-c l', or 'C-l', 's-l'
  ;;https://emacs-lsp.github.io/lsp-mode/page/performance/ 
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)
  (setq lsp-log-io nil) ; if set to true can cause a performance hit
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :defer t
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package treemacs
  :defer t
  :bind
  (:map global-map
        ("C-*"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package lsp-treemacs
  :defer t
  :after lsp)

(use-package lsp-ivy
  :defer t)

(use-package lsp-sonarlint
  :ensure t
  :defer t
  :init
  (setq lsp-sonarlint-typescript-enabled t)
  (setq lsp-sonarlint-html-enabled t)
  (setq lsp-sonarlint-css-enabled t)
  (setq lsp-sonarlint-javascript-enabled t))

(use-package dash
  :defer t)
(require 'dash-functional)

(use-package js2-mode
  :defer t
  :mode "\\.js\\'"
  :hook (js2-mode . lsp-deferred)

  :config
  (setq javascript-indent-level 4))

(use-package js-import
  :defer t
  :hook (js2-mode . lsp-deferred))

(setq lsp-clients-angular-language-server-command
			'("node"
				"/Users/user/.nvm/versions/node/v12.20.1/lib/node_modules/@angular/language-server"
				"--ngProbeLocations"
				"/Users/user/.nvm/versions/node/v12.20.1/lib/node_modules"
				"--tsProbeLocations"
				"/Users/user/.nvm/versions/node/v12.20.1/lib/node_modules"
				"--stdio"))

(use-package projectile
  :defer t
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)

  :init

  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/git")
    (setq projectile-project-search-path '("~/git")))
  (setq projectile-switch-project-action #'projectile-dired))


(use-package counsel-projectile
  :defer t
  :config (counsel-projectile-mode))

(use-package magit

  :defer t
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge
  :defer t)


(use-package treemacs-magit
  :after (treemacs magit)
  :defer t)

;;;; minor conveniences
(setq require-final-newline t)
(setq-default indent-tabs-mode nil)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(setq-default tab-width 2)

(use-package ng2-mode 
  :ensure t 
  :defer t
  :after ng2-mode
  :config
  (define-key ng2-html-mode-map (kbd "C-c C-p") 'sgml-skip-tag-backward)
  (define-key ng2-html-mode-map (kbd "C-c C-n") 'sgml-skip-tag-forward))
(use-package stylus-mode :ensure t :defer t)

(use-package prettier-js :ensure t :defer t)
(setq prettier-js-args '(
												 "--trailing-comma" "es5"
												 "--single-quote" "false"
												 "--jsx-bracket-same-line" "true"
												 ))
(add-hook 'ng2-ts-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'css-mode-hook 'prettier-js-mode)
(add-hook 'html-mode-hook 'prettier-js-mode)

(use-package emmet-mode :ensure t :defer t
  :config
  (unbind-key "C-j" emmet-mode-keymap)
  )
(add-hook 'ng2-html-mode-hook 'emmet-mode)

(setq electric-pair-pairs '(
                            (?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")
                            ))
(electric-pair-mode t)

;;;; fullscreen = F12
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
      (if (equal 'fullboth current-value)
        (if (boundp 'old-fullscreen) old-fullscreen nil)
        (progn (setq old-fullscreen current-value)
          'fullboth)))))
(global-set-key [f12] 'toggle-fullscreen)

;;;; keybinding config ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package general
  :config
  (general-create-definer at/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (at/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(general-define-key
 "C-h C-k" 'free-keys
 "C-!" 'rgrep
 "C-c m" 'magit
 "C-$" 'term-paste
 "C-," 'beginning-of-buffer
 "C-." 'end-of-buffer
 "C-x C-o" 'ace-window
 "C-)" 'other-frame
 )

(global-set-key (kbd "C-{") 'backward-paragraph)
(global-set-key (kbd "C-}") 'forward-paragraph)

(define-key org-mode-map (kbd "C-,") nil)
(define-key org-mode-map (kbd "C-M-t") nil)


(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(global-set-key (kbd "C-c '") 'org-edit-src-code)


;;; evil
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 8)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(at/leader-keys
  "o" '(hydra-text-scale/body :which-key "scale text"))
;; (add-to-list 'load-path (expand-file-name "site-lisp/evil" user-emacs-directory))
;; (require 'evil)
;; (setq evil-want-integration t)
;; (setq evil-want-keybinding nils)
;; (setq evil-want-C-u-scroll t)
;; (setq evil-want-C-i-jump nil)
;; (evil-mode 1)
;; (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
;; (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

;; ;; Use visual line motions even outside of visual-line-mode buffers
;; (evil-global-set-key 'motion "j" 'evil-next-visual-line)
;; (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

;; (evil-set-initial-state 'messages-buffer-mode 'normal)
;; (evil-set-initial-state 'dashboard-mode 'normal)

;; (use-package evil-collection
;;   :after evil
;;   :config
;;   (evil-collection-init))
