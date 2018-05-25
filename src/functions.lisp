(in-package #:documentation-utils-extensions)


(defun find-documentation (type name)
  (%find-documentation *documentation* type (list name)))


(defun clear-documentation ()
  (%clear-documentation *documentation*))


;; TODO Needs to be a little more complex (general purpose filtering function: filter by package, by type of documented object, possibly by name of the symbol and documentation context).
(defun select-documentation (&key package label type)
  (%paragraphs-with-label *documentation* package label type))


(defun execute-paragraphs (&key package label type)
  (map nil
       (lambda (x) (funcall (compile nil `(lambda () ,(read-from-string x)))))
       (%paragraphs-with-label *documentation* label)))
