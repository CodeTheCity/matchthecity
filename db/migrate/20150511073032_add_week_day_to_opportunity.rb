class AddWeekDayToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :week_day, :integer
  end
end
