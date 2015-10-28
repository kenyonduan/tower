# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  password_digest :string
#  email           :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    
  end

end
