class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :name
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
