# == Schema Information
#
# Table name: calendar_events
#
#  id                :integer          not null, primary key
#  content           :string
#  begin             :date
#  end               :date
#  remind_time       :date
#  location          :text
#  is_show_creator   :boolean
#  caleventable_id   :integer
#  caleventable_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class CalendarEvent < ActiveRecord::Base
  # 可以属于 Calendar 或者 Project
  belongs_to :caleventable, polymorphic: true
  has_many :events, as: :target
end
