class Project < ActiveRecord::Base
  belongs_to :team
  has_many :todos
  has_many :accesses, as: :resource
  has_many :users, through: :accesses
  has_many :events, as: :target
  has_many :calendar_events, as: :caleventable
end
