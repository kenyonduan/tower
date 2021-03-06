# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string
#  team_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  description    :text
#  guest_lockable :boolean          default(FALSE)
#  project_type   :integer
#  creator_id     :integer
#

FactoryGirl.define do
  factory :project do
    name Faker::App.name
  end

end
