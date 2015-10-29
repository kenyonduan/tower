# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  deadline    :date
#  status      :integer          default(0)
#  project_id  :integer
#  creator_id  :integer
#  assignee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Todo < ActiveRecord::Base
  include Concerns::BasicEventable

  belongs_to :project
  has_many :comments, as: :commentable
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User'

  validates :title, presence: true, length: {maximum: 255}
  validates :creator_id, :project_id, :assignee_id, numericality: {only_integer: true, greater_than: 0}
  validates :creator_id, :project_id, presence: true

  enum status: [:started, :pending, :finished, :deleted]

  after_create :trigger_created_event
  after_destroy :trigger_deleted_event

  def trigger_created_event
    Event.trigger(self.creator_id, '创建了任务')
  end

  def trigger_deleted_event(by)
    self.deleted!
    Event.trigger(by, '删除了任务')
  end

  def trigger_finished_event(by)
    self.finished!
    Event.trigger(by, '完成了任务')
  end

  def trigger_assign_event(by, to)
    Event.trigger(by, "给 #{User.find(to).name} 指派了任务")
    update(assignee_id: to)
  end

  def trigger_reassign_event(by, to)
    Event.trigger(by, "把 #{assignee.name} 的任务指派给 #{User.find(to).name}")
    update(assignee_id: to)
  end

  def trigger_reschedule_event(by, target_date)
    Event.trigger(by, '将任务完成时间从 %s 修改为 %s', [self.deadline, target_date])
    update(deadline: target_date)
  end
end
