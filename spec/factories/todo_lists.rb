# == Schema Information
#
# Table name: todo_lists
#
#  id         :integer          not null, primary key
#  name       :string
#  project_id :integer
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :todo_list do
    
  end

end
