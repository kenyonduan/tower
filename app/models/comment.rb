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

  # 多种类型的资源都有 Comment
  belongs_to :commentable, polymorphic: true
  belongs_to :creator, class_name: 'User'

  validates :content, :commentable_type, :commentable_id, :commentable_type, presence: true
  validates :commentable_id, :creator_id, numericality: {only_integer: true, greater_than: 0}

  def trigger_created_event
    trigger_event(self.creator_id, "回复了#{commentable_name}") { |basic_params| basic_params.merge!(comment_id: self.id) }
  end

  def trigger_deleted_event(by)
    trigger_event(by, '删除了回复') { |basic_params| basic_params.except!(:target_id, :target_type).merge!(detail: self.content) }
    self.destroy
  end

  def commentable_name
    case self.commentable
      when Todo
        '任务'
      when TodoList
        '任务清单'
      else
        'Unkonw'
    end
  end

  def trigger_event(by, action)
    event_params = {
        action: action,
        initiator_id: by,
        target: self,
        projectable_id: commentable.project_id,
        projectable_type: 'Project'
    }
    yield(event_params) if block_given?
    CommentEvent.trigger(event_params)
  end
end
