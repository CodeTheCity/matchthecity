json.array!(@organisations) do |organisation|
  json.extract! organisation, :id, :name, :address, :postcode, :latitude, :longitude, :email, :telephone, :web, :region_id, :logo_url
  json.url organisation_url(organisation, format: :json)
end
