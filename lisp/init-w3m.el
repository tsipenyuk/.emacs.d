;;; init-w3m.el --- Configure w3m -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; w3m manual installation
;; sudo apt-get install w3m cvs autoconf libgc-dev libncurses5-dev
;; cd ~/.emacs.d/lisp/
;; cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot login
;; cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m
;; cd emacs-w3m
;; autoconf
;; ./configure
;; make
;; sudo make install
;; (add-to-list 'load-path "~/.emacs.d/lisp/emacs-w3m/")
;; (require 'w3m-load)


(require-package 'w3m)


;; from https://sachachua.com/blog/2008/08/emacs-and-w3m-quick-searches/
;; Add google search shortcut
(setq wicked/quick-search-alist
      '(("^g?:? +\\(.*\\)" . ;; Google Web 
         "http://www.google.com/search?q=\\1")
	
        ("^g!:? +\\(.*\\)" . ;; Google Lucky
         "http://www.google.com/search?btnI=I%27m+Feeling+Lucky&q=\\1")
         
	("^dict:? +\\(.*\\)" . ;; Dictionary
	 "http://dictionary.reference.com/search?q=\\1")))

;; Advice for the functions that open URLS
(require 'cl-seq)
(defadvice w3m-goto-url (before wicked activate)
  "Use the quick searches defined in `wicked/quick-search-alist'."
  (let* ((my-url (replace-regexp-in-string 
		  "^ *\\| *$" "" 
		  (replace-regexp-in-string "[ \t\n]+" " " (ad-get-arg 0))))
	 (match (assoc-if
		 (lambda (a) (string-match a my-url))
		 wicked/quick-search-alist)))
    (if match
	(ad-set-arg 0 (replace-regexp-in-string
		       (car match) (cdr match) my-url)))))

;; Use quick searches with browse-url
(defadvice browse-url (before wicked activate)
  "Use the quick searches defined in `wicked/quick-search-alist'."
  (let* ((my-url (replace-regexp-in-string 
		  "^ *\\| *$" "" 
		  (replace-regexp-in-string "[ \t\n]+" " " (ad-get-arg 0))))
	 (match (assoc-if
		 (lambda (a) (string-match a my-url))
		 wicked/quick-search-alist)))
    (if match
	(ad-set-arg 0 (replace-regexp-in-string
		       (car match) (cdr match) my-url)))))


(provide 'init-w3m)
;;; init-w3m.el ends here
