# == Schema Information
#
# Table name: todos
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  deadline     :date
#  status       :integer          default(0)
#  creator_id   :integer
#  assignee_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  todo_list_id :integer
#

class Todo < ActiveRecord::Base
  include Concerns::BasicEventable
  include Concerns::Commentable

  enum status: [:started, :pending, :finished, :deleted]

  has_many :comments, as: :commentable
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
  belongs_to :todo_list

  validates :title, presence: true, length: {maximum: 255}
  validates :creator_id, :todo_list_id, numericality: {only_integer: true, greater_than: 0}
  validates :creator_id, :todo_list_id, presence: true
  validates :status, inclusion: {in: Todo.statuses, message: "%{value} is not a valid status"}

  def trigger_created_event
    trigger_event(self.creator_id, '创建了任务')
  end

  def trigger_deleted_event(by)
    self.deleted! # 软删除
    trigger_event(by, '删除了任务')
  end

  def trigger_finished_event(by)
    self.finished!
    trigger_event(by, '完成了任务')
  end

  def trigger_assign_event(by, to)
    trigger_event(by, "给 #{User.find(to).name} 指派了任务")
    update(assignee_id: to)
  end

  def trigger_reassign_event(by, to)
    trigger_event(by, "把 #{assignee.name} 的任务指派给 #{User.find(to).name}")
    update(assignee_id: to)
  end

  def trigger_reschedule_event(by, target_date)
    trigger_event(by, action_2_json('将任务完成时间从 %s 修改为 %s', [self.deadline, target_date]))
    update(deadline: target_date)
  end

  def trigger_event(by, action)
    Event.create(
        action: action,
        initiator_id: by,
        target: self,
        projectable: project
    )
  end

  def project
    todo_list.project
  end
end
