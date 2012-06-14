#lang rash

(define lines '("a" "b" "c"))

;; can also pipe data / racket calls directly. doesn't have to be a command
(pipe lines (grep "b"))
