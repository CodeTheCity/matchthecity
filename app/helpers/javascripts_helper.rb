module JavascriptsHelper
  def add_opportunity_id(id)
    id.blank? ? "" : "id=#{id}&"
  end
end