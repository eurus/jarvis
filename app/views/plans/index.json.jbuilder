json.array!(@plans) do |plan|
  json.extract! plan, :id, :title, :description, :user_id, :status, :cut, :start_at, :end_at
  json.url plan_url(plan, format: :json)
end
