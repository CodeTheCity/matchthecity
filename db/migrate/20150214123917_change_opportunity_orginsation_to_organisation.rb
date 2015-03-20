class ChangeOpportunityOrginsationToOrganisation < ActiveRecord::Migration
  def change
  	rename_column :opportunities, :orginsation_id, :organisation_id
  end
end
