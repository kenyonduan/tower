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

class TodoList < ActiveRecord::Base
  include Concerns::BasicEventable

  has_many :todos
  has_many :comments, as: :commentable
  belongs_to :project
  belongs_to :creator, class_name: 'User'

  enum list_type: [:defalut, :normal]
end
