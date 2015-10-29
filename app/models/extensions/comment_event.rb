# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  action           :text
#  type             :string
#  initiator_id     :integer
#  target_id        :integer
#  target_type      :string
#  projectable_id   :integer
#  projectable_type :string
#  detail           :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comment_id       :integer
#

# 单表继承(具体的变化交由子类来实现)
class CommentEvent < Event
  belongs_to :comment

  class << self
    # 多种类型的资源都会有 Comment，所以将 event 相关方法放在这里
    def trigger(params)
      create(params)
    end
  end
end
