;;; custom-russian-layout.el.gz --- Quail package; inputting russian characters from programmer Dvorak

;; Copyright (C) 2015-2019 Free Software Foundation, Inc.

;; Author: Arseniy Tsipenyuk <arseniy.tsipenyuk@gmail.com>

;; This file is released under the terms of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; This file provides an input method for the programmers Dvorak keyboard
;;; layout by Roland Kaufman (<http://www.kaufmann.no/roland/dvorak/>).

;; Arseniy Tsipenyuk <arseniy.tsipenyuk@gmail.com>
(quail-define-package
 "pdv-to-russian-typewriter" "Russian" "ЖЙ" nil
 "ЙЦУКЕН Russian typewriter layout (ISO 8859-5 encoding)."
 nil t t t t nil nil nil nil nil t)

;; №1 -2 /3 "4 :5 ,6 .7 _8 ?9 %0 != ;\ |
;; Й Ц У К Е Н Г Ш Щ З Х Ъ )(
;; Ф Ы В А П Р О Л Д Ж Э
;; Я Ч С М И Т Ь Б Ю Ё

(quail-define-rules
 ("&" ?№)
 ("[" ?-)
 ("{" ?/)
 ("}" ?\")
 ("(" ?:)
 ("=" ?,)
 ("*" ?.)
 (")" ?_)
 (" " ??)
 ("]" ?%)
 ("!" ?!)
 ("#" ?\;)
 ("$" ?|)
 (";" ?й)
 ("," ?ц)
 ("." ?у)
 ("p" ?к)
 ("y" ?е)
 ("f" ?н)
 ("g" ?г)
 ("c" ?ш)
 ("r" ?щ)
 ("l" ?з)
 ("/" ?х)
 ("@" ?ъ)
 ("a" ?ф)
 ("o" ?ы)
 ("e" ?в)
 ("u" ?а)
 ("i" ?п)
 ("d" ?р)
 ("h" ?о)
 ("t" ?л)
 ("n" ?д)
 ("s" ?ж)
 ("-" ?э)
 ("\\" ?\))
 ("'" ?я)
 ("q" ?ч)
 ("j" ?с)
 ("k" ?м)
 ("x" ?и)
 ("b" ?т)
 ("m" ?ь)
 ("w" ?б)
 ("v" ?ю)
 ("z" ?ё)

 ("%" ?1)
 ("7" ?7)
 ("5" ?5)
 ("3" ?3)
 ("1" ?1)
 ("9" ?9)
 ("0" ?0)
 ("2" ?2)
 ("4" ?4)
 ("6" ?6)
 ("8" ?8)
 ("`" ?\\)
 ("~" ? )
 (":" ?Й)
 ("<" ?Ц)
 (">" ?У)
 ("P" ?К)
 ("Y" ?Е)
 ("F" ?Н)
 ("G" ?Г)
 ("C" ?Ш)
 ("R" ?Щ)
 ("L" ?З)
 ("?" ?Х)
 ("^" ?Ъ)
 ("A" ?Ф)
 ("O" ?Ы)
 ("E" ?В)
 ("U" ?А)
 ("I" ?П)
 ("D" ?Р)
 ("H" ?О)
 ("T" ?Л)
 ("N" ?Д)
 ("S" ?Ж)
 ("_" ?Э)
 ("|" ?\()
 ("\"" ?Я)
 ("Q" ?Ч)
 ("J" ?С)
 ("K" ?М)
 ("X" ?И)
 ("B" ?Т)
 ("M" ?Ь)
 ("W" ?Б)
 ("V" ?Ю)
 ("Z" ?Ё))


;; Maintain the obsolete name for now.
(push (cons "cyrillic-jcuken"
	    (cdr (assoc "pdv-to-rut" quail-package-alist)))
      quail-package-alist)

;; This needs to be seen by quail-update-leim-list-file, but cannot be
;; commented out because quail-update-leim-list-file ignores
;; commented-out lines.
(if nil
    (quail-define-package
     "cyrillic-jcuken" "Russian" "ЖЙ" nil
     "PDV to ЙЦУКЕН Russian typewriter layout (modified)."))

(provide 'pdv-to-rut)
