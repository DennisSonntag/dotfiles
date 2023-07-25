;; extends
(call_expression
	function: (identifier) @html_func (#eq? @html_func "Html")
	arguments: (arguments ((raw_string_literal) @html (#offset! @html 0 4 -3 0) ))
)

(call_expression
	function: (identifier) @html_func (#eq? @html_func "Html")
	arguments: (arguments ((string_literal) @html (#offset! @html 0 1 -1 0) ))
)
