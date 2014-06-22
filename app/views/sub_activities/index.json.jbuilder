json.array!(@sub_activities) do |sub_activity|
  json.extract! sub_activity, :id, :activity_id, :title
  json.url sub_activity_url(sub_activity, format: :json)
end
