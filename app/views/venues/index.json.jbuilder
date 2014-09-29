json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :address, :postcode, :latitude, :longitude, :web, :telephone, :email, :region
  json.url venue_url(venue, format: :json)
end
