class CreateVenueNotices < ActiveRecord::Migration
  def change
    create_table :venue_notices do |t|
      t.references :venue, index: true
      t.datetime :starts
      t.datetime :expires
      t.text :message

      t.timestamps
    end
  end
end
