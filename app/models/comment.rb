# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string
#  event_id         :integer
#  creator_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  # 多种类型的资源都有 Comment
  belongs_to :commentable, polymorphic: true
  belongs_to :comment_event, primary_key: :event_id
  belongs_to :creator, class_name: 'User'

  validates :content, :event_id, :commentable_type, :commentable_id, presence: true
  validates :commentable_id, numericality: {only_integer: true, greater_than: 0}

  after_create :trigger_created_event

  def trigger_created_event

  end
end
