class Comment < ActiveRecord::Base
  # 多种类型的资源都有 Comment
  belongs_to :commentable, polymorphic: true
  belongs_to :comment_event, primary_key: :event_id
end
