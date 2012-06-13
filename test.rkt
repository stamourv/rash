#lang rash

(require rackunit)

(define-syntax-rule (->string e)
  (with-output-to-string (lambda () e)))

(check-equal? (->string (displayln (+ 1 2 3))) ; regular function call
              "6\n")
(check-equal? (->string (echo "a" "b" "c"))
              "a b c\n")
(check-equal? (->string (ls "test.rkt"))
              "test.rkt\n")
