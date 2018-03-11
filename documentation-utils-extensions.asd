(in-package #:cl-user)


(asdf:defsystem documentation-utils-extensions
  :name "documentation-utils-extensions"
  :version "0.0.0"
  :license "MIT"
  :author "Marek Kochanowicz"
  :maintainer "Marek Kochanowicz"
  :depends-on ( :documentation-utils )
  :serial T
  :pathname "src"
  :components ((:file "package")
               (:file "classes")
               (:file "variables")
               (:file "methods")
               (:file "functions")
               (:file "documentation")))
