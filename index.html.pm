#lang pollen
◊(require "index.ptree")
◊(define prev-page (previous here))
◊(define next-page (next here))
◊;doc is imported from .ptree
◊(define toc-list (generate-toc (cdr doc)))

◊(list-ref toc-list 0)
