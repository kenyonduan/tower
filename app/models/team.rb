# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :integer
#

class Team < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :projects
  has_many :calendars
  has_many :memberships
  has_many :members, through: :memberships, class_name: 'User'

  validates :name, presence: true, length: {maximum: 255}
  validates :creator_id, presence: true, numericality: {only_integer: true, greater_than: 0}
end
