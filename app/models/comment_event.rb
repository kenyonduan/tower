# 单表继承
class CommentEvent < Event
  has_one :comment, foreign_key: :event_id
end