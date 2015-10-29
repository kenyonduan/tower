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

  validates :action, :type, :target_type, presence: true
  validates :initiator_id, :projectable_id, :projectable_type, presence: true, numericality: {only_integer: true, greater_than: 0}

  # Event 负责处理通用的 Action events

  class << self

    def trigger(initiator_id, action, action_params=[], type='Event')
      basic_params = {
          action: action_2_json(action, action_params),
          type: type,
          initiator_id: initiator_id,
          target_id: self.id,
          target_type: self.class.to_s
      }.merge!(projectable_params)
      yield(basic_params) if block_given? # 参数变化交由 block 来处理
      Event.create(basic_params)
    end

    def action_2_json(action, action_params)
      {
          action: action,
          params: action_params
      }.to_json
    end

    def projectable_params
      case self
        when Project
          {projectable_id: self.id, projectable_type: 'Project'}
        when Todo
          {projectable_id: self.project.id, projectable_type: 'Project'}
        when CalendarEvent
          {projectable_id: self.caleventable.id, projectable_type: 'Calendar'}
        when Comment
          {projectable_id: self.commentable.project.id, projectable_type: 'Project'}
        else
          {}
      end
    end
  end
end
