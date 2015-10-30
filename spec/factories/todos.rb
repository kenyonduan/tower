# == Schema Information
#
# Table name: todos
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  deadline     :date
#  status       :integer          default(0)
#  creator_id   :integer
#  assignee_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  todo_list_id :integer
#

FactoryGirl.define do
  factory :todo do
    title Faker::Name.title
    description Faker::Lorem.sentence
  end
end
