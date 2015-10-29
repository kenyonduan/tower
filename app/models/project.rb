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
#

class Project < ActiveRecord::Base
  include Concerns::BasicEventable

  belongs_to :team
  has_many :todos
  has_many :accesses, as: :resource
  has_many :users, through: :accesses
  has_many :calendar_events, as: :caleventable

  validates :name, presence: true, length: {maximum: 255}
  validates :project_type, presence: true

  enum project_type: [:standard, :agile]
end
