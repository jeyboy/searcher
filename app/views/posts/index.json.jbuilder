json.array!(@posts) do |post|
  json.extract! post, :name, :category_id, :body
  json.url post_url(post, format: :json)
end
