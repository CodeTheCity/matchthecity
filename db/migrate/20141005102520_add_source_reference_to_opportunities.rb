class AddSourceReferenceToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :source_reference, :string
  end
end
