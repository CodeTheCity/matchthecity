class AddOrginisationToOpportunity < ActiveRecord::Migration
  def change
    add_reference :opportunities, :orginsation, index: true
  end
end
