class AddRegionToVenue < ActiveRecord::Migration
  def change
    add_reference :venues, :region, index: true
  end
end
