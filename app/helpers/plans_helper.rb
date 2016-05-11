module PlansHelper
  def status_highlight(status)
    case status
    when "ontime"
      "success"
    when "overtime"
      "danger"
    else
      ""
    end
  end
end
