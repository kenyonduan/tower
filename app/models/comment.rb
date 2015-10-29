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
  include Concerns::BasicEventable
  has_many :comment_events, through: :events
  # 多种类型的资源都有 Comment
  belongs_to :commentable, polymorphic: true
  belongs_to :creator, class_name: 'User'

  validates :content, :event_id, :commentable_type, :commentable_id, presence: true
  validates :commentable_id, numericality: {only_integer: true, greater_than: 0}

  after_create :trigger_created_event
  after_destroy :trigger_deleted_event

  def trigger_created_event

  end

  def trigger_deleted_event

  end

  def trigger_comment_event(initiator_id, action, action_params=[])
    CommentEvent.create(

    )
  end
end
