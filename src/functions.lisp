(in-package #:documentation-utils-extensions)


(defun find-documentation (type name)
  (%find-documentation *documentation* type (list name)))


(defun clear-documentation ()
  (%clear-documentation *documentation*))


(defun paragraphs-with-label (label)
  (%paragraphs-with-label *documentation* label))


(defun execute-paragraphs-with-label (label)
  (map nil
       (lambda (x) (funcall (compile nil `(lambda () ,(read-from-string x)))))
       (%paragraphs-with-label *documentation* label)))
