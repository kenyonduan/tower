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
#  creator_id        :integer
#

class CalendarEvent < ActiveRecord::Base
  include Concerns::BasicEventable

  # 可以属于 Calendar 或者 Project
  belongs_to :caleventable, polymorphic: true
  belongs_to :creator, class_name: 'User'
end
