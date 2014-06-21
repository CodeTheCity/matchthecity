class OpportunitiesSkills < ActiveRecord::Migration
  def self.up
    create_table :opportunities_skills, :id => false do |t|
      t.integer :opportunity_id
      t.integer :skill_id
    end

    add_index :opportunities_skills, [:opportunity_id, :skill_id]
  end

  def self.down
    drop_table :opportunities_skills
  end
end
