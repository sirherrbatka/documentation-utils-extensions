(in-package #:documentation-utils-extensions)


(defun find-documentation (type name)
  (%find-documentation *documentation* type (list name)))


(defun clear-documentation ()
  (%clear-documentation *documentation*))


(defun select-documentation (&key package label type)
  (%paragraphs-with-label *documentation* package label type))


(defun execute-documentation (&key package label type)
  (map nil
       (lambda (x)
         (destructuring-bind ((name type label) . body) x
           (format t "Executing ~a paragraph for object ~a of type ~a.~%"
                   label name type)
           (funcall
            (compile
             `(lambda () ,(if (listp body)
                         (cons 'progn (mapcar #'read-from-string body))
                         (read-from-string body)))))))
       (%select-documentation *documentation* package label type)))
