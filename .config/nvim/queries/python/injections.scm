;; extends
(call
  function: (identifier) @sql_function
  arguments: (argument_list
    .
    (string
      (string_content) @injection.content))
  (#eq? @sql_function "SQL")
  (#set! injection.language "sql"))
