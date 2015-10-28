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

FactoryGirl.define do
  factory :calendar do
    
  end

end
