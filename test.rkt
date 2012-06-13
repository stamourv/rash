#lang rash

(require rackunit)

(define-syntax-rule (->string e)
  (with-output-to-string (lambda () e)))

(check-equal? (+ 1 2 3) ; regular function calls should still work
              6)
(check-equal? (echo "a" "b" "c")
              '("a b c"))
(check-equal? (ls "test.rkt" "main.rkt")
              '("main.rkt" "test.rkt"))
