(in-package #:documentation-utils-extensions)


(defclass aggregating-formatter (docs:documentation-formatter)
  ())


(defclass rich-formatter (docs:documentation-formatter)
  ())


(defclass rich-aggregating-formatter (aggregating-formatter rich-formatter)
  ())


(defclass documentation-collection ()
  ((%content :type hash-table
             :initform (make-hash-table)
             :reader read-content
             :documentation "Stores tree as nested hash-table: type>name>original arguments")))


(defun make-documentation-collection ()
  (make-instance 'documentation-collection))
