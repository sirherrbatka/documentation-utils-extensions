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
  :description "Set of extensions for documentation-utils."
  :components ((:file "package")
               (:file "variables")
               (:file "classes")
               (:file "methods")
               (:file "functions")
               (:file "documentation")))
