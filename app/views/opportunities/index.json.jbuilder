json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :name, :category, :description, :activity_id, :sub_activity_id, :venue_id, :room, :start_time, :end_time, :day_of_week, :venue, :sub_activity, :activity, :image_url
  json.url opportunity_url(opportunity, format: :json)
end
