class CandidatesSkills < ActiveRecord::Migration
  def self.up
    create_table :candidates_skills, :id => false do |t|
      t.integer :candidate_id
      t.integer :skill_id
    end

    add_index :candidates_skills, [:candidate_id, :skill_id]
  end

  def self.down
    drop_table :candidates_skills
  end

end
