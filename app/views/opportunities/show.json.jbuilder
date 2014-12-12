json.extract! @opportunity, :id, :name, :category, :description, :created_at, :updated_at, :activity_id, :sub_activity_id, :venue_id, :room, :start_time, :end_time, :day_of_week, :sub_activity, :activity, :image_url, :effort_rating, :tag_list

json.venue do |json|
  json.(@opportunity.venue, :id, :name, :address, :postcode, :latitude, :longitude, :created_at, :updated_at, :web, :telephone, :email, :region, :latitude, :longitude, :venue_notices)
end