json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :address, :postcode, :latitude, :longitude
  json.url venue_url(venue, format: :json)
end
