#lang rash

(provide hidden-files)

(define (hidden-files)
  (pipe (ls "-a") (grep "^[.][^.]")))

(module+ main
  (hidden-files))
