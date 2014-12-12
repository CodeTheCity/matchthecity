json.array!(@venue_notices) do |venue_notice|
  json.extract! venue_notice, :id, :venue_id, :starts, :expires, :message
  json.url venue_notice_url(venue_notice, format: :json)
end
