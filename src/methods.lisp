(in-package #:documentation-utils-extensions)


(defgeneric %find-documentation (documentation type name))
(defgeneric insert-documentation (documentation type name arguments))
(defgeneric format-to-stream (formatter
                              stream
                              section-name
                              documentation-form
                              first-item))
(defgeneric %clear-documentation (documentation))

(defmethod reinitialize-instance ((documentation documentation-collection)
                                  &rest initargs)
  (declare (ignore initargs))
  (setf (slot-value documentation '%content)
        (make-hash-table))
  documentation)


(defmethod %clear-documentation ((documentation documentation-collection))
  (reinitialize-instance documentation)
  nil)


(defmethod %clear-documentation ((documentation (eql nil)))
  nil)


(defmethod %find-documentation ((documentation documentation-collection)
                                type
                                name)
  (let* ((content (read-content documentation))
         (ac (gethash type content (make-hash-table :test 'equal))))
    (gethash name ac)))


(defmethod %find-documentation ((documentation-collection (eql nil))
                                type
                                name)
  (values nil nil))


(defmethod insert-documentation ((documentation documentation-collection)
                                 type
                                 name
                                 arguments)
  (let* ((content (read-content documentation))
         (inner (gethash type
                         content
                         (make-hash-table :test 'equal))))
    (setf (gethash type content) inner
          (gethash name inner) arguments)))


(defmethod insert-documentation ((documentation (eql nil))
                                 type
                                 name
                                 arguments)
  nil)


(defmethod docs:format-documentation
    :after ((formatter aggregating-formatter)
            type
            name
            arguments)
  (insert-documentation *documentation* type name arguments))


(defmethod format-to-stream (formatter
                             stream
                             section-name
                             (arguments string)
                             first-item)
  (format stream " ~a" arguments))


(defmethod format-to-stream ((formatter rich-formatter)
                             stream
                             (section-name string)
                             arguments
                             first-item)
  (unless first-item (format stream "~%~%"))
  (format stream "~a~%" section-name)
  (call-next-method))


(defmethod format-to-stream (formatter
                             stream
                             section-name
                             (arguments list)
                             first-item)
  (mapcon (lambda (arg &aux (x (car arg)))
            (if (listp x)
                (format stream " --~{~a~^, ~}" x)
                (format stream " --~a" x))
            (unless (endp (rest arg))
              (format stream "~%")))
          arguments))


(defmethod docs:format-documentation ((formatter rich-formatter)
                                      type
                                      name
                                      (arguments list))
  (let ((first-item t))
    (with-output-to-string (stream)
      (map nil
           (lambda (section)
             (let ((documentation (getf arguments (car section))))
               (unless (null documentation)
                 (format-to-stream formatter
                                   stream
                                   (cdr section)
                                   documentation
                                   first-item)
                 (setf first-item nil))))
           *documentation-sections*))))
