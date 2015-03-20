class AddSlugToVenueOwner < ActiveRecord::Migration
  def change
    add_column :venue_owners, :slug, :string
  end
end
