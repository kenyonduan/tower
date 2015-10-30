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

FactoryGirl.define do
  factory :calendar_event do
    
  end

end
