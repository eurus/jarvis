json.array!(@articals) do |artical|
  json.extract! artical, :id, :title, :content, :user_id, :origin
  json.url artical_url(artical, format: :json)
end
