class AddTimeToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :start_time, :string
    add_column :opportunities, :end_time, :string
  end
end
