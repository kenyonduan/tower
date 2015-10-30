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

class TodoList < ActiveRecord::Base
  include Concerns::BasicEventable

  enum list_type: [:defalut, :normal]

  has_many :todos
  has_many :comments, as: :commentable
  belongs_to :project
  belongs_to :creator, class_name: 'User'

  validates :name, presence: true, length: {maximum: 255}
  validates :project_id, :creator_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :list_type, presence: true, inclusion: {in: TodoList.list_types.values, message: "%{value} is not a valid list_type"}
end
