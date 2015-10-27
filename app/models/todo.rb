class Todo < ActiveRecord::Base
  belongs_to :project
  has_many :comments, as: :commentable
  has_many :events, as: :eventable
end
