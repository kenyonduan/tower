# 单表继承(具体的变化交由子类来实现)
class CommentEvent < Event
  has_one :comment, foreign_key: :event_id
end