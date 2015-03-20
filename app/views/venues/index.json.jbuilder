json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :slug, :address, :postcode, :latitude, :longitude, :web, :telephone, :email, :region, :created_at, :updated_at, :venue_notices
  json.url venue_url(venue, format: :json)
end
