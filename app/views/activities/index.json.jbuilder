json.array!(@activities) do |activity|
  json.extract! activity, :id, :title, :category
  json.url activity_url(activity, format: :json)
end
