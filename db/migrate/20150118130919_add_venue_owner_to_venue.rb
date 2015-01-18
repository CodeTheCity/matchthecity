class AddVenueOwnerToVenue < ActiveRecord::Migration
  def change
    add_reference :venues, :venue_owner, index: true
  end
end
