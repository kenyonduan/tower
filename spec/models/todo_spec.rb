# == Schema Information
#
# Table name: todos
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  deadline     :date
#  status       :integer
#  creator_id   :integer
#  assignee_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  todo_list_id :integer
#

require 'rails_helper'

RSpec.describe Todo, type: :model do
  before(:all) { init_feeds }
  let(:user_2) { create(:user) }

  it 'should call trigger_event once' do
    allow(@todo).to receive(:trigger_event)
    @todo.trigger_created_event
    expect(@todo).to have_received(:trigger_event).with(@todo.creator_id, '创建了任务').once
  end

  it 'should finished todo' do
    @todo.trigger_finished_event(@user.id)
    expect(@todo.finished?).to eq true
  end

  it 'should assign to user2' do
    @todo.trigger_assign_event(@user.id, user_2.id)
    expect(@todo.assignee_id).to eq(user_2.id)
  end

  it 'should reassign to user2' do
    @todo.assignee = user_2
    @todo.trigger_reassign_event(@user.id, @user.id)
    expect(@todo.assignee_id).to eq(@user.id)
  end

  it 'should reschedule to date' do
    date = Time.parse('2015-10-30').to_date
    @todo.trigger_reschedule_event(@user.id, date)
    expect(@todo.deadline).to eq(date)
  end

  it 'should created comment and comment_event' do
    @todo.commenting(@user.id, 'foobar')

    comment = @todo.comments.last
    expect(comment.content).to eq('foobar')
    expect(comment.creator).to eq(@user)
    expect(comment.commentable).to eq(@todo)

    # 检查 comment after_create callback 所创建的 comment_event
    comment_event = @todo.events.last
    expect(comment_event.comment).to eq(comment)
    expect(comment_event.target).to eq(@todo)
    expect(comment_event.projectable).to eq(@todo.project)
  end

  it 'should created event' do
    @todo.trigger_event(@user.id, '创建了任务')

    event = @todo.events.last
    expect(event.action).to eq('创建了任务')
    expect(event.initiator).to eq(@user)
    expect(event.target).to eq(@todo)
    expect(event.projectable).to eq(@project)
  end

  it 'should return todo list project' do
    expect(@todo.project).to eq(@project)
  end
end
