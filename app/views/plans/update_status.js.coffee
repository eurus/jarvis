code = '<%= code %>'
id = '<%= id %>'
status = '<%=status%>'
statusClass = '<%=statusClass%>'

if code == "ok"
  sweetAlert "Update successfully!"
  $("#plan-status-#{id}").html status
  $("#plan-status-#{id}").removeAttr('class')
  $("#plan-status-#{id}").addClass "label label-#{statusClass}"

else
  sweetAlert "(╯‵□′)╯︵┻━┻","Calm down, Bro"

