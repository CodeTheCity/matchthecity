class AddRoomToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :room, :string
  end
end
