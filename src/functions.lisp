(in-package #:documentation-utils-extensions)


(defun find-documentation (type name)
  (%find-documentation *documentation* type (list name)))


(defun clear-documentation ()
  (%clear-documentation *documentation*))


(defun paragraphs-with-label (label)
  (%paragraphs-with-label *documentation* label))
