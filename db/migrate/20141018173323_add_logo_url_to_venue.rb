class AddLogoUrlToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :logo_url, :string
  end
end
