;;; init-outline.el --- Configure outline -*- lexical-binding: t -*-
;;; Commentary:
;;; Setting up outline minor mode as described in
;;; https://emacs.stackexchange.com/questions/361/how-can-i-hide-display-latex-section-just-like-org-mode-does-with-headlines
;;; Code:

(add-hook 'LaTeX-mode-hook #'outline-minor-mode)
(add-hook 'julia-mode-hook #'outline-minor-mode)

(global-unset-key "\C-o")

(let ((map outline-minor-mode-map))
  ;; HIDE
  (define-key map (kbd "C-o C-q") 'hide-sublevels); Hide everything but the top-level headings
  (define-key map (kbd "C-o C-x") 'outline-hide-body)     ; Hide everything but headings (all body lines) "toggle"
  (define-key map (kbd "C-o C-o") 'outline-hide-other)        ; Hide other branches
  (define-key map (kbd "C-o C-c") 'outline-hide-entry)        ; Hide this entry's body
  (define-key map (kbd "C-o C-l") 'outline-hide-leaves)       ; Hide body lines in this entry and sub-entries
  (define-key map (kbd "C-o C-d") 'outline-hide-subtree)      ; Hide everything in this entry and sub-entries
  ;; SHOW
  (define-key map (kbd "C-o C-a") 'outline-show-all)          ; Show (expand) everything
  (define-key map (kbd "C-o C-e") 'outline-show-entry)        ; Show this heading's body
  (define-key map (kbd "C-o C-i") 'outline-show-children)     ; Show this heading's immediate child sub-headings
  (define-key map (kbd "C-o C-k") 'outline-show-branches); Show all sub-headings under this heading
  (define-key map (kbd "C-o C-s") 'outline-show-subtree) ; Show (expand) everything in this heading & below
  ;; MOVE
  (define-key map (kbd "C-o C-u") 'outline-up-heading)                ; Up
  (define-key map (kbd "C-o C-p") 'outline-previous-visible-heading)
  (define-key map (kbd "C-o C-n") 'outline-next-visible-heading)
  (define-key map (kbd "C-o C-f") 'outline-forward-same-level)        ; Forward - same level
  (define-key map (kbd "C-o C-b") 'outline-backward-same-level)       ; Backward - same level
  )

;; Outline magic
(require-package 'outline-magic)
(eval-after-load 'outline
  '(progn
    (require 'outline-magic)
    (define-key outline-minor-mode-map (kbd "<C-tab>") 'outline-cycle)))

;; extra outline headers
(setq TeX-outline-extra
      '(("% chapter" 1)
	("% -->" 1)
	("%% -->" 2)
        ("% section" 2)
	("%%% -->" 3)
        ("% subsection" 3)
	("%%%% -->" 4)
        ("% subsubsection" 4)
	("%%%%% -->" 5)
        ("% paragraph" 5)))

;; add font locking to the headers
(font-lock-add-keywords
 'latex-mode
 '(("^%\\(chapter\\|\\(sub\\|subsub\\)?section\\|paragraph\\)"
    0 'font-lock-keyword-face t)
   ("^%chapter{\\(.*\\)}"       1 'font-latex-sectioning-1-face t)
   ("^%section{\\(.*\\)}"       1 'font-latex-sectioning-2-face t)
   ("^%subsection{\\(.*\\)}"    1 'font-latex-sectioning-3-face t)
   ("^%subsubsection{\\(.*\\)}" 1 'font-latex-sectioning-4-face t)
   ("^%paragraph{\\(.*\\)}"     1 'font-latex-sectioning-5-face t)))

(provide 'init-outline)
;;; init-outline.el ends here
