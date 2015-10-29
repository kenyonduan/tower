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
  belongs_to :creator, class_name: 'User'
  has_many :todo_lists
  has_many :accesses, as: :resource
  has_many :users, through: :accesses
  has_many :calendar_events, as: :caleventable

  validates :name, presence: true, length: {maximum: 255}
  validates :team_id, :project_type, presence: true, numericality: {only_integer: true, greater_than: 0}

  enum project_type: [:standard, :agile]

  after_create :init_default_todo_list

  def default_todo_list
    todo_lists.where(list_type: TodoList.list_types[:defalut])
  end

  private
  def init_default_todo_list
    TodoList.create(
        name: '未归类任务',
        list_type: TodoList.list_types[:defalut],
        project_id: self.id,
        creator_id: self.creator_id
    )
  end
end
