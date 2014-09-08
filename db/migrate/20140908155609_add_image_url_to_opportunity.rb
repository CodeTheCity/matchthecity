class AddImageUrlToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :image_url, :string
  end
end
