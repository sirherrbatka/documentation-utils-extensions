(in-package #:cl-user)


(defpackage documentation-utils-extensions
  (:use #:common-lisp)
  (:nicknames :docs.ext)
  (:export
   #:%documentation-sections
   #:*documentation*
   #:*documentation-sections*
   #:aggregating-formatter
   #:clear-documentation
   #:documentation-collection
   #:find-documentation
   #:make-documentation-collection
   #:paragraphs-with-label
   #:read-documentation-sections
   #:rich-aggregating-formatter
   #:rich-formatter))
