json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :user_id, :content
  json.url feedback_url(feedback, format: :json)
end
