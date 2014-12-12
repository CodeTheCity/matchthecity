# == Schema Information
#
# Table name: venue_notices
#
#  id         :integer          not null, primary key
#  venue_id   :integer
#  starts     :datetime
#  expires    :datetime
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class VenueNoticeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
