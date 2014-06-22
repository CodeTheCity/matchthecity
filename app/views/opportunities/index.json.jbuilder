json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :name, :category, :description, :activity_id, :sub_activity_id
  json.url opportunity_url(opportunity, format: :json)
end
