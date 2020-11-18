;;; init-org2blog.el --- Configure org2blog -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'org2blog)

(setq org2blog/wp-blog-alist
      '(("Arseniy Tsipenyuk"
         :url "https://tsipenyuk.wordpress.com/xmlrpc.php"
         :username "arseniytsipenyuk")))

(define-key org-mode-map (kbd "C-c C-.") 'org2blog-user-interface)

(provide 'init-org2blog)
;;; init-org2blog.el ends here
