cut = '<%= cut%>'
id = '<%= id%>'
status_explain = '<%= status_explain %>'
item_str = "#check-#{cut}-#{id}"
row_str = "#tr-#{cut}-#{id}"
status_str = "#tr-status-#{cut}-#{id}"
explain_str = "#tr-status-explain-#{id}"
$(status_str).html "已审核"
$(explain_str).html status_explain
$(item_str).remove()
$(status_str).addClass('warning')

