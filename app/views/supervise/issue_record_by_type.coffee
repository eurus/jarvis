cut = '<%= cut%>'
id = '<%= id%>'
status_explain = '<%= status_explain %>'
item_str = "#issue-#{cut}-#{id}"
row_str = "#tr-#{cut}-#{id}"
status_str = "#tr-status-#{cut}-#{id}"
explain_str = "#tr-status-explain-#{id}"
$(explain_str).html status_explain
$(status_str).html "已发放"
$(item_str).remove()
$(row_str).removeClass('warning')
$(status_str).addClass('success')
