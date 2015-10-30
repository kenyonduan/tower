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
#  list_type  :integer
#

FactoryGirl.define do
  factory :todo_list do
    name Faker::Name.title
  end

end
