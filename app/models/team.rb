# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ActiveRecord::Base
  has_many :projects
  has_many :calendars
  has_many :memberships
  has_many :members, through: :memberships, class_name: 'User'
end
