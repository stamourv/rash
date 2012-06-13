#lang racket

(require (for-syntax syntax/parse)
         (prefix-in r: racket/base))

(provide (except-out (all-from-out racket) #%app)
         (rename-out [rash-#%app #%app])
         pipe)

(define-syntax (rash-#%app stx)
  (syntax-parse stx
    [(_ op:id args ...)
     (if (identifier-binding #'op)
         #'(r:#%app op args ...) ; it's a Racket function, call it
         ;; try it as a shell command
         #`(rash-output
            (system (string-append #,(rash-get-command #'op)
                                   (string-join (list args ...) " ")))))]))

(define-for-syntax (rash-get-command op)
  (format "$(which ~a) " (syntax->datum op))) ; look in $PATH

(define-syntax-rule (rash-output cmd)
  (let ([output (with-output-to-string (lambda () cmd))])
    (string-split output "\n")))

(define-syntax-rule (pipe cmd1 cmd2)
  (let ([output cmd1])
    (with-input-from-string (string-join output "\n")
      (lambda () cmd2))))

(module reader syntax/module-reader
  #:language 'rash)
