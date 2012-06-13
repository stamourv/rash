#lang racket

(require (for-syntax syntax/parse)
         (prefix-in r: racket/base))

(provide (except-out (all-from-out racket) #%app)
         (rename-out [path-#%app #%app]))

(define-syntax (path-#%app stx)
  (syntax-parse stx
    [(_ op:id args ...)
     (if (identifier-binding #'op)
         #'(r:#%app op args ...) ; it's a Racket function
         ;; look in $PATH
         #`(void (system (string-append #,(format "$(which ~a) "
                                                  (syntax->datum #'op))
                                        (string-join (list args ...) " ")))))]))

(module reader syntax/module-reader
  #:language 'rash)
