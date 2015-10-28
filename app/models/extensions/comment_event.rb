# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  action           :string
#  type             :string
#  initiator_id     :integer
#  target_id        :integer
#  target_type      :string
#  projectable_id   :integer
#  projectable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

# 单表继承(具体的变化交由子类来实现)
class CommentEvent < Event
  has_one :comment, foreign_key: :event_id
end
