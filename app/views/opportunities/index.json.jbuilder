json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :name, :category, :description, :activity_id, :sub_activity_id, :venue_id, :room, :start_time, :end_time, :day_of_week, :sub_activity, :activity, :image_url, :effort_rating, :tag_list
  json.venue do |json|
    json.(opportunity.venue, :id, :name, :slug, :address, :postcode, :latitude, :longitude, :created_at, :updated_at, :web, :telephone, :email, :region, :venue_owner, :latitude, :longitude, :venue_notices) unless opportunity.venue.nil?
  end
  json.url opportunity_url(opportunity, format: :json)
end
