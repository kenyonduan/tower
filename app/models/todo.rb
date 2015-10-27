class Todo < ActiveRecord::Base
  belongs_to :project
  has_many :comments, as: :commentable
  has_many :events, as: :resource
  belongs_to :creator, class: 'User'
  belongs_to :assignee, class: 'User'

  enum status: [:started, :pending, :finished, :deleted]
end
