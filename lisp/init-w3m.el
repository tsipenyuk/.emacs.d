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

(provide 'init-w3m)
;;; init-w3m.el ends here
