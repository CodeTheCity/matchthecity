class AddActivityToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :activity_id, :integer
  end
end
