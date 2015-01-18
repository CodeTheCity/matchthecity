class CreateVenueOwners < ActiveRecord::Migration
  def change
    create_table :venue_owners do |t|
      t.string :name
      t.string :address
      t.string :postcode
      t.string :latitude
      t.string :longitude
      t.string :email
      t.string :telephone
      t.string :web
      t.references :region, index: true
      t.string :logo_url

      t.timestamps
    end
  end
end
