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
  include Concerns::Eventable

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

  end

  def trigger_deleted_event

  end

  def trigger_finished_event

  end

  def trigger_assign_event

  end

  def trigger_reassign_event

  end

  def trigger_reschedule_event

  end


end
