class AddSourceReferenceToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :source_reference, :string
  end
end
