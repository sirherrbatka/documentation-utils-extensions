(in-package #:cl-user)


(defpackage documentation-utils-extensions
  (:use #:common-lisp)
  (:nicknames :docs.ext)
  (:export
   #:*documentation*
   #:*documentation-sections*
   #:aggregating-formatter
   #:clear-documentation
   #:documentation-collection
   #:find-documentation
   #:make-documentation-collection
   #:rich-aggregating-formatter
   #:rich-formatter))
