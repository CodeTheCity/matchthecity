class CreateSubActivities < ActiveRecord::Migration
  def change
    create_table :sub_activities do |t|
      t.references :activity, index: true
      t.string :title

      t.timestamps
    end
  end
end
