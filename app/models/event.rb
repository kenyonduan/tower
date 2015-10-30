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

class Event < ActiveRecord::Base
  belongs_to :initiator, class_name: 'User'
  # 关系链中最高级别的父对象(Project、Calendar)
  belongs_to :projectable, polymorphic: true
  # 作用与哪个目标对象(Todo)
  belongs_to :target, polymorphic: true

  validates :action, :target_type, :projectable_type, presence: true
  validates :initiator_id, :target_id, :projectable_id, presence: true, numericality: {only_integer: true, greater_than: 0}
end
