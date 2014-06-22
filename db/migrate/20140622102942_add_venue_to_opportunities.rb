class AddVenueToOpportunities < ActiveRecord::Migration
  def change
    add_reference :opportunities, :venue, index: true
  end
end
