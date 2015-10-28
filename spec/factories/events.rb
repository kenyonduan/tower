# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  action           :string
#  type             :string
#  initiator_id     :integer
#  target_id        :integer
#  target_type      :string
#  projectable_id   :integer
#  projectable_type :string
#  detail           :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :event do
    
  end

end
