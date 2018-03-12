(in-package #:documentation-utils-extensions)


(defparameter *documentation* nil)


(defparameter *documentation-sections*
  '((:syntax . "Syntax:")
    (:arguments . "Arguments:")
    (:examples . "Examples:")
    (:description . "Description:")
    (:returns . "Returns:")
    (:side-effects . "Side Effects:")
    (:thread-safety . "Thread Safety:")
    (:notes . "Notes:")))
