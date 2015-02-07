class CreateOrganisationsUsers < ActiveRecord::Migration
  def self.up
      create_table :organisations_users, :id => false do |t|
          t.references :organisation
          t.references :user
      end
      add_index :organisations_users, [:organisation_id, :user_id], :name => 'org_user_index'
      add_index :organisations_users, [:user_id, :organisation_id], :name => 'user_org_index'
    end

    def self.down
      drop_table :organisations_users
    end
end
