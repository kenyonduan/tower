class TodoList < ActiveRecord::Base
  include Concerns::BasicEventable

  has_many :todos
  has_many :comments, as: :commentable
  belongs_to :project
  belongs_to :creator, class_name: 'User'

  enum list_type: [:defalut, :normal]
end
