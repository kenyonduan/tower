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

require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:all) { init_feeds }
  let(:event) { @todo.events.first }

  it 'should have received publish 1 time' do
    allow(MessageBus).to receive(:publish)
    event.realtime_push_to_client
    expect(MessageBus).to have_received(:publish).once
  end

  it 'should response notify hash' do
    allow(Event).to receive(:record_timestamps).and_return(false)

    notify_hash = event.notify_hash
    expect(except_date(notify_hash.delete(:target))).to eq({
                                                               "title" => @todo.title,
                                                               "description" => @todo.description,
                                                               "deadline" => @todo.deadline,
                                                               "status" => @todo.status,
                                                               "creator_id" => @todo.creator_id,
                                                               "assignee_id" => @todo.assignee_id,
                                                               "todo_list_id" => @todo.todo_list_id
                                                           })
    expect(except_date(notify_hash.delete(:projectable))).to eq({
                                                                    "name" => @todo.project.name,
                                                                    "team_id" => @todo.project.team_id,
                                                                    "description" => @todo.project.description,
                                                                    "guest_lockable" => @todo.project.guest_lockable,
                                                                    "project_type" => @todo.project.project_type,
                                                                    "creator_id" => @todo.project.creator_id
                                                                })
    expect(except_date(notify_hash.delete(:initiator))).to eq({
                                                                  "password_digest" => @todo.creator.password_digest,
                                                                  "email" => @todo.creator.email,
                                                                  "name" => @todo.creator.name
                                                              })
    expect(except_date(notify_hash)).to eq({
                                               "action" => "创建了任务",
                                               "initiator_id" => @todo.creator.id,
                                               "target_id" => @todo.id,
                                               "target_type" => @todo.class.to_s,
                                               "projectable_id" => @todo.project.id,
                                               "projectable_type" => @todo.project.class.to_s,
                                               "detail" => nil,
                                               "comment_id" => nil,
                                               :type => nil,
                                               :comment => nil
                                           })
  end
end
