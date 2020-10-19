;;; init-auctex.el --- Configure auctex -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'auctex)

;;; Adjust for each system
(load "/home/at/.emacs.d/elpa-27.1/auctex-12.2.5/auctex.el" nil t t)        
(load "/home/at/.emacs.d/elpa-27.1/auctex-12.2.5/preview.el" nil t t) 

;; Custom settings
(with-eval-after-load "latex"
  (setq font-latex-fontify-script t)
  ;;
  ;;(custom-set-variables '(font-latex-fontify-sectioning 1.0))
  ;;
  (custom-set-faces
   ;;
   '(font-latex-bold-face ((t (:inherit bold))))
   '(font-latex-italic-face ((t (:inherit italic))))   
   `(font-latex-math-face ((t (:foreground ,(face-attribute font-lock-keyword-face :foreground)))))
   ;;
   '(font-latex-slide-title-face
     ((t (:inherit
	  :weight thin
	  :height 1.0))))
   ;;
   `(font-latex-sectioning-0-face ((t (:foreground ,(face-attribute font-lock-function-name-face :foreground)))))
   `(font-latex-sectioning-1-face ((t (:foreground ,(face-attribute font-lock-function-name-face :foreground)))))
   `(font-latex-sectioning-2-face ((t (:foreground ,(face-attribute font-lock-function-name-face :foreground)))))
   `(font-latex-sectioning-3-face ((t (:foreground ,(face-attribute font-lock-function-name-face :foreground)))))
   `(font-latex-sectioning-4-face ((t (:foreground ,(face-attribute font-lock-function-name-face :foreground)))))
   `(font-latex-sectioning-5-face ((t (:foreground ,(face-attribute font-lock-function-name-face :foreground)))))
   ;;
   `(font-latex-sedate-face ((t (:foreground ,(face-attribute font-lock-type-face :foreground)))))
   '(font-latex-slide-title-face
     ((t (:inherit
	  (variable-pitch font-lock-variable-name-face default)
	  :weight normal;;semi-bold
	  :height 1.0))))
   ;;
   `(font-latex-string-face ((t (:foreground ,(face-attribute font-lock-string-face :foreground)))))
   `(font-latex-superscript-face
     ((t (:background "#eee8d5" :height 1.0
		      :foreground ,(face-attribute font-lock-keyword-face :foreground)))))
   `(font-latex-subscript-face
     ((t (:background "#eee8d5" :height 1.0
		      :foreground ,(face-attribute font-lock-keyword-face :foreground)))))
   '(font-latex-verbatim-face ((t (:inherit fixed-pitch
					    :foreground "#2aa198"
					    :weight normal
					    :family "MathJax_Typewriter"))))
   `(font-latex-warning-face ((t (:foreground ,(face-attribute font-lock-warning-face :foreground)))))
   )
  )

;;; Customize faces
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(font-latex-bold-face ((t nil)))
;; '(font-latex-doctex-documentation-face ((t nil)))
;; '(font-latex-doctex-preprocessor-face ((t nil)))
;; '(font-latex-italic-face ((t nil)))
;; '(font-latex-math-face ((t nil)))
;; '(font-latex-script-char-face ((t nil)))
;; '(font-latex-sectioning-0-face ((t nil)))
;; '(font-latex-sectioning-1-face ((t nil)))
;; '(font-latex-sectioning-2-face ((t nil)))
;; '(font-latex-sectioning-3-face ((t nil)))
;; '(font-latex-sectioning-4-face ((t nil)))
;; '(font-latex-sectioning-5-face ((t nil)))
;; '(font-latex-sedate-face ((t nil)))
;; '(font-latex-slide-title-face ((t nil)))
;; '(font-latex-string-face ((t nil)))
;; '(font-latex-subscript-face ((t nil)))
;; '(font-latex-superscript-face ((t nil)))
;; '(font-latex-verbatim-face ((t nil)))
;; '(font-latex-warning-face ((t nil))))
;;;;(add-hook 'after-init-hook (lambda () (previous-buffer)))
;;
;;(setq font-latex-user-keyword-classes
;;      ;; Make <\macroname> display with the same face as \mbox.
;;      ;; \mbox is classified as "function" in font-latex.el and as such it
;;      ;; uses the face font-lock-function-name-face.
;;      '(("definecolor"  (("definecolor" "{")) font-lock-function-name-face command)))
;;

(provide 'init-auctex)
;;; init-auctex.el ends here
