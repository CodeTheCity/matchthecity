json.array!(@venue_owners) do |venue_owner|
  json.extract! venue_owner, :id, :name, :address, :postcode, :latitude, :longitude, :email, :telephone, :web, :region_id, :logo_url
  json.url venue_owner_url(venue_owner, format: :json)
end
