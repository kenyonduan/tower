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

class Calendar < ActiveRecord::Base
  belongs_to :team
  belongs_to :creator, class_name: 'User'
  has_many :accesses, as: :resource
  has_many :users, through: :accesses
  has_many :calendar_events, as: :caleventable
end
