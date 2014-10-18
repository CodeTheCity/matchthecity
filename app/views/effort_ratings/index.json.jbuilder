json.array!(@effort_ratings) do |effort_rating|
  json.extract! effort_rating, :id, :rating, :opportunity_id
  json.url effort_rating_url(effort_rating, format: :json)
end
