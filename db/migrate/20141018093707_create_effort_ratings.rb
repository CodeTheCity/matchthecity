class CreateEffortRatings < ActiveRecord::Migration
  def change
    create_table :effort_ratings do |t|
      t.integer :rating
      t.references :opportunity, index: true

      t.timestamps
    end
  end
end
