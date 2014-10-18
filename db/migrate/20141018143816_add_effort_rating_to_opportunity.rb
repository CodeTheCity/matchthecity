class AddEffortRatingToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :effort_rating, :integer, :default => 0
  end
end
