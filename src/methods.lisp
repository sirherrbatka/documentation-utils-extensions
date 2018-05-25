(in-package #:documentation-utils-extensions)


(defgeneric %find-documentation (documentation type name))
(defgeneric %select-documentation (documentation package label type))
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


(defmethod %select-documentation ((documentation (eql nil))
                                  package label type)
  nil)


(defmethod %select-documentation ((documentation documentation-collection)
                                  package label type)
  (let ((result nil)
        (label (if (listp label) label (list label)))
        (package (if (listp package) package (list package)))
        (type (if (listp type) type (list type))))
    (flet ((on-content (key value)
             (declare (ignore key))
             (maphash (lambda (key value)
                        (let ((key (or (second key) (first key))))
                          (if (or (null package)
                                  (member (symbol-package key) package))
                              (map nil
                                   (lambda (label)
                                     (let ((paragraph (getf value label)))
                                       (unless (null paragraph)
                                         (push (list* (list package label type)
                                                      paragraph)
                                               result))))
                                   label))))
                      value)))
      (if (null type)
          (maphash (lambda (key value) (declare (ignore key)) (maphash #'on-content value))
                   (read-content documentation))
          (map nil (lambda (x &aux (table (gethash x (read-content documentation))))
                     (unless (null table)
                       (maphash #'on-content table)))
               type)))
    result))


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
  (declare (ignore type name))
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
           (read-documentation-sections formatter)))))
