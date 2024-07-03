(jsx_attribute
  (property_identifier) @_attribute_name
  (#any-of? @_attribute_name "class" "className")
  [
   (string
     (string_fragment) @tailwind)
   (jsx_expression
     [
     (template_string
       (string_fragment) @tailwind)
     (call_expression
       function: (identifier) @_function_name
       (#eq? @_function_name "cn")
       arguments: (arguments [
                              (string (string_fragment) @tailwind)
                              (binary_expression
                                right: (string (string_fragment) @tailwind)
                                )
                              (ternary_expression
                                condition: (identifier)
                                consequence: [
                                              (_)
                                              (string (string_fragment) @tailwind)
                                              ]
                                alternative: [
                                              (_)
                                              (string (string_fragment) @tailwind)
                                              ]
                                )
                              ])
       )
     ])
   ])
