(in-package #:documentation-utils-extensions)


(docs:define-docs
  :formatter rich-aggregating-formatter

  (function find-documentation
    (:arguments ((type "Type, as specified by documentation-utils.")
                 (name "Name, as specified by documentation-utils."))
     :description "Attempts to find aggregated documentation. Will fail if *DOCUMENTATION* is bound to nil, or there is no object of type and name in it."
     :returns ((first "Arguments, as passed to the formatter. NIL if not found.")
               (second "Boolean. T if documentation was found, NIL otherwise."))))

  (function clear-documentation
    (:description "Removes everything from *DOCUMENTATION*. Does nothing if *DOCUMENTATION* is bound to nil."))

  (function select-documentation
    (:description "Selects all sections with LABEL from *documentation* documenting object named by symbols from PACKAGE and TYPE. LABEL, PACKAGE and TYPE may be: just a symbol, list of symbols (will return union) or nil (will disable filtering)."))

  (function execute-documentation
    (:description "Calls SELECT-DOCUMENTATION first, then attempts to read-from-string, compile and execute each result. Works with sections containing pure strings as well as lists of strings. In the second case, whole paragraph is executed in one go."
     :notes "This function is used most often with respect to :EXAMPLES section."
     :exceptional-situations "Does not attempt to handle errors signaled by either read or compile. Simply assumes that paragraph should contain valid Lisp code."
     :returns "Always nil"))

  (variable *documentation-sections*
    (:description "Alist used by RICH-FORMATTER to determine sections of documentation. Maps symbols to section names.. RICH-FORMATTER will always use order of formatting identical to that provided by this list."))

  (variable *documentation*
    (:description "Acumulated arguments of define-docs. Can be (and is by default) bound to nil, which disables this feature.")
    (:examples (("Disable gathering" "(defparameter docs.ext:*documentation* nil)")
                ("Enable gathering" "(defparameter docs.ext:*documentation* (docs.ext:make-documentation-collection))"))))

  (type documentation-collection
    (:description "Class used to map type and name to arguments of define-docs."
     :notes "See MAKE-DOCUMENTATION-COLLECTION, *DOCUMENTATION* and FIND-DOCUMENTATION for more information."))

  (type rich-formatter
    (:description "Subclass of documentation-formatter, with rich formatting arguments. Those include: :arguments, :examples, :description, :returns, :side-effects and :notes."
     :notes ("Will simply ignore unknown arguments."
             "Values passed may be in the form of strings, or lists."
             "Nested lists (just first level) are printed using (format stream \" --~{~a~^, ~}~%\" x)."
             "Above is handy when specifing (for instance) :arguments. First element of list may designate argument name, second can contain description of the argument.")))

  (type aggregating-formatter
    (:description "Use subclass of this formatter to enable documentation gathering into *DOCUMENTATION*"
     :notes "Existing format-documentation specialization uses :after specializer. This approach is condition safe."))

  (type rich-aggregating-formatter
    (:description "Combines rich-formatter and aggregating formatter into one class.")))
