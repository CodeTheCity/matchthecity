class AddDayOfWeekToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :day_of_week, :string
  end
end
