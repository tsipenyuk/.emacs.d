;;; init-themes.el --- Defaults for themes -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'dark)
(enable-theme 'solarized)

;;------------------------------------------------------------------------------
;; Toggle between light and dark
;;------------------------------------------------------------------------------
(defun light ()
  "Activate a light color theme."
  (interactive)
  (set-frame-parameter nil 'background-mode 'light)
  (enable-theme 'solarized))

(defun dark ()
  "Activate a dark color theme."
  (interactive)
  (set-frame-parameter nil 'background-mode 'dark)
  (enable-theme 'solarized))

(provide 'init-themes)
;;; init-themes.el ends here
