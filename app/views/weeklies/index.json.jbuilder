json.array!(@weeklies) do |weekly|
  json.extract! weekly, :id, :user_id, :sumary, :hope
  json.url weekly_url(weekly, format: :json)
end
