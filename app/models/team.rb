class Team < ActiveRecord::Base
  has_many :projects
  has_many :calendars
  has_many :memberships
  has_many :members, through: :memberships, class_name: 'User'
  has_many :events, as: :target
end
