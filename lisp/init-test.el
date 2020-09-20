;;; init-test.el --- Configure test -*- lexical-binding: t -*-
;;; Commentary: Various functions that I am not sure I will use
;;; Code:

;;; from https://dse.livejournal.com/67732.html
(defun fix-frame-horizontal-size (width)
  "Set the frame's size to 80 (or prefix arg WIDTH) columns wide."
  (interactive "P")
  (if window-system
      (set-frame-width (selected-frame) (or width 80))
    (error "Cannot resize frame horizontally: is a text terminal")))

(defun fix-window-horizontal-size (width)
  "Set the window's size to 80 (or prefix arg WIDTH) columns wide."
  (interactive "P")
  (enlarge-window (- (or width 80) (window-width)) 'horizontal))

(defun fix-horizontal-size (width)
  "Set the window's or frame's width to 80 (or prefix arg WIDTH)."
  (interactive "P")
  (condition-case nil
      (fix-window-horizontal-size width)
    (error 
     (condition-case nil
	 (fix-frame-horizontal-size width)
       (error
	(error "Cannot resize window or frame horizontally"))))))

;;(global-set-key (kbd "C-x W") 'fix-horizontal-size)
(global-set-key (kbd "C-x W") 'fix-window-horizontal-size)


(provide 'init-test)
;;; init-test.el ends here
