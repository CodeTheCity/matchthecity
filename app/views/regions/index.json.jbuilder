json.array!(@regions) do |region|
  json.extract! region, :id, :name, :created_at, :updated_at
  json.url region_url(region, format: :json)
end
