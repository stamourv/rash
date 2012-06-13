#lang racket

(require "hidden-files.rkt")

(define (are-we-in-git?)
  (if (member ".git" (hidden-files))
      "Yes, we're in git. Life is good."
      "WARNING: This directory is not under version control!"))

(module+ main
  (displayln (are-we-in-git?)))
