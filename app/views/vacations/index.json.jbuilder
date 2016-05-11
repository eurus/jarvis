json.array!(@vacations) do |vacation|
  json.extract! vacation, :id, :start_at, :duration, :type, :content
  json.url vacation_url(vacation, format: :json)
end
