# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  deadline    :date
#  status      :integer          default(0)
#  project_id  :integer
#  creator_id  :integer
#  assignee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :todo do
    
  end

end
