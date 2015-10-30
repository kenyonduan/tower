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

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) { init_feeds }
  let(:action) { '回复了任务' }

  it 'should have received trigger_event(1, "回复了任务") 1 time' do
    allow(@todo_comment).to receive(:trigger_event)
    @todo_comment.trigger_created_event
    expect(@todo_comment).to have_received(:trigger_event).with(@todo_comment.creator_id, action).once
  end

  it 'comment should be destroyed' do
    @todo_comment.trigger_deleted_event(@user.id)
    expect(@todo_comment.destroyed?).to be_truthy
  end

  it 'commentable_name should eq target' do
    expect(@todo_comment.commentable_name).to eq('任务')
    expect(@todo_list_comment.commentable_name).to eq('任务清单')

    @todo_list_comment.commentable = nil
    expect(@todo_list_comment.commentable_name).to eq('Unkonw')
  end

  it 'should created CommentEvent' do
    @todo_comment.trigger_event(@user.id, action)
    comment_event = Event.last
    expect(comment_event.class).to eq(CommentEvent)
    expect(comment_event.action).to eq(action)
    expect(comment_event.initiator).to eq(@user)
    expect(comment_event.target).to eq(@todo_comment.commentable)
    expect(comment_event.projectable).to eq(@todo_comment.commentable.project)
  end
end
