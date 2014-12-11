# == Schema Information
#
# Table name: effort_ratings
#
#  id             :integer          not null, primary key
#  rating         :integer
#  opportunity_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'test_helper'

class EffortRatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
