(in-package #:documentation-utils-extensions)


(defparameter *documentation* nil)


(defparameter *documentation-sections*
  '((:syntax . "Syntax:")
    (:arguments . "Arguments:")
    (:examples . "Examples:")
    (:description . "Description:")
    (:returns . "Returns:")
    (:exceptional-situations . "Exceptional situations:")
    (:side-effects . "Side Effects:")
    (:affected-by . "Affected by")
    (:thread-safety . "Thread Safety:")
    (:see-also . "See also:")
    (:notes . "Notes:")))
