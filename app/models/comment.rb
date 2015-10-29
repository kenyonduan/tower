# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string
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

  validates :content, :commentable_type, :commentable_id, presence: true
  validates :commentable_id, numericality: {only_integer: true, greater_than: 0}

  def trigger_created_event(by)
    CommentEvent.trigger(by, "回复了#{commentable_name}", []) { |basic_params| basic_params.merge!(comment_id: self.id) }
  end

  def trigger_deleted_event(by)
    CommentEvent.trigger(by, '删除了回复', []) { |basic_params| basic_params.merge!(detail: self.content) }
  end

  def commentable_name
    case self.commentable
      when Todo
        '任务'
      else
        'Unkonw'
    end
  end
end
