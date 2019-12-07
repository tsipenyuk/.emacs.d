;;; init-helm-bibtex.el --- Configure helm-bibtex -*- lexical-binding: t -*-
;;; Commentary: see https://github.com/tmalsburg/helm-bibtex
;;; Code:

(require-package 'helm-bibtex)

(setq bibtex-completion-bibliography
      '("~/Dropbox \(Maestral\)/bibliography/references-zot.bib"))
(setq bibtex-completion-library-path
      '("~/Dropbox \(Maestral\)/bibliography/references-pdf"
	"~/Dropbox \(Maestral\)/bibliography/references-etc"))

(global-set-key [?\C-c ?i] 'helm-bibtex)

(provide 'init-helm-bibtex)
;;; init-helm-bibtex.el ends here
