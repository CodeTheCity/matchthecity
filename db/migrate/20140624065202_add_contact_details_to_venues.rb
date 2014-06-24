class AddContactDetailsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :email, :string
    add_column :venues, :telephone, :string
    add_column :venues, :web, :string
  end
end
