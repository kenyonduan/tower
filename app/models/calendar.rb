class Calendar < ActiveRecord::Base
  belongs_to :team
  belongs_to :creator, class: 'User'
  has_many :accesses, as: :resource
  has_many :users, through: :accesses
  has_many :calendar_events, as: :caleventable
end
