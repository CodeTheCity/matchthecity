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

class VenueNotice < ActiveRecord::Base
  belongs_to :venue
end
