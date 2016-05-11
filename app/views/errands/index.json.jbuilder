json.array!(@errands) do |errand|
  json.extract! errand, :id, :location, :content, :start_at, :end_at, :project_id, :user_id, :fee, :check, :issue
  json.url errand_url(errand, format: :json)
end
