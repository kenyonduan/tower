# == Schema Information
#
# Table name: accesses
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  resource_id   :integer
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :access do
    
  end

end
