class Comment < ActiveRecord::Base
  # 多种类型的资源都有 Comment
  belongs_to :commentable, polymorphic: true
  has_many :events, as: :resource
end
