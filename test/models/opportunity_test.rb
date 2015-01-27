# == Schema Information
#
# Table name: opportunities
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  category         :string(255)
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  activity_id      :integer
#  sub_activity_id  :integer
#  venue_id         :integer
#  room             :string(255)
#  start_time       :string(255)
#  end_time         :string(255)
#  day_of_week      :string(255)
#  image_url        :string(255)
#  source_reference :string(255)
#  effort_rating    :integer          default(0)
#  orginsation_id   :integer
#

require 'test_helper'

class OpportunityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
