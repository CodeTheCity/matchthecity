class AddSubActivityToOpportunities < ActiveRecord::Migration
  def change
    add_reference :opportunities, :sub_activity, index: true
  end
end
