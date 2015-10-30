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

  it 'should created comment' do
    comment = @todo.commenting(@user.id, 'foobar')
    expect(comment.class).to eq(Comment)
    expect(comment.content).to eq('foobar')
    expect(comment.creator).to eq(@user)
    expect(comment.commentable).to eq(@todo)
  end

  it 'should created event' do
    action = '创建了任务'
    event = @todo.trigger_event(@user.id, action)
    expect(event.class).to eq(Event)
    expect(event.action).to eq(action)
    expect(event.initiator).to eq(@user)
    expect(event.target).to eq(@todo)
    expect(event.projectable).to eq(@project)
  end

  it 'should return todo list project_id' do
    expect(@todo.project_id).to eq(@project.id)
  end
end
