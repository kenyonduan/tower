# == Schema Information
#
# Table name: calendars
#
#  id         :integer          not null, primary key
#  name       :string
#  creator_id :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Calendar, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
