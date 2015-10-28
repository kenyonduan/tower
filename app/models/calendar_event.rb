class CalendarEvent < ActiveRecord::Base
  # 可以属于 Calendar 或者 Project
  belongs_to :caleventable, polymorphic: true
  has_many :events, as: :target
end
