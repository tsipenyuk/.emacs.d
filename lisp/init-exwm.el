;;; init-exwm.el --- Configure exwm -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'exwm)
(require 'exwm)
(require 'exwm-config)
(exwm-config-example)

;;(define-key exwm-mode-map (kbd "C-c") nil) ;; kill C-c mode keys
;;(global-set-key (kbd "C-c C-q") 'exwm-input-send-next-key)

(setq exwm-input-simulation-keys
      '(([?\C-b] . [left])
        ([?\C-f] . [right])
        ([?\C-p] . [up])
        ([?\C-n] . [down])
        ([?\C-a] . [home])
        ([?\C-e] . [end])
        ([?\M-v] . [prior])
        ([?\C-v] . [next])
        ([?\C-d] . [delete])
        ([?\C-k] . [S-end delete])

        ;; google-chrome (rework to make application-specific)
        ([?\C-s] . ?\C-f)
        ([?\M-w] . ?\C-c) ;; kill
        ([?\C-y] . ?\C-v) ;; copy
        ([?\C-e] . ?\C-t)
        ([?\C-u] . (kbd "C-S-t") )
        ))

;; set workspace number; switch with s-w or s-N
(setq exwm-workspace-number 4)

(exwm-input-set-key (kbd "s-t") 'exwm-input-release-keyboard)

;; language switcher
;;(read-shell-command "$ ")

(provide 'init-exwm)
;;; init-exwm.el ends here


