json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :name, :category, :description
  json.url opportunity_url(opportunity, format: :json)
end
