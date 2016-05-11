json.array!(@overtimes) do |overtime|
  json.extract! overtime, :id, :start_at, :duration, :content, :user_id, :approve, :issue, :project_id
  json.url overtime_url(overtime, format: :json)
end
